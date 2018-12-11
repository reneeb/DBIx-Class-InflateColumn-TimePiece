#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use Test::More;
use Scalar::Util qw/blessed/;

use lib dirname(__FILE__) . '/lib';
use TimePieceDB;

if ( !eval { require DBD::SQLite } ) {
    plan skip_all => 'DBD::SQLite is not installed!';
}

my $schema = TimePieceDB->init_schema;
my $rs     = $schema->resultset('TestUser');

my @tests = (
    [ 0,             '1970-01-01' ],
    [ 25 * 60 * 60 , '1970-01-02' ],
    [ 1544536942,    '2018-12-11' ],
    [ 1544536942,    '2018-12-11 15:02:00', sub { sprintf "%s %s", $_[0]->dmy, $_->[1] } ],
    [ -1,            '1970-01-01' ],
);

my $default = sub { $_[0]->dmy };

for my $test ( @tests ) {
    my ($input, $output, $code) = @{ $test };

    my $testuser = $rs->create({
        user_name    => 'hugo',
        city         => 'anywhere',
        user_created => $input,
    });

    my $sub = $code // $default;

    ok blessed $testuser;
    ok !blessd $testuser->id;
    ok !blessd $testuser->user_name;
    ok !blessd $testuser->city;
    ok blessed $testuser->user_created;
    is $sub->( $testuser->user_created ), $output, "In: $input // Out: $output";
}

done_testing();
