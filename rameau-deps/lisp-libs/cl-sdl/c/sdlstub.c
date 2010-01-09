#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_endian.h>	/* Used for the endian-dependent 24 bpp mode */

void draw_line (SDL_Surface *surface,
                Uint16 x1, Uint16 y1, Uint16 x2, Uint16 y2, 
                Uint8 r, Uint8 g, Uint8 b);

void draw_pixel(SDL_Surface *screen, Uint16 x, Uint16 y,
                Uint8 R, Uint8 G,
                Uint8 B);

void faster_draw_pixel(SDL_Surface *screen, Uint16, Uint16 y,
                       Uint32 color);

Uint16 byte_order (void) {
  return SDL_BYTEORDER;
}


/* draw_pixel, show_bmp code courtesy of libSDL.org */

void draw_pixel(SDL_Surface *screen, Uint16 x, Uint16 y,
                Uint8 R, Uint8 G, Uint8 B)
{
  Uint32 color = SDL_MapRGB(screen->format, R, G, B);

  faster_draw_pixel (screen, x, y, color);
}

void faster_draw_pixel(SDL_Surface *screen, Uint16 x, Uint16 y,
                       Uint32 color)
{

  /*
  if ( SDL_MUSTLOCK(screen) ) {
    if ( SDL_LockSurface(screen) < 0 ) {
      return;
    }
  }
  */

  switch (screen->format->BytesPerPixel) {
  case 1: { /* Assuming 8-bpp */
    Uint8 *bufp;
    
    bufp = (Uint8 *)screen->pixels + y*screen->pitch + x;
    *bufp = color;
  }
  break;
  
  case 2: { /* Probably 15-bpp or 16-bpp */
    Uint16 *bufp;

    bufp = (Uint16 *)screen->pixels + y*screen->pitch/2 + x;
    *bufp = color;
  }
  break;

  case 3: { /* Slow 24-bpp mode, usually not used */
    Uint8 *bufp;

    bufp = (Uint8 *)screen->pixels + y*screen->pitch + x * 3;
    if(SDL_BYTEORDER == SDL_LIL_ENDIAN) {
      bufp[0] = color;
      bufp[1] = color >> 8;
      bufp[2] = color >> 16;
    } else {
      bufp[2] = color;
      bufp[1] = color >> 8;
      bufp[0] = color >> 16;
    }
  }
  break;

  case 4: { /* Probably 32-bpp */
    Uint32 *bufp;

    bufp = (Uint32 *)screen->pixels + y*screen->pitch/4 + x;
    *bufp = color;
  }
  break;
  }

  /*
  if ( SDL_MUSTLOCK(screen) ) {
    SDL_UnlockSurface(screen);
  }
  SDL_UpdateRect(screen, x, y, 1, 1);
  */
}

Uint32 get_pixel(SDL_Surface *surface, Uint16 x, Uint16 y)
{
  int bpp = surface->format->BytesPerPixel;

  Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

  switch(bpp) {
  case 1:
    return *p;

  case 2:
    return *(Uint16 *)p;

  case 3:
    if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
      return p[0] << 16 | p[1] << 8 | p[2];
    else
      return p[0] | p[1] << 8 | p[2] << 16;

  case 4:
    return *(Uint32 *)p;

  default:
    return 0;       /* shouldn't happen, but avoids warnings */
  }
}

void show_bmp(char *file, SDL_Surface *screen, Uint16 x, Uint16 y)
{
  SDL_Surface *image;
  SDL_Rect dest;

  /* Load the BMP file into a surface */
  image = SDL_LoadBMP(file);
  if ( image == NULL ) {
    // fixme
    fprintf(stderr, "Couldn't load %s: %s\n", file, SDL_GetError());
    return;
  }

  /* Blit onto the screen surface.
     The surfaces should not be locked at this point.
  */
  dest.x = x;
  dest.y = y;
  dest.w = image->w;
  dest.h = image->h;
  SDL_BlitSurface(image, NULL, screen, &dest);

  /* Update the changed portion of the screen */
  SDL_UpdateRects(screen, 1, &dest);

  SDL_FreeSurface(image);
}

void draw_rectangle (SDL_Surface *screen, Uint16 x, Uint16 y, 
                     Uint16 w, Uint16 h,
                     Uint8 r, Uint8 g, Uint8 b) {
#define DRAWLINE(x1,y1,x2,y2) (draw_line (screen, x1, y1, x2, y2, r, g, b))
  Uint16 xw = x + w, yh = y + h;

  DRAWLINE(x, y, xw, y);
  DRAWLINE(x, y, x, yh);
  DRAWLINE(xw, y, xw, yh);
  DRAWLINE(x, yh, xw, yh);

#undef DRAWLINE
}

void draw_filled_rectangle(SDL_Surface *screen, Uint16 x, Uint16 y, 
                           Uint16 w, Uint16 h,
                           Uint8 r, Uint8 g, Uint8 b) {
  Uint32 color = SDL_MapRGB (screen->format, r, g, b);
  SDL_Rect rect;

  rect.x = x;
  rect.y = y;
  rect.w = w;
  rect.h = h;
  
  SDL_FillRect (screen, &rect, color);
}

  
SDL_Surface *load_bmp (char *file) {
  return SDL_LoadBMP (file);
}

int save_bmp (SDL_Surface *surface, unsigned char *file) {
  return SDL_SaveBMP (surface, file);
}

int blit_surface (SDL_Surface *src, SDL_Rect *srcrect,
                  SDL_Surface *dst, SDL_Rect *dstrect) {
  return SDL_BlitSurface (src, srcrect, dst, dstrect);
}

void draw_line (SDL_Surface *surface,
                Uint16 x1, Uint16 y1, Uint16 x2, Uint16 y2, 
                Uint8 r, Uint8 g, Uint8 b) {
  Uint32 color = SDL_MapRGB(surface->format, r, g, b);
#define SW (surface->w)
#define SH (surface->h)
#define DRAWPIXEL(x,y) (faster_draw_pixel (surface, x, y, color))
  
  Sint32 dx, dy, e, e_inc, e_noinc;
  Sint8 incr_step;
  Uint16 t, i, start, end, var, x_ind_p;

  if (x1 == x2) { /* vertical line */ 
    if (y1 > y2) {
      for (i = y2; i <= y1; i++)
        DRAWPIXEL(x1, i);
    } else {
      for (i = y1; i <= y2; i++) 
        DRAWPIXEL(x1, i); 
    }
    return;
  } 

  if (y1 == y2) {  /* horizontal line */
    if (x1 > x2) {
      for (i = x2; i <= x1; i++) 
        DRAWPIXEL(i, y1);
    } else {
      for (i = x1; i <= x2; i++) 
        DRAWPIXEL(i, y1);
    }
    return; 
  }

  if (x1 > x2) { 
    t = x1; x1 = x2; x2 = t; 
    t = y1; y1 = y2; y2 = t; 
  }

  dx = x2 - x1; 
  dy = y2 - y1; 

  if (dy > 0) {
    /* 0 < m <= 1 */
    if (dy <= dx) {
      e_noinc = (dy << 1);
      e = (dy << 1) - dx;
      e_inc = ((dy - dx) << 1);
      x_ind_p = 1; start = x1; end = x2; var = y1; 
    } 

    /* 1 < m < infinity */
    else if (dy > dx) {
      e_noinc = (dx << 1);
      e = (dx << 1) - dy;
      e_inc = ((dx - dy) << 1);
      x_ind_p = 0; start = y1; end = y2; var = x1; 
    }
    incr_step = 1;
  } else {
    /* 0 > m >= -1 */
    if (-dy <= dx) {
      dy = -dy;
      e_noinc = (dy << 1);
      e = (dy << 1) - dx;
      e_inc = ((dy - dx) << 1);
      x_ind_p = 1; start = x1; end = x2; var = y1; 
    } 

    /* -1 > m > -infinity */
    else if (-dy > dx) {
      dx = -dx;
      e_noinc = -(dx << 1); 
      e = (dx << 1) - dy;
      e_inc = -((dx - dy) << 1);
      x_ind_p = 0; start = y2; end = y1; var = x2; 
    }
    incr_step = -1;
  }

  if (x_ind_p == 0) {
    for (i = start; i <= end; i++) {
      DRAWPIXEL(var, i); 
      if (e < 0) 
        e += e_noinc; 
      else { 
        if (var != 0 || incr_step != -1) 
          var += incr_step;
        e += e_inc; 
        if (var >= SW) var = SW - 1;
      }
    }
  } else {
    for (i = start; i <= end; i++) {
      DRAWPIXEL(i, var); 
      if (e < 0) 
        e += e_noinc; 
      else { 
        if (var !=0 || incr_step != -1)
          var += incr_step; 
        e += e_inc; 
        if (var >= SH) var = SH - 1;
      } 
    }
  } 

#undef DRAWPIXEL
#undef SH
#undef SW
}

struct struct_vraster_t {
  Uint16 *top;
  Uint16 *bottom;
  Uint16 length;
  Uint16 surface_height;
};
typedef struct struct_vraster_t vraster_t;

#define xmalloc(t,n) ((t *)malloc(sizeof(t)*n))

vraster_t *make_vraster (SDL_Surface *surface) {
  int sw = surface->w;
  int init_top = 1 + surface->h;
  int init_bottom = 0;
  int i;
  vraster_t *buffer = xmalloc(vraster_t,1);

  if (!buffer) return NULL;
  buffer->top = xmalloc(Uint16,sw);
  if (!buffer->top) {
    free (buffer);
    return NULL;
  }
  buffer->bottom = xmalloc(Uint16,sw);
  if (!buffer->bottom) {
    free (buffer->top);
    free (buffer);
    return NULL;
  }
  buffer->length = sw;
  buffer->surface_height = surface->h;

  for (i = 0; i < sw; i++) {
    buffer->top[i] = init_top;
    buffer->bottom[i] = init_bottom;
  }

  return buffer;
}

#undef xmalloc

void fill_vraster (SDL_Surface *surface, vraster_t *buffer,
                   Uint8 r, Uint8 g, Uint8 b) {
  int i;
  
  if (!buffer) return;

  for (i = 0; i < buffer->length; i++) {
    Uint16 top = buffer->top[i];
    Uint16 bot = buffer->bottom[i];
    
    if (bot > top) 
      draw_line (surface, i, top, i, bot, r, g, b);
  }
}

void free_vraster (vraster_t *buffer) {
  if (!buffer) return;

  free (buffer->top);
  free (buffer->bottom);
  free (buffer);
}

#define VTOP(a) (buffer->top[a])
#define VBOTTOM(a) (buffer->bottom[a])
void vraster_pixel (vraster_t *buffer, Uint16 x, Uint16 y) { 
  if (VTOP(x) > (buffer->surface_height)) {
    VTOP(x) = y; 
  } else if (y <= VTOP(x)) { 
    if (VTOP(x) > VBOTTOM(x)) { 
      VBOTTOM(x) = VTOP(x); 
    } 
    VTOP(x) = y; 
  } else if (y > VBOTTOM(x)) {
    VBOTTOM(x) = y; 
  }
}

void vraster_line (vraster_t *buffer,
                  Uint16 x1, Uint16 y1, Uint16 x2, Uint16 y2) {


  //#define DRAWPIXEL(x,y) { if (y < VTOP(x)) { VTOP(x) = y; } else if (y > VBOTTOM(x)) { VBOTTOM(x) = y; } }
#define SH (buffer->surface_height)
#define SW (buffer->length)
#define DRAWPIXEL(x,y) (vraster_pixel (buffer, x, y))
//{ if (VTOP(x) > SH) { VTOP(x) = y; } else if (y <= VTOP(i)) { if (VTOP(i) > VBOTTOM(i)) { VBOTTOM(i) = VTOP(i); } VTOP(i) = y; } else if (y > VBOTTOM(x)) { VBOTTOM(x) = y; } }

  Sint32 dx, dy, e, e_inc, e_noinc;
  Sint8 incr_step;
  Uint16 t, i, start, end, var, x_ind_p;

  if (x1 == x2) { /* vertical line */ 
    if (y1 > y2) {
      for (i = y2; i <= y1; i++)
        DRAWPIXEL(x1, i);
    } else {
      for (i = y1; i <= y2; i++) 
        DRAWPIXEL(x1, i); 
    }
    return;
  } 

  if (y1 == y2) {  /* horizontal line */
    if (x1 > x2) {
      for (i = x2; i <= x1; i++) 
        DRAWPIXEL(i, y1);
    } else {
      for (i = x1; i <= x2; i++) 
        DRAWPIXEL(i, y1);
    }
    return; 
  }

  if (x1 > x2) { 
    t = x1; x1 = x2; x2 = t; 
    t = y1; y1 = y2; y2 = t; 
  }

  dx = x2 - x1; 
  dy = y2 - y1; 

  if (dy > 0) {
    /* 0 < m <= 1 */
    if (dy <= dx) {
      e_noinc = (dy << 1);
      e = (dy << 1) - dx;
      e_inc = ((dy - dx) << 1);
      x_ind_p = 1; start = x1; end = x2; var = y1; 
    } 

    /* 1 < m < infinity */
    else if (dy > dx) {
      e_noinc = (dx << 1);
      e = (dx << 1) - dy;
      e_inc = ((dx - dy) << 1);
      x_ind_p = 0; start = y1; end = y2; var = x1; 
    }
    incr_step = 1;
  } else {
    /* 0 > m >= -1 */
    if (-dy <= dx) {
      dy = -dy;
      e_noinc = (dy << 1);
      e = (dy << 1) - dx;
      e_inc = ((dy - dx) << 1);
      x_ind_p = 1; start = x1; end = x2; var = y1; 
    } 

    /* -1 > m > -infinity */
    else if (-dy > dx) {
      dx = -dx;
      e_noinc = -(dx << 1); 
      e = (dx << 1) - dy;
      e_inc = -((dx - dy) << 1);
      x_ind_p = 0; start = y2; end = y1; var = x2; 
    }
    incr_step = -1;
  }

  if (x_ind_p == 0) {
    for (i = start; i <= end; i++) {
      DRAWPIXEL(var, i); 
      if (e < 0) 
        e += e_noinc; 
      else { 
        if (var != 0 || incr_step != -1) 
          var += incr_step;
        e += e_inc; 
        if (var >= SW) var = SW - 1;
      }
    }
  } else {
    for (i = start; i <= end; i++) {
      DRAWPIXEL(i, var); 
      if (e < 0) 
        e += e_noinc; 
      else { 
        if (var !=0 || incr_step != -1)
          var += incr_step; 
        e += e_inc; 
        if (var >= SH) var = SH - 1;
      }
    }
  } 

#undef DRAWPIXEL
#undef SH
#undef VBOTTOM
#undef VTOP
}

void draw_circle (SDL_Surface *surface,
                  Uint16 x, Uint16 y, Uint16 radius,
                  Uint8 r, Uint8 g, Uint8 b) {

#define DRAWPIXEL(px,py) (draw_pixel (surface, px, py, r, g, b))
#define DRAWCIRCLE0(dx,dy) { DRAWPIXEL(x + dx,y + dy); DRAWPIXEL(x - dx, y + dy); DRAWPIXEL(x + dx, y - dy); DRAWPIXEL(x - dx, y - dy); }
#define DRAWCIRCLE(dx,dy) { DRAWCIRCLE0(dx,dy); DRAWCIRCLE0(dy,dx); }

  Sint32 p;
  Sint16 x1, y1;

  x1 = 0; y1 = radius;
  p = 3 - (radius << 1);
  
  while (x1 < y1) {
    DRAWCIRCLE(x1,y1);
    
    if (p < 0) 
      p += (x1 << 2) + 6;
    else {
      p += ((x1 - y1) << 2) + 10;
      --y1;
    }
    ++x1;
  }
  if (x1 == y1)
    DRAWCIRCLE(x1,y1);

#undef DRAWCIRCLE
#undef DRAWCIRCLE0
#undef DRAWPIXEL

}

void draw_filled_circle (SDL_Surface *surface,
                         Uint16 x, Uint16 y, Uint16 radius,
                         Uint8 r, Uint8 g, Uint8 b) {

#define DRAWLINE(x1,y1,x2,y2) (draw_line (surface, x1, y1, x2, y2, r, g, b))
#define DRAWCIRCLE0(dx,dy) { DRAWLINE(x + dx, y + dy, x - dx, y + dy); DRAWLINE(x + dx, y - dy, x - dx, y - dy); }
#define DRAWCIRCLE(dx,dy) { DRAWCIRCLE0(dx,dy); DRAWCIRCLE0(dy,dx); }

  Sint32 p;
  Sint16 x1, y1;

  x1 = 0; y1 = radius;
  p = 3 - (radius << 1);
  
  while (x1 < y1) {
    DRAWCIRCLE(x1,y1);
    
    if (p < 0) 
      p += (x1 << 2) + 6;
    else {
      p += ((x1 - y1) << 2) + 10;
      --y1;
    }
    ++x1;
  }
  if (x1 == y1)
    DRAWCIRCLE(x1,y1);

#undef DRAWCIRCLE
#undef DRAWCIRCLE0
#undef DRAWLINE

}

void draw_filled_circle_with_border (SDL_Surface *surface,
                                     Uint16 x, Uint16 y, Uint16 radius,
                                     Uint8 r, Uint8 g, Uint8 b,
                                     Uint8 br, Uint8 bg, Uint8 bb) {

#define DRAWPIXEL(px,py) (draw_pixel (surface, px, py, br, bg, bb))
#define DRAWLINE(x1,y1,x2,y2) (draw_line (surface, x1, y1, x2, y2, r, g, b))
#define DRAWCIRCLE0(dx,dy) { if (dx > dy) { DRAWLINE(x + dx, y + dy, x - dx, y + dy); DRAWLINE(x + dx, y - dy, x - dx, y - dy); } else { DRAWLINE(x + dx, y + dy, x + dx, y - dy); DRAWLINE(x - dx, y + dy, x - dx, y - dy); } }
#define DRAWCIRCLE1(dx,dy) { DRAWPIXEL(x + dx, y + dy); DRAWPIXEL(x - dx, y + dy); DRAWPIXEL(x + dx, y - dy); DRAWPIXEL(x - dx, y - dy); }
#define DRAWCIRCLE(dx,dy) { DRAWCIRCLE0(dx,dy); DRAWCIRCLE0(dy,dx); DRAWCIRCLE1(dx,dy); DRAWCIRCLE1(dy,dx); }

  Sint32 p;
  Sint16 x1, y1;

  x1 = 0; y1 = radius;
  p = 3 - (radius << 1);
  
  while (x1 < y1) {
    DRAWCIRCLE(x1,y1);
    
    if (p < 0) 
      p += (x1 << 2) + 6;
    else {
      p += ((x1 - y1) << 2) + 10;
      --y1;
    }
    ++x1;
  }
  if (x1 == y1)
    DRAWCIRCLE(x1,y1);

#undef DRAWCIRCLE
#undef DRAWCIRCLE1
#undef DRAWCIRCLE0
#undef DRAWLINE
#undef DRAWPIXEL

}

void draw_triangle (SDL_Surface *surface,
                    Uint16 x1, Uint16 y1,
                    Uint16 x2, Uint16 y2,
                    Uint16 x3, Uint16 y3,
                    Uint8 r, Uint8 g, Uint8 b) {
#define DRAWLINE(w,x,y,z) (draw_line (surface, w, x, y, z, r, g, b))
  DRAWLINE(x1, y1, x2, y2);
  DRAWLINE(x2, y2, x3, y3);
  DRAWLINE(x3, y3, x1, y1);
#undef DRAWLINE
}

void draw_filled_triangle (SDL_Surface *surface,
                           Uint16 x1, Uint16 y1,
                           Uint16 x2, Uint16 y2,
                           Uint16 x3, Uint16 y3,
                           Uint8 r, Uint8 g, Uint8 b) {
  vraster_t *buffer = make_vraster (surface);
  
  if (!buffer) return;

#define DRAWLINE(w,x,y,z) (vraster_line (buffer, w, x, y, z))
  DRAWLINE(x1, y1, x2, y2);
  DRAWLINE(x2, y2, x3, y3);
  DRAWLINE(x3, y3, x1, y1);

  fill_vraster (surface, buffer, r, g, b);

  free_vraster (buffer);
#undef DRAWLINE
}


/*
void **cl_sdl_proc_table = NULL;
Uint16 next_entry = 1, table_length = 0, step_size = 100;
*/

/* Return 0 on failure, otherwise proc id */
/*
Uint16 sdl_gl_get_proc_address (char *proc) {
  void *ptr;
  Uint16 entry;
  if (proc == NULL) return 0;
  ptr = SDL_GL_GetProcAddress (proc);
  if (ptr == NULL) return 0;
  
  entry = next_entry++;
  if (entry > 65535 || entry <= 0) return 0;

  while (entry >= table_length) {
    void **new_table;
    table_length += step_size;
    new_table = (void **)realloc (cl_sdl_proc_table,
                                  (sizeof (void *)) * table_length);
    if (new_table == NULL) {
      table_length -= step_size;
      return 0;
    }
    cl_sdl_proc_table = new_table;
  }
  
  cl_sdl_proc_table[entry] = ptr;

  return entry;
}
*/
