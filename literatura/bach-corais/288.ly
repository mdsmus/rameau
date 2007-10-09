
\version "2.10.33"

\header {
  title = "288 - Gelobet seist du, Jesu Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a a b a 
  d e d2 
  cis8 d e4 fis e8 d 
  cis4 b a a 
  d cis8 d e4 b 
  a8 gis fis4 e e 
  b' b b cis 
  d8 cis b4 a8 b cis4 
  b2 a4 a 
  a2 a 
}


alto = \relative c {
  \partial 4 cis'8 d 
  e4 fis fis8 e e4 
  a a8 g fis2 
  e8 fis g4 a8 fis b4 
  b8 a a gis e4 fis 
  fis8 g a4 a gis 
  fis8 e e dis b4 cis 
  dis dis e e 
  d4. e8 fis4 e8 fis 
  gis2 fis4 e4. d16 e fis4 e2 
}


tenor = \relative c {
  \partial 4 a'4 
  a d d cis 
  d8 e16 fis cis4 a2 
  a4 b cis8 d e4 
  e e cis d 
  d8 e fis4 e e8 b 
  b4 b gis a8 gis 
  fis4 b8 a gis4 ais 
  b8 a g4 fis8 gis a4 
  e'2 cis8 d e g, 
  fis a d4 cis2 
}


baixo = \relative c {
  \partial 4 fis4 
  cis d g4. fis16 e 
  fis8 d a'4 d,2 
  a'4 g fis gis 
  a e a, d8 cis 
  b4 fis' cis8 d e4 
  dis8 e b4 e a 
  a gis8 fis e d cis4 
  b4. cis8 d4 cis8 dis 
  e2 fis4 cis 
  d2 a 
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