\version "2.10.33"

\header {
  title = "298 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}


global = {
  \time 3/4
  \key c \major
}


soprano = \relative c'' {
  \repeat volta 2 {
    c2 d4 
    e2 d4 
    c2 b4 
    a2. 
    g2.     %5
    c2 d4 
    e2 f4 
    e4 d2 
    c2. }
  e2 f4   %10
  g2 f4 
  e4 d2 
  e2. 
  g4 g2 
  a2 g4   %15
  f4 e2 
  d2. 
  e2 g4 
  f2 e4 
  c4 d2   %20
  e2. 
  c2. 
  e2 g4 
  f2 e4 
  d2 e4   %25
  d2. 
  c2. 
  
}

alto = \relative c'' {
  \repeat volta 2 {
    g2 g4 
    g2 fis4 
    g4 a4 g4 
    e4 fis2 
    d2.     %5
    c2 g'4 
    g2 a4 
    e4 a4 g4 
    g2. }
  g2 a4   %10
  ais2 a4 
  e4 a4 g4 
  g2. 
  c4 ais2 
  a4 b4 c4   %15
  c4 g2 
  g2. 
  g2 g4 
  a2 g4 
  f4 d4 g4   %20
  g2. 
  f2. 
  g2 g4 
  g2 g4 
  f4 d4 g4   %25
  g2. 
  g2. 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    e2 b4 
    c4 b4 a4 
    e'4 d4 d4 
    c4 a2 
    b2.     %5
    g2 b4 
    c2 c4 
    c2 b4 
    g2. }
  c2 c4   %10
  g2 c4 
  c2 b4 
  g2. 
  e'4 e2 
  c4 d4 e4   %15
  c2 c4 
  b2. 
  c2 c4 
  c2 b4 
  c4 b2   %20
  c2 ais4 
  a2. 
  c2 e4 
  d2 c4 
  a4 g2   %25
  g8 d'8 f8 e8 f4 
  e2. 
  
}

baixo = \relative c' {
  \repeat volta 2 {
    c2 g4 
    c,2 d4 
    e4 fis4 g4 
    c,4 d2 
    g,2.     %5
    e'2 g4 
    c4 b4 a4 
    g4 f4 g4 
    c,2. }
  c'2 a4   %10
  e2 f4 
  g4 f4 g4 
  c,2. 
  c4 c'8 ais8 a8 g8 
  f2 e4   %15
  a8 b8 c4 c,4 
  g'2. 
  c2 e,4 
  f2 g4 
  a4 b4 g4   %20
  c2 c,4 
  f2. 
  c2 c'4 
  c4 b4 c4 
  f,4 g4 c,4   %25
  g2. 
  c2. 
  
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