
\version "2.10.33"

\header {
  title = "105 - Herzliebster Jesu, was hast du verbrochen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b b ais fis 
  b cis d d 
  e d cis cis 
  d e fis8 e d4 
  g g fis8 e fis4 
  e2 d4 d 
  cis b a8 g fis g 
  a4 a b a 
  g2 fis4 fis' 
  e d cis2 
  b1 
}


alto = \relative c {
  \partial 4 a''4 
  g gis fis cis 
  b fis' fis b 
  cis b ais fis 
  fis a a b8 a 
  g a b4 b b 
  e,8 fis g4 fis b 
  e, d e d8 e 
  fis4 fis g fis 
  fis8 dis e4 dis b' 
  b8 ais b4. gis8 ais4 
  fis1 
}


tenor = \relative c {
  \partial 4 fis'4 
  e d cis ais 
  e' e d8 e fis4 
  g fis fis ais, 
  b cis d8 cis b4 
  b e d8 cis d4 
  d cis a fis 
  gis8 ais b4 e, a 
  d d d8 e fis4 
  b,2 b4 d 
  cis fis, fis'4. e8 
  dis1 
}


baixo = \relative c {
  \partial 4 dis4 
  e f fis fis 
  gis ais b b 
  ais b fis fis 
  b a d, g8 fis 
  e fis g a b4 a8 gis 
  a2 d,4 d 
  e8 fis g4 cis, d 
  d'8 c b a g fis e dis 
  e2 b4 b 
  cis d8 e fis2 
  b,1 
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