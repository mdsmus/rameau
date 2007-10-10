
\version "2.10.33"

\header {
  title = "361 - Ermuntre dich, mein schwacher Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g a b8 cis d4 
  d cis d b 
  c b a b 
  a2 g4 g 
  g a b8 cis d4 
  d cis d b 
  c b a b 
  a2 g4 a 
  a b c c 
  b8 a b4 a b 
  b b c8 d e4 
  e dis e fis 
  g b, c b 
  a2 a4 d 
  e d c b8 c 
  a2 g 
}


alto = \relative c {
  \partial 4 d'4 
  e fis d8 e fis4 
  e8 fis g4 fis fis 
  e d8 e fis4 g 
  g fis d d 
  e fis d8 e fis4 
  e8 fis g4 fis fis 
  e d8 e fis4 g 
  g fis d fis8 g 
  a4. gis8 a gis a4 
  a gis e e8 dis 
  e4 e e8 fis g fis 
  fis g a4 g a 
  g8 a b4 b8 a a g 
  g2 fis4 g8 fis 
  e4 fis g8 a d,4 
  e d d2 
}


tenor = \relative c {
  \partial 4 b'4 
  b8 c4 d8 b a a4 
  a a a b8 a 
  g a b c d4 d 
  d4. c8 b4 b 
  b8 c4 d8 b a a4 
  a a a b8 a 
  g a b c d4 d 
  d4. c8 b4 d8 e 
  fis e d4 e fis 
  b, e8 d c4 g8 a 
  b c d e c4 cis 
  b b b d8 c 
  d4 g g,8 a b4 
  e8 d e cis d4 d 
  d8 c c b b a g4 
  g8 <fis c' >16 <e b' >16 <fis a >8 b16 s16 <b g >2 
}


baixo = \relative c {
  \partial 4 g'8 fis 
  e4 d g fis8 g 
  a4 a, d dis 
  e8 fis g c, c' b a g 
  d'4 d, g g8 fis 
  e4 d g fis8 g 
  a4 a, d dis 
  e8 fis g c, c' b a g 
  d'4 d, g d 
  d'8 c b4 a dis, 
  e e a, e'8 fis 
  g4 gis a ais 
  b b, e d'8 c 
  b a g fis e fis g e 
  cis b cis a d4 b 
  c d e8 fis g4 
  c, d g,2 
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