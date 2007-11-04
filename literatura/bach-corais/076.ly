\version "2.10.33"

\header {
  title = "76 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key a \major
}


soprano = \relative c'' {
  \repeat volta 2 {
    a4 b4 cis4 b4 
    a4 gis4 fis2 
    e2 a4 b4 
    cis4 d4 cis4 b4 
    a1 }  %5
  cis4 d4 e4 d4 
  cis4 b4 cis2 
  e4 e4 fis4 e4 
  d4 cis4 b2 
  cis8 d8 e4 d4 cis8 b8   %10
  a4 b4 cis2 
  a2 cis8 d8 e4 
  d4 cis4 b4 cis8. d16 
  b2 a2 
  
}

alto = \relative c' {
  \repeat volta 2 {
    e4 e4 a4 dis,4 
    e8 fis8 fis8 e8 e4 dis4 
    b2 fis'4 fis8 e8 
    e4 b'4 b8 a8 a8 gis8 
    e1 }  %5
  a4 a8 g8 g4 fis8 gis8 
  ais4 b8 b,8 fis'2 
  e4 a8 g8 fis4 gis4 
  a8 e4 fis8 gis2 
  a4 b4 a4 gis4   %10
  gis8 fis8 fis8 gis8 a4 gis4 
  fis2 ais4 b8 fis8 
  fis8 gis8 a4 gis4 a4~ 
  a8 gis16 fis16 gis4 e2 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    cis4 e4 e8 fis8 fis8 gis8 
    cis,8 b8 b4 cis4 b8 a8 
    gis2 cis4 b4 
    b8 a8 a8 gis8 e'4 e8 d8 
    cis1 }  %5
  e4 b4 b8 ais8 b4 
  fis8 fis'4 e8 ais,2 
  a8 b8 cis4 cis8 b8 b8 cis8 
  cis8 b8 cis8 dis8 e2 
  e4 e4 a,8 b8 cis4   %10
  cis4 d8 b8 fis'4. f8 
  cis2 fis4 b,8 cis8 
  d4 e4 e4 e4 
  e4. d8 cis2 
  
}

baixo = \relative c' {
  \repeat volta 2 {
    a4 gis4 a4 b4 
    cis8 dis8 e4 a,4 b4 
    e,2 fis4 gis4 
    a4 b4 cis8 d8 e8 e,8 
    a1 }  %5
  a,4 b4 cis4 d8 e8 
  fis4 g4 fis2 
  cis8 b8 a4 d4 e4 
  fis8 gis8 a4 e2 
  a4 a8 gis8 fis4 f4   %10
  fis8 e8 d4 a'8 b8 cis4 
  fis,2 fis4 gis8 ais8 
  b4 cis8 d8 e,8 d8 cis8 a8 
  e'2 a,2 
  
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