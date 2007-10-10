
\version "2.10.33"

\header {
  title = "139 - Warum sollt ich mich denn grämen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  g''4 g a g 
  a8 b c4 c b 
  c2 d4 e 
  c2 b8 c d4 
  a2 d4 d 
  c b8 a a2 
  g g4 g 
  a g a8 b c4 
  c b c2 
  d4 e c2 
  b8 c d4 a2 
  d4 d c b8 a 
  a2 g 
}


alto = \relative c {
  d'4 e d d 
  e f g2 
  g b8 a b4 
  a2 g4 g 
  fis2 fis4 g 
  g g g fis 
  d2 e4 b8 cis 
  d c b4 c8 d c d 
  e4 d c2 
  fis4 gis e2 
  g4 fis8 g a2 
  g4 g8 fis g a d, e 
  fis g4 fis8 d2 
}


tenor = \relative c {
  b'4 c fis, g 
  c c8 d e4 d 
  e2 g8 f e4 
  e2 e4 d 
  d2 a4 b 
  c d e d8 c 
  b2 c4 g 
  fis g g8 f g a 
  g4 e' e2 
  d8 c b4 a2 
  g8 a b g d'2 
  b8 c d4 e8 fis g4 
  d8 c16 b c4 b2 
}


baixo = \relative c {
  g'4 c,2 b4 
  a gis g2 
  c g'4 gis 
  a2 e4 b8 c 
  d2 d4 g8 fis 
  e4 d c d 
  g,2 c8 d e4 
  d8 e f4 e8 d e fis 
  g4 gis a2 
  b4 e, a2 
  e4 d8 e fis2 
  g8 a b4. a8 b c 
  d4 d, g2 
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