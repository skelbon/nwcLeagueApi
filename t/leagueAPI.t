use Test::More;
use Mojo::File qw/ curfile /;
use Test::Mojo;

my $script = curfile->dirname->sibling('leagueAPIcontroller.pl');

my $t = Test::Mojo->new($script);

## /clublist
$t->get_ok('/clublist')
  ->status_is(
    200)    ## Change the model to return a hash then use the json_has method...
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )
  ->content_like( qr/^\[/, 'Expecting JSON array in the response body' )
  ->content_like( qr/\]$/, 'Expecting JSON array in the response body' )
  ->content_like( qr/Moss Side":"145"/,
    'Expecting Moss Side to be in the response with correct id(145)' );
## /club?id=...
$t->get_ok('/club')->status_is(400);
$t->get_ok('/club?id=145')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )
  ->json_has( '/Address',     'expecting an Address key' )
  ->json_has( '/Directions',  'expecting a Directions key' )
  ->json_has( '/Email',       'expecting a Email key' )
  ->json_has( '/Fixture Sec', 'expecting a Fixture key' )
  ->json_has( '/Manager',     'expecting a Manager key' )
  ->json_has( '/Map',         'expecting a Map key' )
  ->json_has( '/Mobile',      'expecting a Mobile key' )
  ->json_has( '/Phone',       'expecting a Phone key' )
  ->json_has( '/Website',     'expecting a Website key' );

done_testing();

1;
