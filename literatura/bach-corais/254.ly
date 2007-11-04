\version "2.10.33"

\header {
  title = "254 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key c \major
}


soprano = \relative c'' {
  \repeat volta 2 {
    c4 d4 e4 d4 
    c4 b4 a4 g4 
    c4 d4 e4 d8 e16 f16 
    e4 d8. c16 c2 }
  e4 f4 g4 f4   %5
  e4 d4 e2 
  g4 g4 a4 g4 
  f4 e4 d2 
  e4 g4 f4 e8 d8 
  c4 d4 e2   %10
  c2 e4 g4 
  f4 e4 d4 c4 
  d2 c2 
  
}

alto = \relative c'' {
  \repeat volta 2 {
    g4 g4 g4 g4 
    a4 d,4 d4 d4 
    g4 a8 b8 c8 g8 g4 
    g4 g4 g2 }
  g4 a8 ais16 c16 ais4 a4   %5
  g4 f8 a16 gis16 a2 
  g4 c4 c4 b4 
  a4 g8 fis8 g2 
  g4 c8 b8 a8 b8 c4 
  a4 a4 b4 e,4   %10
  e2 g8 a8 ais4 
  a8 b8 c4 g4 g4 
  g2 g2 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    e4 b4 c4 d4 
    e8 fis8 g4 g8 fis8 b,4 
    c4 f4 g8 c,8 d4~ 
    d8 c8 c8 b8 e2 }
  c4 c4 c4 c8 d8   %5
  e8 a,8 a8 b8 cis2 
  c8 d8 e4 f8 e8 d4 
  c4 c4 b2 
  c8 d8 e4 f4 g8 g,8 
  a8 e'8 d8 c8 b2   %10
  a2 ais4 e4 
  f4 g8 a8 b4 c4 
  c4 b4 e2 
  
}

baixo = \relative c {
  \repeat volta 2 {
    c4 g'4 c4 b4 
    a4 g4 d4 g4 
    e4 d4 c4 b4 
    c4 g4 c2 }
  c'4 a4 e4 f4   %5
  cis4 d4 a2 
  e'4 c4 f4 g4 
  a8 b8 c4 g2 
  c4 c,4 d4 e4 
  f4 fis4 g4 gis4   %10
  a2 g4 c,4 
  d4 e8 f8 g8 f8 e8 c8 
  g2 c2 
  
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