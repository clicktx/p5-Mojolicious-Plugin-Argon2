use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Argon2';

get '/' => sub {
    my $c = shift;
    my $encoded = $c->argon2( 'password', 'somesalt' );
    say "Yaaa!!!: " . $encoded;
    $c->render( text => 'Hello Mojo!' );
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('Hello Mojo!');

done_testing();
