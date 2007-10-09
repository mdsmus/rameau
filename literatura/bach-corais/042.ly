
\version "2.10.33"

\header {
  title = "42 - Du Friedefürst, Herr Jesu Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 cis''4 
  a b cis e 
  d d cis e 
  d cis b b 
  cis2. cis4 
  a b cis e 
  d d cis e 
  d cis b b 
  cis2. b4 
  b b cis b 
  a b gis gis 
  a b cis b8 cis 
  d4 cis b2 
  a1 
}


alto = \relative c {
  \partial 4 a''4 
  fis gis a b 
  a b a a 
  a a a gis 
  a2. a4 
  fis gis a b 
  a b a a 
  a a a gis 
  a2. gis4 
  e gis a gis 
  fis gis f f 
  fis gis a e 
  a a a gis 
  a1 
}


tenor = \relative c {
  \partial 4 e'4 
  d d e e 
  fis e e e 
  fis e fis e 
  e2. e4 
  d d e e 
  fis e e e 
  fis e fis e 
  e2. e4 
  b e e e8 d 
  cis4 d cis cis 
  cis e e2 
  d4 e fis e8 d 
  cis1 
}


baixo = \relative c {
  \partial 4 a4 
  d8 cis b4 a gis 
  fis gis a cis 
  fis8 gis a4 d, e 
  a,2. a4 
  d8 cis b4 a gis 
  fis gis a cis 
  fis8 gis a4 d, e 
  a,2. e'8 fis 
  gis4 e a e 
  fis b, cis cis 
  fis e a gis 
  fis e d e 
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