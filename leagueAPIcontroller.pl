use Mojolicious::Lite -signatures;
require './leagueAPImodel.pl';

# Returns a list of all clubs in the league
get '/clubslist' => sub ($c) {
    my $clubs = fetchAllClubsAndIds();
    $c->render( json => $clubs );
};

# Returns general club info, address, general email, website, google map etc
get '/clubinfo' => sub ($c) {
    my $id   = $c->param('clubid');
    my $name = $c->param('clubname');

    unless ( $id || $name ) {
        return $c->render(
            json =>
'400 Bad Request: Missing query parameter clubname or id required',
            status => 400
        );
    }

    if ( $name && !$id ) {
        $id = getClubIdByName($name);
        unless ($id) {
            return $c->render(
                json   => "404 Not found: Club $name not found",
                status => 404
            );
        }
    }

    my $clubinfo = fetchClubInfo($id);
    $c->render( json => $clubinfo );
};

# Returns a list of teams for a given club id or name
get '/teams' => sub ($c) {
    my $id   = $c->param('clubid');
    my $name = $c->param('clubname');

    unless ( $id || $name ) {
        return $c->render(
            json =>
'400 Bad Request: Missing query parameter club name or id required',
            status => 400
        );
    }

    if ( $name && !$id ) {
        $id = getClubIdByName($name);
        unless ($id) {
            return $c->render(
                json   => "404 Not found: Club $name not found",
                status => 404
            );
        }
    }

    my $clubteams = fetchTeamsByClubId($id);
    $c->render( json => $clubteams );
};

# Returns a list of all teams in league
get '/teamslist' => sub ($c) {
    my $teams = fetchAllTeamsAndIds();
    $c->render( json => $teams );
};

get '/teaminfo' => sub ($c) {
    my $id   = $c->param('teamid');
    my $name = $c->param('teamname');

    unless ( $id || $name ) {
        return $c->render(
            json =>
'400 Bad Request: Missing query parameter teamname or teamid required',
            status => 400
        );
    }

    if ( $name && !$id ) {
        $id = getTeamIdByName($name);
        unless ($id) {
            return $c->render(
                json   => "404 Not found: Team $name not found",
                status => 404
            );
        }
    }

    my $teaminfo = fetchTeamInfo($id);
    $c->render( json => $teaminfo );
};

# Returns fixtures for a given team or all of a clubs teams if a clubid or clubname are passed in the query params
get '/fixtures' => sub ($c) {

    my $clubid   = $c->param('clubid');
    my $clubname = $c->param('clubname');

    my $id   = $clubid   || $c->param('teamid');
    my $name = $clubname || $c->param('teamname');

    my $is_club = $clubid || $clubname ? 1 : 0;

    unless ( $id || $name ) {
        return $c->render(
            json =>
'400 Bad Request: Missing query parameter. One of teamid/teamname or clubid/clubname is required ',
            status => 400
        );
    }

    if ( $name && !$id ) {
        $id = $is_club ? getClubIdByName($name) : getTeamIdByName($name);
        unless ($id) {
            return $c->render(
                json   => "404 Not found: $name not found",
                status => 404
            );
        }
    }

    my $fixtures =
      $is_club
      ? fetchFixturesByClub( clubid => $id, clubname => $clubname )
      : fetchFixturesByTeam($id);
    $c->render( json => $fixtures );

};

get '/' => sub {
    my $c = shift;
    
    my $json_file = './endpoints.json';
    
    if (-e $json_file) {
        $c->res->headers->content_type('application/json');
        $c->reply->file($json_file);
    } else {
        $c->reply->not_found;
    }
};
app->start;

