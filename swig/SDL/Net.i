// SDL::Net
// Nothing fancy here yet
%module SDL::Net
%{
#include "SDL/SDL_net.h"
%}

%perlcode %{
our $version = v4.0.0
%}

%include "SDL/SDL_net.h"
