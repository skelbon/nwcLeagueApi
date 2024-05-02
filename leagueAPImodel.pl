use strict;
use warnings;
use feature qw/ say /;
use LWP::UserAgent;
use HTML::TreeBuilder;
use Encode qw(decode_utf8);
use JSON;
use Data::Dumper;

my $baseUrl = "https://nwcounties.leaguemaster.co.uk/cgi-county/icounty.exe/";
my $ua      = LWP::UserAgent->new;
$ua->agent("League Scraper");

sub getPageTree {
    my $page = shift;

    my $url     = $baseUrl . $page;
    my $root    = HTML::TreeBuilder->new();
    my $request = $ua->get($url) or die "Cannot contact LeagueMaster $!\n";

    if ( $request->is_success ) {
        $root->parse( decode_utf8 $request->content );
    }
    else {
        print "Cannot fetch the resource.\n"
          ;    ## Fix me. Sort out an error handling scheme..
    }
    return $root;
}

sub fetchAllClubsAndIds {

    my %clubsdata = ();
    my $page      = getPageTree("showclublist");
    foreach my $data (
        $page->look_down(
            _tag  => "td",
            class => "boxleft",
        )
      )
    {

        # Last table entry is not required - let's bail.
        if ( $data->look_down( _tag => 'em' ) ) { last }

        my $clubname      = $data->as_text;
        my $club_info_url = $data->look_down( _tag => "a" )->attr('href');

        # Default clubid = 0 if url fails for some reason.
        my $clubid = 0;

        if ( $club_info_url =~ /clubid=(\d+)/ ) {
            $clubid = $1;
        }

        @clubsdata{$clubname} = $clubid;

    }

    return \%clubsdata;

}

sub fetchClubInfo {
    ## returns empty fields if id does not exist - and that's okay.
    my $id     = shift;
    my $page   = getPageTree("showclub?clubid=$id&st=1");
    my %fields = ();

    foreach my $data (
        $page->look_down(
            _tag  => "tr",
            class => qr{^(firstRow|secondRow)}
        )
      )
    {
        my $k = $data->look_down( _tag => "th" )->as_text =~ s/://r;
        my $v = $data->look_down( _tag => "td" )->as_text;
        if ( $k =~ /Fixtures/ ) { last }
        if ( $v eq 'Map link' ) {
            $v = $data->look_down( _tag => "a" )->attr('href');
        }
        my %tableHash = ( $k => $v );
        $fields{$k} = $v;
    }

    return \%fields;
}

sub fetchTeamsByClubId {
    my $id   = shift;
    my $page = getPageTree("showclub?clubid=$id&st=1");
    my $teams_td;
    my %teams;

    foreach my $table (
        $page->look_down(
            _tag => 'table',
        )
      )
    {
        $teams_td = $table->look_down( _tag => 'td', class => 'title' );
        if ( $teams_td && $teams_td->as_text =~ /Teams/ ) {
            $teams_td = $table;
            last;
        }
    }

    foreach my $team_tr (
        $teams_td->look_down(
            _tag  => 'tr',
            class => qr{^(firstRow|secondRow)}
        )
      )
    {
        my $teamName =
          $team_tr->look_down( _tag => 'td', class => 'boxleft' )->as_text;

        my $division =
          $team_tr->look_down( _tag => 'td', class => 'boxmain' )->as_text;

        $teams{$teamName} = $division;
    }

    return \%teams;

}

sub fetchAllTeamsAndIds {

    my %teamsdata = ();
    my $page      = getPageTree("showteamlist");
    foreach my $data (
        $page->look_down(
            _tag  => "td",
            class => "boxleft",
        )
      )
    {

        # Last table entry is not required - let's bail.
        if ( $data->look_down( _tag => 'em' ) ) { last }

        my $teamname      = $data->as_text;
        my $club_info_url = $data->look_down( _tag => "a" )->attr('href');

        # Default clubid = 0 if url fails for some reason.
        my $clubid = 0;

        if ( $club_info_url =~ /teamid=(\d+)/ ) {
            $clubid = $1;
        }

        @teamsdata{$teamname} = $clubid;

    }

    return \%teamsdata;

}

sub fetchTeamInfo {
    my $team_id              = shift;
    my $page                 = getPageTree("showteam?teamid=$team_id");
    my %fields               = ();
    my $reserve_contact_info = {};

    foreach my $data (
        $page->look_down( _tag => "tr", class => qr{^(firstRow|secondRow)} ) )
    {
        my $k = $data->look_down( _tag => "th" )->as_text =~ s/://r;
        my $v = $data->look_down( _tag => "td" )->as_text;

        if ( $k =~ qr{Reserve Contact} ) {
            $reserve_contact_info->{$k} = $v;
            next;
        }

        if (%$reserve_contact_info) {
            $reserve_contact_info->{$k} = $v;
        }
        else {
            $fields{$k} = $v;
        }

        last if $k =~ /Club details/;
    }
    $fields{'Reserve Contact'} = $reserve_contact_info;
    return \%fields;
}

sub fetchFixturesByTeam {
    my $teamid   = shift;
    my $page     = getPageTree("showteamfixtures?teamid=$teamid");
    my @fixtures = ();

    my $title_td = $page->look_down( _tag => 'td', class => 'title' );
    my ($teamname) = $title_td->as_text =~ qr{(.*?):};

    foreach
      my $dataRow ( $page->look_down( _tag => "tr", class => qr{DoneRow} ) )
    {
        my @v = ();
        foreach my $data ( $dataRow->look_down( _tag => 'td' ) ) {
            push @v, $data->as_text;
        }

        push @fixtures,
          {
            'team'     => $teamname,
            'date'     => $v[1],
            'venue'    => $v[2],
            'opponent' => $v[3]
          };
    }

    return { "fixtures" => \@fixtures };
}

sub fetchFixturesByClub {
    my %params   = @_;
    my $id       = $params{'clubid'};
    my $clubname = $params{'clubname'} || getClubNameById( $params{'clubid'} );

    my $teamslist = fetchAllTeamsAndIds();
    my @clubsTeamIds;
    my @fixtures;

    foreach my $teamname ( keys %$teamslist ) {
        if ( $teamname =~ /^$clubname\s+\d+$/ ) {
            push @clubsTeamIds, $teamslist->{$teamname};
        }
    }

    foreach my $teamid (@clubsTeamIds) {
        push @fixtures, fetchFixturesByTeam($teamid);
    }

    return { 'fixtures' => \@fixtures };
}

sub getClubIdByName {
    my $name      = shift;
    my $clubsData = fetchAllClubsAndIds();
    my $clubId    = $clubsData->{$name};
    return defined $clubId ? $clubId : 0;

}

sub getTeamIdByName {
    my $name      = shift;
    my $clubsData = fetchAllTeamsAndIds();
    my $teamId    = $clubsData->{$name};
    return defined $teamId ? $teamId : 0;

}

sub getClubNameById {
    my $id         = shift;
    my $clubsData  = fetchAllClubsAndIds();
    my ($clubname) = grep { $clubsData->{$_} eq $id } keys %$clubsData;
    return $clubname;
}
1;
