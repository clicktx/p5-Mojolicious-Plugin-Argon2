package Mojolicious::Plugin::Argon2;
use Mojo::Base 'Mojolicious::Plugin';
use Crypt::Argon2 qw/argon2i_pass argon2i_verify/;

our $VERSION = '0.01';

sub register {
    my ( $self, $app, $conf ) = @_;
    my $t_cost      = $conf->{t_cost}      || 3;
    my $m_factor    = $conf->{m_factor}    || '32M';
    my $parallelism = $conf->{parallelism} || 1;
    my $tag_size    = $conf->{tag_size}    || 16;

    $app->helper(
        argon2 => sub {
            my $c = shift;
            my ( $secret, $salt ) = ( shift, shift || _salt() );

            # return argon2i_pass( $secret, $salt, $t_cost, $m_factor,
            #     $parallelism, $tag_size );
            return "salt: " . $salt;
        }
    );

    $app->helper(
        argon2_verify => sub {
            my $c = shift;
            my ( $encoded, $plain ) = @_;

            return argon2i_verify( $encoded, $plain );
        }
    );
}

# This code from Mojolicious::Plugin::Bcrypt::_salt
sub _salt {
    my $num = 999999;
    my $cr = crypt( rand($num), rand($num) ) . crypt( rand($num), rand($num) );
    substr( $cr, 4, 20 );
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::Argon2 - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Argon2');

  # Mojolicious::Lite
  plugin 'Argon2';

=head1 DESCRIPTION

L<Mojolicious::Plugin::Argon2> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::Argon2> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 AUTHOR

Munenori Sugimura <clicktx@gmail.com>

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
