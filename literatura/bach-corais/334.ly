
\version "2.10.33"

\header {
  title = "334 - Ihr Knecht cis Herren allzugleich"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d''4 d2 cis4 b2 
  a4 d e2 
  fis fis4 fis2 fis4 e2 
  fis4 g fis2 
  e d4 e2 fis4 e2 
  d4 b cis2 
  d a'4 fis2 d4 e2 
  g4 fis e2 
  d2. 
}


alto = \relative c {
  \partial 4 a''4 b2 a4 g2 
  fis4 fis b a 
  a2 cis4 b2 b4 b a 
  a a d a 
  a2 b4 a2 a4 b a8 g 
  fis4 b b ais 
  b2 a4 a2 b4 a2 
  a4 a g2 
  fis2. 
}


tenor = \relative c {
  \partial 4 fis'4 fis2 fis4 d2 
  d4 d2 cis4 
  d2 cis4 d2 d4 d cis 
  d e a, d 
  cis2 fis4 e2 d4 d cis 
  d d g fis 
  fis2 e4 fis2 fis4 e2 
  cis4 a b cis 
  a2. 
}


baixo = \relative c {
  \partial 4 d4 b 
  d fis g b 
  d b g a 
  d,2 ais'4 b2 a4 gis a 
  fis cis d fis 
  a2 b4 cis2 d4 g, a 
  b g e fis 
  b,2 cis'4 d 
  cis b cis b 
  a d g, a 
  d,2. 
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