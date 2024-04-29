use Test::More;
use Mojo::File qw/ curfile /;
use Test::Mojo;

my $script = curfile->dirname->sibling('leagueAPIcontroller.pl');

my $t = Test::Mojo->new($script);

## /clublist
$t->get_ok('/clublist')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )
  ->content_like( qr/^\[/, 'Expecting JSON array in the response body' )
  ->content_like( qr/\]$/, 'Expecting JSON array in the response body' )
  ->content_like( qr/Moss Side":"145"/,
    'Expecting Moss Side to be in the response with correct id(145)' );
## /club?id=...
$t->get_ok('/club')->status_is(400);
$t->get_ok('/club?id=145')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )
  ->json_has( '/club_id', 'expecting a club id in response' );
done_testing();

1;
