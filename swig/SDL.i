// SDL
// Nothing fancy here yet
%module SDL
%{
#include "SDL.h"
%}

%perlcode %{
our $version = v4.0.0
%}

%include "SDL.h"
