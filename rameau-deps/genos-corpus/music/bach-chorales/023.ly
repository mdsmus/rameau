\version "2.10.33"

\header {
  title = "23 - Zeuch ein zu deinen Toren"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key a \minor
}


soprano = \relative c'' {
  \repeat volta 2 {
    \partial 4 a4 
    a4 b4 c4 d4 
    b4. c8 d4 e4 
    c4 a4 b4 b4 
    a2. } e'4 
  d4 c4 b4 a4   %5
  b2 r4 b4 
  c4 d4 e4 c4 
  d4. c8 b4 b4 
  c4 d4 e4 c4 
  d4. c8 b4 e4   %10
  c8 b8 a4 b4 b4 
  a2. 
}

alto = \relative c' {
  \repeat volta 2 {
    \partial 4 e4 
    e4 e4 e4 d4 
    d4 g8 fis8 g4 e4 
    e4 a4~ a4 gis4 
    e2. } a4~ 
  a8 gis8 a4~ a8 gis a8 a,8 %5
  e'2 r4 gis4
  a4 g4 g4 a4
  a4 g8 fis8 g4 g4
  g4 f4 e4 a4~
  a8 g8 fis8 e8 d4 e4 %10
  e4 a4 a4 gis4
  e2.
}

tenor = \relative c' {
  \repeat volta 2 {
    \partial 4 c4 
    c4 b4 a4 a4 
    g8 fis8 g8 a8 b4 b4 
    a8 b8 c4 f4 e8 d8 
    c2. } c4 
  d4 e4 f8 e8~ e8 d8   %5
  gis,2 r4 e'4 
  e4 d4 c8 d8 e4 
  a,4 d4 d4 d4 
  g,4 a8 b8 c8 d8 e4 
  d4 a4 b4 b4   %10
  a8 b8 c4 f4 e8 d8 
  cis2. 
}

baixo = \relative c {
  \repeat volta 2 {
    \partial 4 a4 
    a'4 gis4 a4 fis4 
    g2 g,4 gis'4 
    a8 g8 f8 e8 d4 e4 
    a2. } a,4 
  b4 c4 d8 e8 f4   %5
  e2 r4 e4 
  a4 b4 c8 b8 a8 g8 
  fis8 e8 d4 g4 f4 
  e4 d4 c4 b8 a8 
  b8 c8 d4 g,4 gis'4   %10
  a8 g8 f8 e8 d4 e4 
  a,2. 
}

\score {
  <<
    \new StaffGroup <<
      \override StaffGroup.SystemStartBracket #'style = #'line 
      \new Staff {
        <<
          \global
          \new Voice = "soprano" { \voiceOne \soprano }
          \new Voice = "alto" { \voiceTwo \alto }
        >>
      }
      \new Staff {
        <<
          \global
          \clef "bass"
          \new Voice = "tenor" {\voiceOne \tenor }
          \new Voice = "baixo" { \voiceTwo \baixo \bar "|."}
        >>
      }
    >>
  >>
  \layout {}
  \midi {}
}