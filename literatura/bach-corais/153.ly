
\version "2.10.33"

\header {
  title = "153 - Alle Menschen müssen sterben 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  a''4 d a b 
  a4. g8 fis4 fis 
  a a g fis 
  e4. d8 d2 
  a'4 d a b 
  a4. g8 fis4 fis 
  a a g fis 
  e4. d8 d2 
  e4 e fis8 gis a4 
  a4. gis8 a4 a 
  b4. cis8 d4 d 
  cis4. cis8 b4 b 
  fis fis b a 
  a gis a2 
  b4 a g fis 
  e4. d8 d2 
}


alto = \relative c {
  d'4 d d d 
  d cis d d 
  d d8 cis b cis d2 cis4 d2 
  d4 d d d 
  d cis d d 
  d d8 cis b cis d2 cis4 d2 
  cis4 cis d cis 
  fis e8 d cis4 cis 
  e8 fis g4 fis fis 
  fis4. e8 d4 d 
  d d d cis 
  d d cis2 
  d4 d8 cis b cis d4 
  d cis d2 
}


tenor = \relative c {
  fis4 fis8 g a4 g8 fis 
  e d e4 d d 
  fis fis g a 
  b a8. g16 fis2 
  fis4 fis8 g a4 g8 fis 
  e d e4 d d 
  fis fis g a 
  b a8. g16 fis2 
  a4 a a a 
  b b a a 
  g4. a8 b2. ais4 b2 
  a4 a g8 fis e4 
  d8 fis e d e2 
  g4 fis g a 
  b a8. g16 fis2 
}


baixo = \relative c {
  d4 b fis g 
  a a d, d 
  d' d e fis 
  g8 fis a a, d2 
  d4 b fis g 
  a a d, d 
  d' d e fis 
  g8 fis a a, d2 
  a4 a d fis8 e 
  d4 e a,2 
  e' b8 cis d e 
  fis2 b, 
  d4 d g, a 
  b2 a 
  g4 d' e fis 
  g8 e a a, d2 
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