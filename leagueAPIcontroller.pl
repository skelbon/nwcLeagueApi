use Mojolicious::Lite -signatures;
require './leagueAPImodel.pl';

# Returns a list of all clubs in the league
get '/api/clubslist' => sub ($c) {
    my $clubs = fetchAllClubsAndIds();
    $c->render( json => $clubs );
};

# Returns general club info, address, general email, website, google map etc
get '/api/clubinfo' => sub ($c) {
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
get '/api/teams' => sub ($c) {
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
get 'api/teamslist' => sub ($c) {
    my $teams = fetchAllTeamsAndIds();
    $c->render( json => $teams );
};

get '/api/teaminfo' => sub ($c) {
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

app->start;

