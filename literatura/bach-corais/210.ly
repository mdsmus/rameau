
\version "2.10.33"

\header {
  title = "210 - Christe, du Beistand deiner Kreuz-gemeine"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 d'4 
  d e f2 
  e a4 b 
  c d8 c b2 
  a s4 c 
  b a g g 
  a g f f 
  e2 f4 e 
  e f g2 
  e a4 b 
  c d8 c b2 
  a s4 fis 
  g g g fis 
  g2 s4 e 
  f g e2 
  d1 
}


alto = \relative c {
  \partial 4 a'4 
  a e' e d 
  cis2 e4 e 
  a a a gis 
  e2 s4 a4. g8 f e d4 g4. f4 e d8 c d 
  c2 c4 cis8 d 
  e4. d4 c8 d b 
  c2 a'4 a4. gis8 a4 a gis 
  e2 s4 c 
  d d dis d 
  d2 s4 cis 
  d d2 cis4 
  d1 
}


tenor = \relative c {
  \partial 4 f8 g 
  a4 a a2 
  a a4 e' 
  e d8 e f4 e8 d 
  c2 s4 e 
  f8 e16 d c4 b c 
  c c a a 
  g8 a ais4 a a 
  a a g2 
  g e'4 f 
  e d8 e f4 e8 d 
  c2 s4 a 
  g4. f8 dis ais' a c 
  ais2 s4 a 
  a g8 ais a e a g 
  fis1 
}


baixo = \relative c {
  \partial 4 d8 e 
  f e d cis d e f d 
  a2 c8 b a gis 
  a c f e d b e4 
  a,2 s4 a 
  d8 e f2 e4 
  f c d a8 ais 
  c2 f,4 a 
  cis d8 c b a b g 
  c2 c4 d 
  e f8 e d4 e 
  a,2 s4 a 
  ais b c d 
  g,2 s4 a 
  d8 c ais g a2 
  d1 
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