
\version "2.10.33"

\header {
  title = "280 - Eins ist not, ach Herr, dies eine"
  composer = "J. S. Bach"
}

global =  {
  \key d \major
  \time 4/4 
}

soprano = \relative c {
  a''4 g8 fis b4 b 
  cis cis d d 
  b4. a8 g4 a 
  g8 fis e fis d2 
  a'4 g8 fis b4 b 
  cis cis d d 
  b4. a8 g4 a 
  g8 fis e fis d2 
  d8 e fis4 fis fis 
  e e e8 fis g4 
  g g8 fis fis4 fis 
  fis b4. a8 g4 
  a4. g8 fis4 g 
  fis e d d 
  d8 e fis4 fis fis 
  e e e8 fis g4 
  g g fis2 
  fis4 b4. a8 g4 
  a4. g8 fis4 g 
  fis e d2. 
}


alto = \relative c {
  fis'4 d d g8 fis 
  e4 a8 g fis4 fis 
  d g8 fis e4 e 
  d cis a2 
  e'4 d fis e8 d 
  cis4 fis fis fis 
  g8 fis e4 d e 
  e8 d d cis a2 
  a4 d d d 
  cis8 b cis d e4 e 
  e e d8 cis d e 
  fis4 g4. fis8 e4 
  e8 d cis4 d d 
  d cis a a 
  a d d d 
  d cis8 b cis d e4 
  e e e d 
  s4 d g8 fis e4. g8 fis e d a d4. e8 cis4 a2. 
}


tenor = \relative c {
  d'4 a b e8 d 
  cis b a4 a a 
  g8 a b4 b a 
  a a8 g fis2 
  a4 a a8 fis g b4 gis8 ais4 b b 
  d cis b8 g e a 
  a4 a fis2 
  fis8 g a4 a a8 b 
  cis d e d cis4 b 
  b b8 cis d e fis e 
  d cis b a g a b4 
  a a a g8 a 
  b4 e, fis fis 
  fis b b a 
  b a8 gis a4 a 
  b cis a2 
  a4 d8 cis b4. b8 
  a4. cis8 d4 d, 
  a' a8 g fis2. 
}


baixo = \relative c {
  d4 d g8 fis e4 
  a8 g fis e d4 d 
  g8 fis e4 e8 d cis4 
  d a d2 
  cis4 d dis e 
  f fis b, b 
  g a b cis 
  d a d2 
  d4 d8 cis d e fis g 
  a4 a, a' e8 dis 
  e fis g a b4 b, 
  b'8 a g fis e4 e8 d 
  cis b a4 d8 cis b a 
  g4 a d d 
  d8 cis b4 b'8 a g fis 
  gis4 e a cis, 
  d8 cis b a d2 
  s4 b e e8 d 
  cis a d4. cis8 b4 
  a8 g a4 d2. 
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