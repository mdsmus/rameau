
\version "2.10.33"

\header {
  title = "146 - Wer nur den lieben Gott läßt walten"
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
  e a a8 b gis4 
  a2. e4 
  a b c b 
  a b gis4. fis8 
  e4 g g f 
  e a a8 b gis4 
  a2. b4 
  c d e e 
  d8 e16 f d4 c e 
  d c b a8 b 
  c b b4 a2. 
}


alto = \relative c {
  \partial 4 c'8 d 
  e4 e e8 fis gis4 
  a8 g f4 e2 
  b4 e e d 
  d8 cis d dis e fis e4 
  e2. c8 d 
  e4 e e8 fis gis4 
  a8 g f4 e2 
  b4 e e d 
  d8 cis d dis e fis e4 
  e2. gis4 
  a g g a 
  a g8 f e4 e 
  fis8 gis a4 g8 f e4 
  fis e8 d cis2. 
}


tenor = \relative c {
  \partial 4 a'8 b 
  c b a gis a4 d, 
  e8 e' d c b4. a8 
  gis4 b c d8 c 
  b a a b c b4 c16 d 
  c2. a8 b 
  c b a gis a4 d, 
  e8 e' d c b4. a8 
  gis4 b c d8 c 
  b a a b c b4 c16 d 
  c2. e4 
  e d c c 
  c b g a 
  a8 e' e dis d4 c8 b 
  a4 gis e2. 
}


baixo = \relative c {
  \partial 4 a'4 
  c, e a, b 
  c d e2 
  e4 e a b8 a 
  gis g fis f e dis e4 
  a,2. a'4 
  c, e a, b 
  c d e2 
  e4 e a b8 a 
  gis g fis f e dis e4 
  a,2. e'4 
  a b c8 b a g 
  f d g4 c, cis 
  d8 e f fis g gis a4 
  dis, e a,2. 
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