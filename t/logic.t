use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Argon2';

get '/crypt' => sub {
    my $c = shift;

    my ( $p, $s ) = map { $c->param($_) } qw/p s/;
    my $encoded = $c->argon2( $p, $s );

    $c->render( text => $encoded );
};

get '/verify' => sub {
    my $c = shift;

    my ( $e, $p ) = map { $c->param($_) } qw/e p/;
    my $ok = $c->argon2_verify( $e, $p );

    $c->render( text => ( $ok ? 'Pass' : 'Fail' ) );
};

my $t    = Test::Mojo->new();
my @data = <DATA>;

for (@data) {
    chomp;
    my ( $encoded, $password, $salt ) = split / /;

    $t->get_ok("/crypt?p=$password&s=$salt")->status_is(200)
      ->content_is($encoded);
    $t->get_ok("/verify?e=$encoded&p=$password")->status_is(200)
      ->content_is('Pass');
}

my $password = 'my_secret_password';
my $salt     = 'my_salt_is_salt';
my $encoded  = app->argon2( $password, $salt );

ok app->argon2_verify( $encoded, $password ), 'accept ok';
ok !app->argon2_verify( $encoded, 'bad_password' ), 'deny ok';

my $encoded2 = app->argon2( $password, $salt );
is $encoded, $encoded2, 'recrypt ok';

done_testing();

__DATA__
$argon2i$v=19$m=32768,t=3,p=1$c29tZXNhbHQ$Fs6DpOvXW4tTP77Nyoc1Yg password somesalt
$argon2i$v=19$m=32768,t=3,p=1$c29tZXNhbHQ$bly53iw6d5z42WZ7XesTmg mypass++. somesalt
$argon2i$v=19$m=32768,t=3,p=1$c29tZXNhbHQ$50nGXz06azbib5k1nQwZIA mypass++.<>&%$laws()'~ somesalt
$argon2i$v=19$m=32768,t=3,p=1$c29tZXNhbHRzb21lc2FsdHNvbWVzYWx0$v03Jvqzqj13pJuiIjCiycA password somesaltsomesaltsomesalt
