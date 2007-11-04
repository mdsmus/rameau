\version "2.10.33"

\header {
  title = "60 - O stilles Gotteslamm"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key d \major
}


soprano = \relative c' {
  \repeat volta 2 {
    \partial 4 fis8  g8 
    a4 b4 a4 g8 fis8 
    fis2 r4 a4 
    b4 cis4 d4 d8 cis8 
    cis2 b4 } e8 d8 
  cis4 d8 cis8 b4. a8   %5
  a2. a4 
  b4 cis4 d4. d8 
  cis2. a4 
  a4 b4 a4 g8 fis8 
  fis2 r4 a4   %10
  b8 cis8 d4 d4 cis4 
  d1 
  
}

alto = \relative c' {
  \repeat volta 2 {
    \partial 4 d8  cis8 
    d4 d4 d8 cis16 b16 cis4 
    d2 r4 fis4 
    gis4 ais4 b4 gis4 
    fis4. e8 d4 } e4 
  e4 fis4 fis8 d8 e4   %5
  e2. e4 
  e8 fis8 gis4 a4 e4 
  e2. e4 
  fis4 g8 fis8 e4 e4 
  d2 r4 d4   %10
  d4 e4 e8 fis8 g4 
  fis1 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    \partial 4 a4 
    a4 g4 a4 a4 
    a2 r4 a4 
    e'4 e4 fis4 b,4 
    b4 ais4 b4 } b4 
  a4 a4 a4 gis4   %5
  cis2. cis4 
  b4 e4 d8 cis8 b4 
  a2. cis4 
  d4 g,4 a8 b8 cis4 
  b2 r4 a4   %10
  g8 a8 b4 a4 a4 
  a1 
  
}

baixo = \relative c {
  \repeat volta 2 {
    \partial 4 d8  e8 
    fis4 g4 a4 a,4 
    d2 r4 d4 
    d4 cis4 b8 cis8 d8 e8 
    fis2 b,4 } gis'4 
  a8 gis8 fis8 e8 d8 b8 e4   %5
  a,2. a'4 
  gis4 e4 fis4 gis4 
  a2. g4 
  fis4 e8 d8 cis4 a4 
  b2 r4 fis'4   %10
  g4 gis4 a4 a,4 
  d1 
  
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