
\version "2.10.33"

\header {
  title = "353 - Allein Gott in der Höh sei Ehr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''8 a 
  b4 c d c 
  b a b b 
  b a8 b c b a4 
  g8. a16 a4 g g8 a 
  b4 c d c 
  b a b b 
  b a8 b c b a4 
  g8. a16 a4 g g 
  a b c b 
  a4. gis8 a4 a 
  b c d c 
  b a b b 
  b a8 b c b a4 
  g8. a16 a4 g2 
}


alto = \relative c {
  \partial 4 d'8 fis 
  g4 g fis e8 fis 
  g4 g8 fis g4 g 
  g fis8 g a g fis4 
  g4. fis8 d4 d8 fis 
  g4 g fis e8 fis 
  g4 g8 fis g4 g 
  g fis8 g a g fis4 
  g4. fis8 d4 d 
  d d e e 
  e8 c f e e4 fis 
  g f e e8 fis 
  g4. fis16 e dis4 e 
  d8 e fis g a g4 fis8 
  e d e d d2 
}


tenor = \relative c {
  \partial 4 b'8 c 
  d4 e a, a 
  d d d e 
  d d e8 d d c 
  b4 e8 d16 c b4 b8 c 
  d4 e a, a 
  d d d e 
  d d e8 d d c 
  b4 e8 d16 c b4 b 
  a g g gis 
  a d c a 
  d c b c8 d 
  e4 e, fis g8 a 
  b c d g, fis g16 fis e8 fis 
  g4. fis8 b2 
}


baixo = \relative c {
  \partial 4 g4 
  g'8 fis e4 d a 
  b8 c d4 g, e' 
  b8 c d4 a8 b c d 
  e d c d g,4 g 
  g'8 fis e4 d a 
  b8 c d4 g, e' 
  b8 c d4 a8 b c d 
  e d c d g,4 g' 
  fis f e d 
  c8 f d e a,4 d8 c 
  b4 a gis a 
  e'8 d c4 b e8 fis 
  g4 fis8 e dis e cis dis 
  e b c d g,2 
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