package MyRect;
use base 'SDL::Rect';

sub new {
	my $class = shift;
	my $self = $class->SUPER::new(@_);
	unless (ref $self) {
		require Carp;
		Carp::croak SDL::GetError();
	}
	return bless $self => $class;;

}

sub foo {
	my $self = shift;
	return $self->x;
}

package main;
use Test::More tests => 6;

my $rect = MyRect->new(0,0,0,0);

my $orect = SDL::Rect->new( x => 0, y => 0, w => 0, h => 0);
isa_ok($rect, 'SDL::Rect');
isa_ok($rect, 'MyRect');
can_ok($rect, qw(x y top left w h width height));
can_ok($rect, qw(new foo));

$rect->x(10);
is($rect->x, 10);
is($rect->foo, 10);
