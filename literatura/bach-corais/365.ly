
\version "2.10.33"

\header {
  title = "365 - Werde munter, mein Gemüte"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  cis''4 d e e 
  d cis b b 
  cis d e8 d cis4 
  b b a2 
  cis4 d e e 
  d cis b b 
  cis d e8 d cis4 
  b b a2 
  b4 cis d d 
  cis cis b2 
  d4 e fis fis 
  e e d2 
  cis4 d e e 
  d cis b b 
  cis d e8 d cis4 
  b b a2 
}


alto = \relative c {
  a''4 a gis a 
  a8 gis a4 gis gis 
  a a b4. a8 
  a4 gis e2 
  a4 a gis a 
  a8 gis a4 gis gis 
  a a b4. a8 
  a4 gis e2 
  gis4 ais b b 
  b ais fis2 
  fis4 a a4. b16 c 
  b4 a8 g fis2 
  e4 a e8 fis g4 
  fis8 gis e fis gis4 gis 
  a a b8 gis a4 
  a gis e2 
}


tenor = \relative c {
  e'4 fis e8 d cis4 
  d e e e 
  e fis e4. fis16 g 
  fis4 e8 d cis2 
  e4 fis e8 d cis4 
  d e e e 
  e fis e4. fis16 g 
  fis4 e8 d cis2 
  e4 e fis fis 
  fis8 g fis e d2 
  d4 cis d d 
  d cis a2 
  a4 a b cis4. b4 a8 e'4 e 
  e fis e e 
  fis e8 d cis2 
}


baixo = \relative c {
  a'4 fis cis fis 
  b, cis8 d e4 e 
  a8 gis fis4 gis a 
  d, e a,2 
  a'4 fis cis fis 
  b, cis8 d e4 e 
  a8 gis fis4 gis a 
  d, e a,2 
  e'4 d8 cis b cis d e 
  fis4 fis b,2 
  b'4 a8 g fis e d4 
  g a d,2 
  a'8 gis fis4 g ais, 
  b cis8 d e4 e 
  a,8 a' gis fis gis e a cis, 
  d b e4 a,2 
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