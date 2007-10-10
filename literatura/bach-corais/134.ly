
\version "2.10.33"

\header {
  title = "134 - Du geballtes Weltgebäude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  d''4 a d d 
  e c b2 
  a f4 a 
  g f e4. d8 
  d1 
  d'4 a d d 
  e c b2 
  a f4 a 
  g f e4. d8 
  d1 
  f4 g a a 
  bes a g2 
  f f4 g 
  a a bes a 
  g2 f 
  a4 b c a 
  d d cis2 
  d8 e f4 e d 
  d cis d2 
}


alto = \relative c {
  f'4 a a gis8 a 
  b e, e4 f e8 d 
  cis2 d4 d8 cis 
  d e4 d8 d4 cis 
  a1 
  f'4 a a gis8 a 
  b e, e4 f e8 d 
  cis2 d4 d8 cis 
  d e4 d8 d4 cis 
  a1 
  d4 e f f 
  f8 g4 f8 f4 e 
  c2 d4. c4 f8 a4. g4 f e16 d e4 c2 
  f4 f g4. f8 
  f4 f8 e e2 
  f8 g a4 g f 
  e e fis2 
}


tenor = \relative c {
  a'4 f'8 e d c b8*5 a8 a4 gis 
  e2 a4 a 
  d,8 a' a4 bes a8. g16 
  f1 
  a4 f'8 e d c b8*5 a8 a4 gis 
  e2 a4 a 
  d,8 a' a4 bes a8. g16 
  f1 
  a4 c c c 
  d8 c c4 d8 bes g c16 bes 
  a2 a4 g 
  f8 a d dis d4 c 
  d c8 bes a2 
  c4 d c c 
  d8 c b4 a2 
  a4 d8 c bes4 a 
  bes a a2 
}


baixo = \relative c {
  d4. c8 b4. a8 
  gis4 a d e 
  a,2 d8 e f4 
  b,8 cis d4 g, a 
  d1 
  d4. c8 b4. a8 
  gis4 a d e 
  a,2 d8 e f4 
  b,8 cis d4 g, a 
  d1 
  d4 c8 bes a g f e 
  d e f4 bes c 
  f,2 d'4 e 
  f fis g a 
  bes c f,2 
  f8 e d4 e8 c f4 
  bes8 a gis4 a2 
  f8 e d4. cis8 d f 
  g e a4 d,2 
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