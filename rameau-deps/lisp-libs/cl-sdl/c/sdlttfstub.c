#include <SDL.h>
#include <SDL_ttf.h>

SDL_Surface *render_glyph_solid (TTF_Font *font, Uint16 ch, SDL_Color *fg) {
  return TTF_RenderGlyph_Solid (font, ch, *fg);
}

SDL_Surface *render_Text_solid (TTF_Font *font, const char *text, 
                                SDL_Color *fg) {
  return TTF_RenderText_Solid (font, text, *fg);
}

SDL_Surface *render_UTF8_solid (TTF_Font *font, const char *text, 
                                SDL_Color *fg) {
  return TTF_RenderUTF8_Solid (font, text, *fg);
}

SDL_Surface *render_UNICODE_solid (TTF_Font *font, const Uint16 *text, 
                                   SDL_Color *fg) {
  return TTF_RenderUNICODE_Solid (font, text, *fg);
}

