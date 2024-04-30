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

        # my %clubdata = ( "$clubname" => "$clubid" );

        @clubsdata{$clubname} = $clubid;

    }

    return \%clubsdata;

}

sub fetchClubInfo {
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

sub fetchTeamsByClub {
    my $id   = shift;
    my $page = getPageTree("showclub?clubid=$id&st=1");

    foreach my $data (
        $page->look_down(
            _tag  => 'td',
            class => 'boxleft'
        )
      )
    {
        ## TODO - collect the team names - we'll also a want to collect the division for each team.
    }

}

sub getClubIdByName {
    my $name      = shift;
    my $clubsData = fetchAllClubsAndIds();
    my $clubId    = $clubsData->{$name};
    return defined ? $clubId : 0;

}
1;
