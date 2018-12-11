package DBIx::Class::InflateColumn::TimePiece;

# ABSTRACT: Auto-create Time::Piece objects from integer columns

use v5.10;

use strict;
use warnings;

use parent 'DBIx::Class';

use Time::Piece;

sub register_column {
    my ($self, $column, $info, @rest) = @_;

    $self->next::method( $column, $info, @rest );

    my $data_type = $info->{data_type};

    return if $info->{inflate_time_piece} && !$data_type;
    return if $data_type ne 'integer' && $data_type ne 'int';

    $self->inflate_column(
        $column => {
            inflate => sub {
                my $dt = localtime shift;
                return $dt;
            },
            deflate => sub {
                return shift->epoch;
            },
        }
    );
}

1;

=head1 SYNOPSIS

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

=head1 METHODS

=head2 register_column
