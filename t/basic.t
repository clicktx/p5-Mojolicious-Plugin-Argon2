use Mojo::Base -strict;
use Test::More;

use Crypt::Argon2 qw/argon2i_pass argon2i_verify/;
my $t_cost      = 2;
my $m_factor    = '16M';
my $parallelism = 1;
my $tag_size    = 16;
my $secret      = 'password';
my $salt        = 'saltSalt';

say "test start";

my $res;
eval { $res = argon2i_pass( $secret, $salt, $t_cost, $m_factor, $parallelism, $tag_size ) };
ok $res;

say "test done";

done_testing();
