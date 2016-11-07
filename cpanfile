requires 'Mojolicious',   '7.10';
requires 'Crypt::Argon2', '0.002';

on build => sub {
    requires 'ExtUtils::MakeMaker';
};

on test => sub {
    requires 'Test::More';
};
