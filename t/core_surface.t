#!perl -w
# Copyright (C) 2009 kthakore
#
# Spec tests for SDL::Surface
#

BEGIN {
    unshift @INC, 'blib/lib', 'blib/arch';
}

use strict;
use SDL;
use SDL::Config;
use SDL::Surface;
use SDL::App;
use SDL::Rect;
use SDL::Color;
use SDL::PixelFormat;
use Test::More tests => 35;

my $surface
    = SDL::Surface->new( SDL::SDL_ANYFORMAT(), 640, 320, 8, 0, 0, 0, 0 );
isa_ok( $surface, 'SDL::Surface' );
is( $surface->w,     640, 'surface has width' );
is( $surface->h,     320, 'surface has height' );
is( $surface->pitch, 640, 'surface has pitch' );
my $clip_rect = SDL::Rect->new( 0, 0, 0, 0 );
SDL::GetClipRect( $surface, $clip_rect );
isa_ok( $clip_rect, 'SDL::Rect' );
is( $clip_rect->x, 0,   'clip_rect has x' );
is( $clip_rect->y, 0,   'clip_rect has y' );
is( $clip_rect->w, 640, 'clip_rect has width' );
is( $clip_rect->h, 320, 'clip_rect has height' );

my $image = SDL::IMG_Load('test/data/logo.png');
is( $image->w, 608, 'image has width' );
is( $image->h, 126, 'image has height' );

my $pixel_format = $image->format;
isa_ok( $pixel_format, 'SDL::PixelFormat' );
is( $pixel_format->BitsPerPixel,  24,       '24 BitsPerPixel' );
is( $pixel_format->BytesPerPixel, 3,        '3 BytesPerPixel' );
is( $pixel_format->Rloss,         0,        '0 Rloss' );
is( $pixel_format->Gloss,         0,        '0 Gloss' );
is( $pixel_format->Bloss,         0,        '0 Bloss' );
is( $pixel_format->Aloss,         8,        '8 Aloss' );
is( $pixel_format->Rshift,        0,        '0 Rshift' );
is( $pixel_format->Gshift,        8,        '8 Gshift' );
is( $pixel_format->Bshift,        16,       '16 Bshift' );
is( $pixel_format->Ashift,        0,        '0 Ashift' );
is( $pixel_format->Rmask,         255,      '255 Rmask' );
is( $pixel_format->Gmask,         65280,    '65280 Gmask' );
is( $pixel_format->Bmask,         16711680, '16711680 Bmask' );
is( $pixel_format->Amask,         0,        '0 Amask' );
is( $pixel_format->colorkey,      0,        '0 colorkey' );
is( $pixel_format->alpha,         255,      '255 alpha' );

my $pixel = SDL::MapRGB( $pixel_format, 255, 127, 0 );
is( $pixel, 32767, '32767 pixel' );
SDL::FillRect( $surface, SDL::Rect->new( 0, 0, 32, 32 ), $pixel );
ok( 1, 'Managed to fill_rect' );

my $small_rect = SDL::Rect->new( 0, 0, 64, 64 );
SDL::BlitSurface( $image, $small_rect, $surface, $small_rect );
ok( 1, 'Managed to blit' );

#my $image_format = $surface->display;
#$surface->update_rect( 0, 0, 32, 32 );
#ok( 1, 'Managed to update_rect' );
#$surface->update_rects( SDL::Rect->new( 0, 0, 32, 32 ) );
#ok( 1, 'Managed to update_rects' );

my $app = SDL::App->new(
    -title  => "Test",
    -width  => 640,
    -height => 480,
    -init   => SDL_INIT_VIDEO
);

pass 'did this pass';

my $image_format = $image->display;
isa_ok( $image_format, 'SDL::Surface' );

my $image_format_alpha = $image->display_alpha;
isa_ok( $image_format_alpha, 'SDL::Surface' );

my $app_pixel_format = $app->format;

my $rect = SDL::Rect->new( 0, 0, $app->w, $app->h );

my $blue_pixel = SDL::MapRGB( $app_pixel_format, 0x00, 0x00, 0xff );
SDL::FillRect( $app, $rect, $blue_pixel );
SDL::UpdateRect( $app, 0, 0, 0, 0 );

diag( 'This is in surface : ' . SDL::Surface::get_pixels($app) );

pass 'did this pass';

SDL::Delay(100);