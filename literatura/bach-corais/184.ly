\version "2.10.33"

\header {
  title = "184 - Christ lag in Todesbanden"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key e \minor
}


soprano = \relative c'' {
  \repeat volta 2 {
    \partial 4 b4 
    ais4 b8 cis8 d4 e4 
    d4 cis4 b4 b4 
    g4 a4 b4 a8 g8 
    fis8 e8 fis4 e4 } r4 
  e8 fis8 g4 a4 e8 fis8   %5
  g4 a4 b4 b4 
  e4 dis4 e4 fis8 e8 
  d4 cis4 b4 cis4 
  d4 b8 cis8 d4 a4 
  g4 fis4 e2   %10
  b'4 a4 g2 
  fis2 e2 
  
}

alto = \relative c'' {
  \repeat volta 2 {
    \partial 4 g4 
    fis4 fis4 fis4 fis4 
    fis4 fis8 e8 dis4 fis4 
    e4 d4 d8 dis8 e4 
    e4 dis4 b4 } r4 
  b4 e4 e4. dis8   %5
  e4 d4 d4 g8 a8 
  b4 a4 b4 fis4 
  fis4 fis8 e8 d4 e4 
  fis4 d4 g4 fis4 
  fis8 e8 e8 dis8 e2   %10
  d8 e8 fis4. dis8 e4~ 
  e4 dis4 b2 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    \partial 4 e8  d8 
    cis4 d8 ais8 b4 cis4 
    b4 ais4 fis4 b4 
    b8 c8 b8 a8 g8 a8 b4 
    c4 fis,8 a8 g4 } r4 
  g8 a8 b4 a8 b8 c4   %5
  b4 a4 g4 d'4 
  g4 fis4 e8 d8 cis4 
  b4 ais4 fis4 g4 
  a4 g4 g4 d'8 c8 
  b4 a4 g2   %10
  g4 fis8 b8 b4 c4~ 
  c4 b8 a8 gis2 
  
}

baixo = \relative c {
  \repeat volta 2 {
    \partial 4 e4 
    fis8 e8 d8 cis8 b4 ais4 
    b4 fis4 b4 dis4 
    e4 fis4 g8 fis8 e4 
    a,8 b16 c16 b4 e,4 } r4 
  e'4. d8 c8 b8 a4   %5
  e'4 fis4 g4 g8 fis8 
  e4 fis4 gis4 ais4 
  b4 fis4 b,4 e4 
  d4 g4 b,8 c8 d4 
  e4 b4 c2   %10
  g'4 dis4 e4 c4 
  a4 b4 e,2 
  
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