
\version "2.10.33"

\header {
  title = "339 - Wer nur den lieben Gott läßt walten"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  a b c b 
  a b gis4. fis8 
  e4 g g f 
  e a a gis 
  a2. e4 
  a b c b 
  a b gis4. fis8 
  e4 g g f 
  e a a gis 
  a2. b4 
  c d e e 
  d d c e 
  d c b a 
  c b a4 
}


alto = \relative c {
  \partial 4 e'4 
  e16 d f4 e16 d c8 a'4 g fis16 e fis8 fis fis e d c 
  b4 e8 d cis4 d 
  b8 c d e fis4 e 
  e2. e4 
  e16 d f4 e16 d c8 a'4 g fis16 e fis8 fis fis e d c 
  b4 e8 d cis4 d 
  b8 c d e fis4 e 
  e2. gis4 
  a b c8 g c ais 
  a4 b g g 
  f fis gis a 
  dis,8 fis f e16 d cis4 
}


tenor = \relative c {
  \partial 4 c'4 
  c8 b16 a gis8 e' e4 dis 
  e b b4. a8 
  gis4 e a a 
  gis8 a b c d c b4 
  cis2. c4 
  c8 b16 a gis8 e' e4 dis 
  e b b4. a8 
  gis4 e a a 
  gis8 a b c d c b4 
  cis2. e4 
  e16 c f4 e16 d c8 d e4 
  f8 d g f e4 c 
  c8 b a gis16 a e8 d' c b 
  a4. gis8 e4 
}


baixo = \relative c {
  \partial 4 a'8 g 
  f4 e a, b 
  cis dis e2 
  e4 cis a d 
  d8 c f e dis4 e 
  a,2. a'8 g 
  f4 e a, b 
  cis dis e2 
  e4 cis a d 
  d8 c f e dis4 e 
  a,2. e'4 
  a g8 f e d c4 
  d8 e16 f g8 g, c4 c 
  d dis e f 
  fis8 dis e e, a4 
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