
\version "2.10.33"

\header {
  title = "83 - Jesu Kreuz, Leiden und Pein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  cis''4 b a b 
  cis d e2 
  fis4 e d cis8 b 
  b2 a 
  cis4 e d cis 
  b a gis2 
  a4 b cis cis8 d16 e 
  d2 cis 
  cis8 b cis d e4 d 
  cis b cis2 
  b4 b cis8 dis e4 
  e dis e2 
  e4 cis fis4. e8 
  d4 cis8 b b2 
  cis4 cis8 d16 e d4 cis8 b 
  b2 a 
}


alto = \relative c {
  a''4 gis fis e 
  e fis g2 
  fis4 gis a8 b e, a 
  a4 gis e2 
  a4 b a a 
  gis fis f2 
  fis4 e e fis 
  fis8 a gis fis gis2 
  fis4 fis cis8 gis' a b 
  a4 gis a2 
  fis4 e a b 
  cis b8 a gis2 
  gis4 a a g 
  g8 fis e4 d2 
  fis4 e8 fis gis4 a 
  a8 fis gis4 e2 
}


tenor = \relative c {
  fis'4 cis cis b 
  a a a2 
  d4 cis cis8 b cis d 
  e4 d8 cis cis2 
  e4 e fis e 
  d cis cis2 
  cis4 b a8 b cis4 
  cis b8 a b2 
  a4 a' gis fis 
  e e e2 
  dis4 e e8 fis g4 
  fis b, b2 
  cis4 cis c b8 ais 
  b4 ais b2 
  a4 a b e, 
  e' d16 cis d8 cis2 
}


baixo = \relative c {
  fis4 f fis gis 
  a fis cis2 
  d4 e fis8 gis a4 
  e2 a, 
  a'4 gis fis8 gis a4 
  f fis cis2 
  fis4 gis a ais 
  b2 f 
  fis8 gis a b cis4 fis,8 gis 
  a4 e a,2 
  a'4 gis g fis8 e 
  ais4 b e,2 
  cis4 fis d g 
  e fis b,2 
  fis'8 e d cis b4 cis8 d 
  e2 a, 
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