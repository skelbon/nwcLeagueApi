use strict;
use warnings;
use feature qw/ say /;
use LWP::UserAgent;
use HTML::TreeBuilder;
use Encode qw(decode_utf8);
use JSON;

my $ua = LWP::UserAgent->new;
$ua->agent("League Scraper");

sub fetchAllClubsAndIds {

    my $url =
"https://nwcounties.leaguemaster.co.uk/cgi-county/icounty.exe/showclublist";
    my $root    = HTML::TreeBuilder->new();
    my $request = $ua->get($url) or die "Cannot contact LeagueMaster $!\n";

    if ( $request->is_success ) {
        $root->parse( decode_utf8 $request->content );
    }
    else {
        print "Cannot fetch the resource.\n"
          ;    ## Fix me. Sort out an error handling scheme..
    }

    my @clubsdata = ();

    foreach my $data (
        $root->look_down(
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

        my %clubdata = ( "$clubname" => "$clubid" );

        push @clubsdata, \%clubdata;

    }

    return \@clubsdata;

}

sub fetchClubInfo {
    my $id = shift;
    return { "club_id" => $id };
}
1;
