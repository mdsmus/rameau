
\version "2.10.33"

\header {
  title = "300 - Warum betrübst du dich, mein Herz"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a8 b c4 b e 
  d c b c8 b 
  a4 e' d e 
  a,8 b cis4 d c 
  b e d c 
  b2. a8 b 
  c4 c d d 
  e e c e 
  d c b a8 b 
  c4 b a2 
}


alto = \relative c {
  \partial 4 e'4 
  e4. a8 a gis g4 
  f fis b, e 
  f g g g 
  f e f e 
  e e8 fis gis4 a 
  gis2. a8 gis 
  a4 a8 g f4 ais 
  ais a8 g a4 c 
  b a8 g fis gis a4 
  a gis e2 
}


tenor = \relative c {
  \partial 4 c'8 d 
  e4 a, b ais 
  a a gis a 
  a c c8 b16 a b8 cis 
  d4 a a a 
  gis a b c8 d 
  e2. e8 d 
  c4 dis d g 
  g f8 e f4 g 
  g8 f e4 d c8 d 
  e4. d8 cis2 
}


baixo = \relative c {
  \partial 4 a8 b 
  c4 g e' cis 
  d dis e a, 
  d c g' e 
  f8 g a4 d, a' 
  e c b a 
  e'2. c'8 b 
  a g f4 ais8 a g4 
  c c, f c' 
  g a d,8 e f4 
  c8 d e4 a,2 
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