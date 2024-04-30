use Mojolicious::Lite -signatures;
require './leagueAPImodel.pl';

get '/api/clublist' => sub ($c) {
    my $clubs = fetchAllClubsAndIds();
    $c->render( json => $clubs );
};

get '/api/club' => sub ($c) {
    my $id = $c->param('id');
    unless ($id) {
        return $c->render(
            json   => '400 Bad Request: Missing "id" query parameter',
            status => 400
        );
    }
    my $clubinfo = fetchClubInfo($id);
    $c->render( json => $clubinfo );
};

app->start;

