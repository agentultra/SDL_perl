// SDL::gfx
// Nothing fancy here yet
%module SDL::gfx
%{
#include "SDL/SDL_gfxBlitFunc.h"
#include "SDL/SDL_gfxPrimitives.h"
#include "SDL/SDL_gfxPrimitives_font.h"
%}

%perlcode %{
our $version = v4.0.0
%}

%include "SDL/SDL_gfxBlitFunc.h"
%include "SDL/SDL_gfxPrimitives.h"
%include "SDL/SDL_gfxPrimitives_font.h"
