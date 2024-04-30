use Mojolicious::Lite -signatures;
require './leagueAPImodel.pl';

get '/api/clublist' => sub ($c) {
    my $clubs = fetchAllClubsAndIds();
    $c->render( json => $clubs );
};

get '/api/club' => sub ($c) {
    my $id   = $c->param('id');
    my $name = $c->param('name');

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

get '/api/teams' => sub ($c) {
    my $id = $c->param('id');
    unless ($id) {
        return $c->render(
            json   => '400 Bad Request: Missing "id" query parameter',
            status => 400
        );
    }
    my $clubteams = fetchTeamsInfo($id);
    $c->render( json => $clubteams );
};

app->start;

