use Test::More;
use Mojo::File qw/ curfile /;
use Test::Mojo;

my $script = curfile->dirname->sibling('leagueAPIcontroller.pl');

my $t = Test::Mojo->new($script);

## /clublist
$t->get_ok('/api/clublist')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )->json_is(
    '/Moss Side' => 145,
    'Expect result to have Moss Side with correct clubid'
  );
## /club?id=...
$t->get_ok('/api/club')->status_is(400);
$t->get_ok('/api/club?id=145')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )
  ->json_has( '/Address',     'expecting an Address key' )
  ->json_has( '/Directions',  'expecting a Directions key' )
  ->json_has( '/Email',       'expecting an Email key' )
  ->json_has( '/Fixture Sec', 'expecting a Fixture key' )
  ->json_has( '/Manager',     'expecting a Manager key' )
  ->json_has( '/Map',         'expecting a Map key' )
  ->json_has( '/Mobile',      'expecting a Mobile key' )
  ->json_has( '/Phone',       'expecting a Phone key' )
  ->json_has( '/Website',     'expecting a Website key' );
$t->get_ok('/api/club?id=Moss Side')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )
  ->json_has( '/Address',     'expecting an Address key' )
  ->json_has( '/Directions',  'expecting a Directions key' )
  ->json_has( '/Email',       'expecting an Email key' )
  ->json_has( '/Fixture Sec', 'expecting a Fixture key' )
  ->json_has( '/Manager',     'expecting a Manager key' )
  ->json_has( '/Map',         'expecting a Map key' )
  ->json_has( '/Mobile',      'expecting a Mobile key' )
  ->json_has( '/Phone',       'expecting a Phone key' )
  ->json_has( '/Website',     'expecting a Website key' );
## /club?name=...
$t->get_ok('/api/club?name=Bad Name')->status_is(404);
## /teams?name
$t->get_ok('/api/teams?name=Bad Name')->status_is(404);
$t->get_ok('/api/teams?name=Moss Side')->status_is(200);
done_testing();

1;
