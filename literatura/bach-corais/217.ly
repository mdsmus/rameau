
\version "2.10.33"

\header {
  title = "217 - Herr Jesu Christ, meins Lebens Licht"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key c \major
}

soprano = \relative c {
  c''4 c c a 
  b c d c 
  b a2. 
  a4 b c d2 c4 b a2 g2. 
  e'4 e e c 
  d e f e2 d2. 
  c4 d e d2 c4 c b2 c2. 
}


alto = \relative c {
  e'4 g g f 
  g g a2 
  g4 fis2. 
  fis4 g g g2 g4 g g 
  fis g2. 
  g4 e gis a 
  b cis d c2 g2. 
  g4 b c c 
  b e, a g2 g2. 
}


tenor = \relative c {
  g'4 c e c 
  d e d2 
  d4 d2. 
  d4 d e d2 e4 d d4. c8 b2. 
  c4 b e e 
  f g f g 
  c, b2. 
  c4 f, g a 
  b c d d2 e2. 
}


baixo = \relative c {
  c4 e c f2 e4 fis2 
  g4 d2. 
  d4 g e b2 c4 g' d2 g,2. 
  c'4 gis e a2 a,4 d e 
  f g2. 
  e4 d c f 
  g a fis g 
  g, c2. 
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