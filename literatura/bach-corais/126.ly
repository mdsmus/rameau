
\version "2.10.33"

\header {
  title = "126 - Durch Adams Fall ist ganz verderbt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a a g a 
  f e d a'8 b 
  c4 d a b 
  c b a a 
  a a g a 
  f e d a'8 b 
  c4 d a b 
  c b a c 
  c c8 ais a g f g 
  a4 g f a 
  a a g f8 e 
  e2 d4 a' 
  a g a b 
  c8 b a4 g d' 
  e d a8 b c4 
  b a b2 
  a1 
}


alto = \relative c {
  \partial 4 e'4 
  f f f e4. d4 cis8 d4 f 
  e d8 e f4 f 
  e d cis e 
  f f f e4. d4 cis8 d4 f 
  e d8 e f4 f 
  e d cis a' 
  g8 f e d c4 d8 e 
  f4 e f c8 d 
  e4 d d d 
  d cis d e 
  f4. e8 f a g f 
  e d c4 b g' 
  g f8 e d4 e 
  e8 d c4 f e8 d 
  cis1 
}


tenor = \relative c {
  \partial 4 a'4 
  d d d a 
  a4. g8 f4 d' 
  c8 b a4 d d 
  gis,8 a4 gis8 a4 a 
  d d d a 
  a4. g8 f4 d' 
  c8 b a4 d d 
  gis,8 a4 gis8 a4 e' 
  c g a a8 ais 
  c4. ais8 a4 a 
  a8 g f4 g8 a ais4 
  a4. g8 f4 a 
  d8 c ais4 c d 
  g,4. fis8 g4 b 
  c8 b a gis a4 a 
  gis a2 gis4 
  a1 
}


baixo = \relative c {
  \partial 4 cis4 
  d8 e f4 b, cis 
  d a d d 
  a'8 g f e d c b a 
  e'2 a,4 cis 
  d8 e f4 b, cis 
  d a d d 
  a'8 g f e d c b a 
  e'2 a,4 a' 
  e8 d c4 f8 e d4 
  a8 ais c4 f, f' 
  cis d8 c ais a g4 
  a2 d4 cis 
  d g f8 e d4 
  c d g, g' 
  c, d8 e f4 c8 d 
  e4 f8 e d4 e 
  a,1 
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