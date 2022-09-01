[![Kwalitee status](https://cpants.cpanauthors.org/dist/DBIx-Class-InflateColumn-TimePiece.png)](https://cpants.cpanauthors.org/dist/DBIx-Class-InflateColumn-TimePiece)
[![GitHub issues](https://img.shields.io/github/issues/reneeb/DBIx-Class-InflateColumn-TimePiece.svg)](https://github.com/reneeb/DBIx-Class-InflateColumn-TimePiece/issues)
[![CPAN Cover Status](https://cpancoverbadge.perl-services.de/DBIx-Class-InflateColumn-TimePiece-0.02)](https://cpancoverbadge.perl-services.de/DBIx-Class-InflateColumn-TimePiece-0.02)
[![Cpan license](https://img.shields.io/cpan/l/DBIx-Class-InflateColumn-TimePiece.svg)](https://metacpan.org/release/DBIx-Class-InflateColumn-TimePiece)

# NAME

DBIx::Class::InflateColumn::TimePiece - Auto-create Time::Piece objects from integer (number of seconds since epoch) columns

# VERSION

version 0.02

# SYNOPSIS

```perl
package Event;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/InflateColumn::TimePiece/);
__PACKAGE__->table('my_events');
__PACKAGE__->add_columns(
    event_name => {
        data_type => 'varchar',
        size      => 45,
    },
    event_created => {
        data_type          => 'integer',
        inflate_time_piece => 1,
    },
);

1;
```

In the above example, a [DBIx::Class](https://metacpan.org/pod/DBIx%3A%3AClass) named `Event` is created, then [this](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AInflateColumn%3A%3ATimePiece)
DBIx::Class [Component](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AManual%3A%3AComponent) is loaded and two columns are added to the `my_events` table.

A column with `data_type` equal to `integer` or `int` and with property `inflate_time_piece` set to true, will be
[inflated](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AInflateColumn) using `localtime` in [Time::Piece](https://metacpan.org/pod/Time%3A%3APiece) and [deflated](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AInflateColumn)
using the [epoch](https://metacpan.org/pod/Time%3A%3APiece) method.

# SEE ALSO

- [DBIx::Class::InflateColumn::DateTime](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AInflateColumn%3A%3ADateTime)



# Development

The distribution is contained in a Git repository, so simply clone the
repository

```
$ git clone git://github.com/reneeb/DBIx-Class-InflateColumn-TimePiece.git
```

and change into the newly-created directory.

```
$ cd DBIx-Class-InflateColumn-TimePiece
```

The project uses [`Dist::Zilla`](https://metacpan.org/pod/Dist::Zilla) to
build the distribution, hence this will need to be installed before
continuing:

```
$ cpanm Dist::Zilla
```

To install the required prequisite packages, run the following set of
commands:

```
$ dzil authordeps --missing | cpanm
$ dzil listdeps --author --missing | cpanm
```

The distribution can be tested like so:

```
$ dzil test
```

To run the full set of tests (including author and release-process tests),
add the `--author` and `--release` options:

```
$ dzil test --author --release
```

# AUTHOR

Renee Baecker <reneeb@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Renee Baecker.

This is free software, licensed under:

```
The Artistic License 2.0 (GPL Compatible)
```
