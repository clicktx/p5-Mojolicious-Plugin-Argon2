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

use Crypt::Argon2 qw/argon2i_pass argon2i_verify/;
my $t_cost      = 3;
my $m_factor    = '32M';
my $parallelism = 1;
my $tag_size    = 16;
my $secret      = 'password';
my $salt        = 'saltSalt';
say argon2i_pass( $secret, $salt, $t_cost, $m_factor, $parallelism, $tag_size );

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('Hello Mojo!');

done_testing();
