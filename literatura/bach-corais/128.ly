
\version "2.10.33"

\header {
  title = "128 - Alles ist an Gottes Segen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  g''4 g d' d 
  c d b g 
  b b a a 
  g a fis d 
  a' a b8 a g fis 
  e4. d8 d2 
  d'4 d d e 
  c d b g 
  b b a a 
  g a fis d 
  g a b8 c d c 
  b4 a8 g g2 
}


alto = \relative c {
  d'4 d d8 a'4 g8 
  a4 a8 fis g4 d 
  g g g fis4. e16 d e8 cis d4 a 
  d d d d4. b8 cis4 a2 
  a'4 a gis8 a b4. a16 g a4 g d 
  g g8 fis e cis fis4. e16 d e8 cis d4 a 
  d8 b fis'4 g8 fis g2 fis4 d2 
}


tenor = \relative c {
  b'4 b a b 
  e d d b 
  d d d d 
  d8 b a4 a fis 
  fis8 g a fis g4 a 
  a4. g16 fis fis2 
  fis'4 fis f e 
  e d d b 
  d8 b e d cis a d4 
  d8 b a4 a fis 
  g d' d8 c b c 
  d4 d8. c16 b2 
}


baixo = \relative c {
  g'4 g fis g2 fis8 d g4 g, 
  g8 a b c d e fis d 
  b e cis a d4 d, 
  d'8 e fis d g4 d 
  a' a, d2 
  d8 d'4 c8 b a gis e 
  a g fis d g4 g, 
  g' g g fis8 d 
  b e cis a d4 d, 
  b'8 e d c b a g e' 
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