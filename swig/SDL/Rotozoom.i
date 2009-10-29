// SDL::RotoZoom
// Nothing fancy here yet
%module SDL::RotoZoom
%{
#include "SDL/SDL_rotozoom.h"
%}

%perlcode %{
our $version = v4.0.0
%}

%include "SDL/SDL_rotozoom.h"
