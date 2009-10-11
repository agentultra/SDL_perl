package SDL::Object;

use strict;
use warnings;

use Carp ();

sub _new { Carp::confess("Abstract method") }

sub _new_pos {
	my ( $class, $pos, @args ) = @_;

	return $class->_new( $class->_parse_pos_args($pos, @args) );
}

sub _parse_pos_args {
	my ( $class, $pos, @args ) = @_;

	if ( @args == 1 ) {
		my $args = $args[0];

		if ( ref($args) eq 'HASH' ) {
            return $class->_parse_pos_hash($pos, $args);
		} elsif ( ref($args) eq 'ARRAY' ) {
			if ( @$args eq @$pos ) {
				return @$args;
			} else {
                Carp::croak(sprintf "incorrect number of positional arguments, got %d expected %d", scalar(@$args), scalar(@$pos));
			}
		}
    } elsif ( @args == @$pos ) {
        return @args;
	} elsif ( @args % 2 == 0 ) {
        return $class->_parse_pos_hash($pos, { @args });
	}

    Carp::croak("Invalid arguments");
}

sub _parse_pos_hash {
    my ( $class, $pos, $hash ) = @_;

    # strip leading dash and canonicalize to single letter
    my %by_letter;
    @by_letter{map { m{^ \-? (\w) }x or Carp::croak("invalid argument key $_"); $1 } keys %$hash} = values %$hash;

use Data::Dumper;
    Carp::croak("Argument list is ambiguous " . Dumper(\%by_letter, $hash)) unless keys %$hash == keys %by_letter;

    return @by_letter{@$pos};
}

1;

__END__
