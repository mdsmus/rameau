
\version "2.10.33"

\header {
  title = "211 - Weltlich Ehr und zeitlich Gut"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  c''4 b a a 
  a b c8 b a4 
  g2 s4 b 
  c b c a 
  b g a2 
  b s4 b 
  b b a b 
  c2 g4 g 
  a b c a 
  b2 b4 c 
  d d c a 
  b2 d4 d 
  d d e d8 c 
  b2 b4 g 
  a b8 c d c b4 
  a b c2 
}


alto = \relative c {
  e'8 f g4. f16 e f4 
  f8 a g4 g4. f8 
  f4 e s4 g 
  g g g f2 e4 e2 
  e s4 e 
  fis8 a4 g8 fis4 e 
  e2 d8 f4 e d8 d4 c8 g'4 fis8 
  g2 g4. fis8 
  g a b4 a8 g fis4 
  g2 a4 g8 a 
  b a g f e4 f 
  g2 g8 f e4. fis8 g4 a4. g4 f16 e f8 e16 d e2 
}


tenor = \relative c {
  g'4 g8 c c4 c 
  d8 f e d c4 c 
  c2 s4 d 
  e d c c 
  d b a8 b c a 
  gis2 s4 g 
  b8 fis'4 e d8 c b 
  a2 d4. c16 b 
  c4 b8 a g e' d4 
  d2 d4 c 
  b e e d 
  d2 fis8 e d c 
  b4 b c8 b a4 
  e'2 d4 c 
  c d d d 
  d d8 g, g2 
}


baixo = \relative c {
  c8 d e4 f8 g f e 
  d4 g8 f e4 f 
  c2 s4 g' 
  c,8 e g f e c f e 
  d b e d c b a c 
  e2 s4 e 
  dis e fis gis 
  a2 b4 c 
  fis, g8 fis e c d4 
  g,2 g4 a 
  b gis a8 b c d 
  g,2 d''8 c b a 
  g f e d c4 d 
  e2 g,4 c8 b 
  a4 g fis g 
  d' g, c2 
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