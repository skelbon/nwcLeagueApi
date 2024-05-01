use Test::More;
use Mojo::File qw/ curfile /;
use Test::Mojo;

my $script = curfile->dirname->sibling('leagueAPIcontroller.pl');

my $t = Test::Mojo->new($script);

## /clubslist
$t->get_ok('/api/clubslist')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )->json_is(
    '/Moss Side' => 145,
    'Expect result to have Moss Side with correct clubid'
  );

## /clubinfo?clubid=...
$t->get_ok('/api/clubinfo')->status_is(400);
$t->get_ok('/api/clubinfo?clubid=145')->status_is(200)
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
$t->get_ok('/api/clubinfo?clubname=Moss Side')->status_is(200)
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

## /clubinfo?clubname=...
$t->get_ok('/api/clubinfo?clubname=Bad Name')->status_is(404);

## /teams?clubname=
$t->get_ok('/api/teams?clubname=Bad Name')->status_is(404);
$t->get_ok('/api/teams?clubname=Moss Side')->status_is(200)
  ->json_has( '/Moss Side 1',
    'expecting a first team from any club in league' );

## /teams?clubid=
$t->get_ok('/api/teams?clubid=145')->status_is(200)
  ->json_has( '/Moss Side 1',
    'expecting a first team from any club in league' );

## /teamslist
$t->get_ok('/api/teamslist')->status_is(200)
  ->header_is( 'Content-Type' => 'application/json;charset=UTF-8' )->json_is(
    '/Moss Side 1' => 468,
    'Expect result to have team Moss Side 1 with correct teamid'
  );

## /teaminfo
$t->get_ok('/api/teaminfo?teamid=468')->status_is(200);
$t->get_ok('/api/teaminfo?teamname=Doesnt Exist')->status_is(404);
$t->get_ok('/api/teaminfo?teamname=Moss Side 1')->status_is(200)
  ->json_has('/Mobile')->json_has('/Phone')->json_has('/Phone 2')
  ->json_has('/Team Contact')->json_has('/Reserve Contact')->json_has('/Email');
$t->get_ok('/api/teaminfo?teamid=468')->status_is(200)->json_has('/Mobile')
  ->json_has('/Phone')->json_has('/Phone 2')->json_has('/Team Contact')
  ->json_has('/Reserve Contact')->json_has('/Email')
  ->json_has('/Reserve Contact/Email')->json_has('/Email');

## /clubfixtures - respond with team or club fixtures dependant on query params given.
$t->get_ok('/api/fixtures?teamid=468')->status_is(200)
  ->json_has('/fixtures/1/date')->json_has('/fixtures/1/venue')
  ->json_has('/fixtures/1/opponent');

done_testing();

1;
