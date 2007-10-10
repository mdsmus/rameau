
\version "2.10.33"

\header {
  title = "331 - Auf meinen lieben Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b cis d e 
  fis2. fis4 
  fis e d e 
  cis2. cis4 
  d e fis fis 
  e2 fis4 fis 
  d e fis fis 
  e2 d4 fis 
  a fis fis fis 
  e2 e4 e 
  fis e d e8 d 
  cis2 b4 
}


alto = \relative c {
  \partial 4 fis'4 
  g fis fis g 
  cis,2. fis4 
  gis ais b cis 
  ais2. ais4 
  b e, d a' 
  a2 ais4 fis 
  fis8 gis a4 a a 
  b a a a 
  a d cis b 
  b2 e,4 b' 
  cis cis fis, g 
  g fis fis4
}


tenor = \relative c {
  \partial 4 d'4 
  e e d cis8 b 
  ais2. a4 
  b cis d g 
  fis2. fis,4 
  fis a a4. b8 
  cis2 cis4 cis 
  b cis d d 
  d cis d d 
  e fis,8 d' e cis d4 
  d2 cis4 b 
  fis' ais, b b 
  e8 d cis4 dis4
}


baixo = \relative c {
  \partial 4 b'4 
  e ais, b8 a g4 
  fis2. e4 
  d cis b e 
  fis2. fis4 
  b, cis d8 e fis g 
  a b a g fis gis ais fis 
  b4 a8 g fis e d fis 
  g e a a, d4 d' 
  cis d ais b8 a 
  gis fis gis e a4 g 
  fis8 e d cis b' a g fis 
  e cis fis fis, b4
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