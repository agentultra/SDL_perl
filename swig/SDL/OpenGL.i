// SDL::OpenGL
// Nothing fancy here yet
%module SDL::OpenGL
%{
#include "SDL/SDL_opengl.h"
%}

%perlcode %{
our $version = v4.0.0
%}

%include "SDL/SDL_opengl.h"
