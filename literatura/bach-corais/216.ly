
\version "2.10.33"

\header {
  title = "216 - Es ist genug"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  a''2 b4 cis 
  dis2 s4 dis 
  e b b d 
  cis2. b4 
  cis8 dis e4 e dis 
  e2 a, 
  b4 cis dis2 
  s4 dis e b 
  b d cis2 
  s4 b cis8 dis e4 
  e dis e2 
  s4 b b b 
  cis b d cis 
  cis2 b 
  s4 b b b 
  cis b d cis 
  cis2 b 
  s4 e cis b 
  a2 s4 e' 
  cis b a2 
}


alto = \relative c {
  e'2 e4 d8 cis 
  gis'2 s4 gis 
  gis4. a8 gis fis gis e 
  a2. gis4 
  a8 b cis4 b a16 gis a8 
  gis2 e 
  e4 e fis2 
  s4 fis8 gis16 a gis8 fis gis a 
  b4 gis a2 
  s4 fis g8 a b4 
  b8 a16 gis a8 fis gis2 
  s4 gis8 a b a b gis 
  a4 b a a 
  a8 gis a fis gis2 
  s4 fis b, b' 
  ais a gis a 
  a8 fis dis4 e2 
  s4 e e fis8 gis 
  fis2 s4 b 
  a gis e2 
}


tenor = \relative c {
  cis'2 b4 fis' 
  fis2 s4 c 
  cis8 dis e4 e e 
  e2. e4 
  e8 fis g4 fis b, 
  b2 cis 
  b4 a a2 
  s4 b b e 
  e e e2 
  s4 dis e8 fis g4 
  fis b, b2 
  s4 e e e 
  e e fis e 
  e dis e2 
  s4 dis e f 
  e d e fis 
  e8 a, fis4 gis2 
  s4 b a a8 gis 
  cis2 s4 e 
  e d16 cis d8 cis2 
}


baixo = \relative c {
  a'2 gis4 ais 
  c2 s4 gis 
  cis8 b16 a gis8 fis e d cis b 
  a2. e'4 
  a ais b b, 
  e2 a 
  gis4 g fis2 
  s4 b, e4. fis8 
  gis4 fis8 e a2 
  s4 a g8 fis e4 
  b' b, e2 
  s4 e8 fis gis fis gis e 
  a b a gis fis gis a a, 
  e'2 e 
  s4 a gis g 
  fis f e dis 
  e2 e 
  s4 gis a8 cis, dis f 
  fis2 s4 gis 
  a e a,2 
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