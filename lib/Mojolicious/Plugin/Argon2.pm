package Mojolicious::Plugin::Argon2;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

sub register {
    my ( $self, $app ) = @_;
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
