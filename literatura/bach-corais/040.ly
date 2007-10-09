
\version "2.10.33"

\header {
  title = "40 - Ach Gott und Herr, wie groß und schwer"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 c''4 
  b a g g 
  a b c d 
  c b a b8 c 
  a2 g4 c 
  b c d d 
  e d8 c d4 g, 
  a b c8 d e f 
  d2 c 
}


alto = \relative c {
  \partial 4 g''4 
  g fis d e8 d 
  c4 d e g4. fis8 g4 fis g2 fis4 d g 
  f g g g 
  g fis g g 
  d d c4. a'8 
  g4. f8 e2 
}


tenor = \relative c {
  \partial 4 e'4 
  d4. c8 b4 c8 ais 
  a g f4 g b 
  c d d d 
  e d8 c b4 c 
  d e b b 
  c c b c 
  c b e8 f g c, 
  c4 b g2 
}


baixo = \relative c {
  \partial 4 c4 
  g' d g, c 
  f8 e d4 c g 
  a b8 c d4 g 
  c, d g, e' 
  d c g' g 
  c8 b a4 g e 
  fis gis a g8 f 
  g4 g, c2 
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