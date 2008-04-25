\version "2.10.33"

\header {
  title = "149 - Nicht so traurig, nicht so sehr"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key ees \major
}


soprano = \relative c'' {
  \repeat volta 2 {
    \partial 4 ees4 
    d8 c8 g'4 f8 ees8 d4 
    ees8 f8 b,2 c8 d8 
    ees4 aes,4 g4 f4 
    bes4 g2 } g'4 
  bes,4 a4 bes4 ees4   %5
  d8 c8 d2 d4 
  ees8 f8 b,4 g'4 ees4 
  d8. c16 c2
}

alto = \relative c'' {
  \repeat volta 2 {
    \partial 4 g4 
    f4 ees8 f8 g4 aes4 
    g8 f8 g2 g4 
    g4 f4 bes,4 bes4 
    f'4 ees2 } ees4 
  ees4 f4 f4 g4   %5
  f4 f2 f4 
  f4 g4 g4 g4 
  f8. ees16 ees2
}

tenor = \relative c' {
  \repeat volta 2 {
    \partial 4 c4 
    b4 c4 c4 c4 
    b8 c8 d2 c4 
    c4 c8 d8 ees4 ees4 
    d4 bes2 } bes4 
  bes4 c4 bes4 bes4   %5
  a4 bes2 bes4 
  c4 d4 c4 c4~ 
  c8 b8 g2
}

baixo = \relative c {
  \repeat volta 2 {
    \partial 4 c4 
    d4 ees4 c4 f4 
    g8 aes8 g2 ees8 d8 
    c4 f4 g8 aes8 bes4 
    bes,4 ees2 } ees4 
  g4 f8 ees8 d4 c4   %5
  f4 bes,2 bes'4 
  aes4 g8 f8 ees8 f8 g4 
  g,4 c2
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