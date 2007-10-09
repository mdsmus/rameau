
\version "2.10.33"

\header {
  title = "28 - Nun komm, der Heiden Heiland"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  b''4 b a d 
  cis8 b cis4 b2 
  b8 cis d4 e d 
  e fis d2 
  d4 e fis8 e d4 
  e8 d cis4 b2 
  b4 b a d 
  cis8 b cis4 b2 
}


alto = \relative c {
  fis'4 e fis fis8 g16 a 
  g8 fis e4 d2 
  fis4 fis8 gis a4 a8 b 
  cis4 d8 fis, g2 
  a4 a a8 ais b4 
  cis8 b ais4 fis2 
  fis4 f fis8 gis a b 
  fis b4 ais8 fis2 
}


tenor = \relative c {
  d'4 cis8 b cis4 b 
  b4. ais8 fis2 
  d'8 cis b4 cis d 
  g, a8 b16 c b2 
  a4 e' d8 cis b4 
  g' cis,8 fis d2 
  d4 cis8 b cis4 fis 
  e8 d cis16 d e8 dis2 
}


baixo = \relative c {
  b'8 a g4 fis8 e d b 
  e d e fis b,2 
  b4 b' a8 g fis4 
  e d g2 
  fis8 e d cis d4 g8 fis 
  e4 fis b,2 
  b'8 a gis4 fis8 e fis gis 
  ais b fis4 b,2 
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