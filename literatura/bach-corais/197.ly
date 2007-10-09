
\version "2.10.33"

\header {
  title = "197 - Christ ist erstanden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 a''4 
  g a8 b c4 d 
  a2 a4 f8 g 
  a g f4 e8 d e4 
  d2 s4 f 
  g g d c 
  f g a a8 g 
  f4 g a8 g f4 
  e d e2 
  d4 d d2 
  d1 
  a'4 a g a8 ais 
  c4 d a a 
  a8. g16 f8 g a g f4 
  e8 d e4 d f 
  g g d c 
  f g a a 
  a8 g f8. g16 a4 f 
  e d e2 
  d4 d d2 
  d1 
  a'4 f c' a 
  c8 ais a4 g f 
  a8 g f4 e d 
  f g g d 
  c f g a 
  a8 g f4 g a 
  f e d e2 d4 d d2 d1 
}


alto = \relative c {
  \partial 4 f'4. e8 e gis a4. g4 f16 e f4 e d 
  c8 cis d4 cis8 d4 cis8 
  a2 s4 d4. c16 b c4. b4 a16 ais 
  c8 d e4 f e4. d4 cis8 d4. c8 
  ais a4 b8 cis2 
  d4 c c ais2 a8 g a2 
  f'4 e8 d g ais a g 
  f2 f4 f 
  e d8 e f cis d2 cis4 d c 
  c8 b c4. ais4 a16 g 
  c4 c c c8 cis 
  d4 a d d4. c4 b8 c2 
  c8 ais a4 g4. ais8 
  a1 
  e'4 d c c 
  c8 d e f4 e8 c4 
  e4. d4 c ais8 
  c4 d c8 g a b 
  c ais a16 g a8 d c c4 
  f8 e d4. c16 ais a4. d16 c b8 a4 gis8 cis2 d4 c ais8 a 
  g16 a ais4 a8 ais g a2 
}


tenor = \relative c {
  \partial 4 d'8 c 
  b4 c8 d e f16 e d4 
  d2 a4 a 
  a a ais8 f g a16 g 
  f2 s4 a 
  e8 f g16*5 d16 e4 f16 g 
  a8 f ais4 c a 
  a g8 ais a16*5 g16 a8 
  g16 f g8 f16 e f8 e2 
  a8 g a fis g d g2 fis8 e fis2 
  d'4 c8 b c4 c 
  c4. ais8 c4 c8 d 
  e a,4 g8 f g a4 
  a4. g8 f4 a 
  g8 f g4 g8. f16 e4 
  a g f a8 g 
  f e d e f g a4 
  a8 e f4 g2 
  a8 g4 fis8 g d g2 fis8 e fis2 
  a4. ais8 a g f4 
  f c'4. ais8 a4 
  a a g8 a d,4 
  a'8 f d16 e f4 e8 fis gis 
  a g f16 e f4 e8 f4 
  c'4. ais16 a g4. f16 e 
  f8 ais16 a gis8 a d d, a'2 f8 g a4. g16 fis 
  g4. fis8 g e fis2 
}


baixo = \relative c {
  \partial 4 d4 
  e8. d16 c8 b a4 ais8. c16 
  d2 cis4 d8 e 
  f4. f,8 g ais a4 
  d2 s4 d, 
  e4. f8 g gis a4. ais8 a g f4 cis' 
  d e f8 e d4. cis8 d4 a2 
  fis8 e fis d g a ais g 
  d'2 d, 
  d'8 e f4. e8 f g 
  a f ais4 f f 
  cis d4. e8 f g 
  a4 a, ais a 
  e8 d e f g4 a4. g8 f e f4 f'8 e 
  d8*5 e8 f g 
  a a, d4 c2 
  fis,8 g c4. ais16 a ais8 g 
  d'2 d, 
  cis'4 d e f 
  a,8 ais c4 c, f 
  cis' d8 d, e fis g4 
  a b c4. b8 
  a4. d8 ais c f4 
  f, ais dis8 d cis4 
  d4. c8 b4 a2 ais8 a g fis g a 
  ais g d1 
}


\score {
  <<
    \new Staff {
      <<
        \global
        \new Voice = "1" { \voiceOne \soprano }
        \new Voice = "2" { \voiceTwo \alto }
      >>
    }
    \new Staff {
      <<
        \global
        \clef "bass"
        \new Voice = "1" {\voiceOne \tenor }
        \new Voice = "2" { \voiceTwo \baixo \bar "|."}
      >>
    }
  >>
}