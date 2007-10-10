
\version "2.10.33"

\header {
  title = "295 - Rex Christe factor omnium"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b a b g 
  fis8 g16 a fis4 e e8 fis 
  g4 a b a 
  d cis b b 
  e fis e b 
  cis b a a8 b 
  cis4 dis e d 
  cis8 d16 e cis4 b2 
}


alto = \relative c {
  \partial 4 dis'4 
  e e fis e 
  e dis b b 
  e d d d8 e 
  fis4 fis8. e16 dis4 e 
  e d e f 
  fis4. f8 fis4 fis8 gis 
  a4 a b8 cis4 b8 
  b ais16 gis ais4 fis2 
}


tenor = \relative c {
  \partial 4 fis4 
  g a8 g fis4 b 
  c b8 a g4 g8 a 
  b4 a g fis 
  b4. ais8 fis4 g 
  a a8 b cis4 d 
  cis g8 cis cis4 d 
  e fis e8 cis d fis 
  g cis, fis e dis2 
}


baixo = \relative c {
  \partial 4 b4 
  e c' dis, e 
  a, b e, e 
  e' fis g d8 cis 
  b4 fis' b, e8 d 
  cis4 d a' gis 
  a8 b cis4 fis, d 
  a' gis8 fis gis ais b4 
  e, fis b,2 
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