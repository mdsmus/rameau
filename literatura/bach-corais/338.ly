
\version "2.10.33"

\header {
  title = "338 - Jesus, meine Zuversicht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  a''4 g8 fis b4 cis 
  d d cis2 
  b8 cis d4 a8 g fis4 
  g fis e d 
  a' g8 fis b4 cis 
  d d cis2 
  b8 cis d4 a8 g fis4 
  g fis e d 
  fis gis ais b8 cis 
  d4 cis b2 
  cis4 d e fis 
  e e d2 
}


alto = \relative c {
  fis'4 e8 d d e4 fis8 
  fis4. e8 e2 
  e4 d e d 
  d d d8 cis a4 
  fis' e8 d d e4 fis8 
  fis4. e8 e2 
  e4 d e d 
  d d d8 cis a4 
  b8 fis'4 e8 fis4 fis8 e 
  fis4 fis fis2 
  g4 a a a 
  b a8 g fis2 
}


tenor = \relative c {
  a'4 a4. g4 a16 g 
  fis8 b a gis a2 
  b4 a a a 
  g a8 b b a16 g fis4 
  a a4. g4 a16 g 
  fis8 b a gis a2 
  b4 a a a 
  g a8 b b a16 g fis4 
  b b cis b 
  b ais8 e' d2 
  e4 fis e d 
  d cis a2 
}


baixo = \relative c {
  d4 d g, a 
  b e a,2 
  g'4 fis cis d8 c 
  b ais a gis a4 d 
  d d g, a 
  b e a,2 
  g'4 fis cis d8 c 
  b ais a gis a4 d 
  dis e4. d8 g4 
  fis8 e fis4 b,2 
  e4 d d8 cis d4 
  g a d,2 
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