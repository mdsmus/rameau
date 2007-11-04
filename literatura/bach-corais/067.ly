\version "2.10.33"

\header {
  title = "67 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key bes \major
}


soprano = \relative c'' {
  \repeat volta 2 {
    bes4 c4 d4 c4 
    bes4 a4 g4 f4 
    bes4 c4 d4 ees4 
    d4 c4 bes2 }
  d4 ees4 f4 ees4   %5
  d4 c4 d2 
  f4 f4 g4 f4 
  ees4 d4 c2 
  d8 ees8 f4 ees4 d8 c8 
  bes4 c4 d2   %10
  bes2 d8 ees8 f4 
  ees4 d4 c4 d4 
  c2 bes2 
  
}

alto = \relative c' {
  \repeat volta 2 {
    f4 f4 f4 f4 
    f8 e8 f4 e4 c4 
    g'4 f4 f4 ees4 
    f4 f8 ees8 d2 }
  bes'4 a8 g8 f8 g16 gis16 g4   %5
  g4 g4 fis2 
  f4 bes4 bes4 a4 
  g4 f8 g8 a2 
  bes4 bes4 bes8 a8 bes8 a8 
  g8 f8 ees4 d8 e8 fis4   %10
  g2 g4 gis4 
  g8 a8 bes4 a8 g8 f4 
  f4. ees8 d2 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    d4 c4 bes4 a4 
    bes4 c4 c8 bes8 a4 
    d4 c4 bes8 a8 bes4 
    bes4 a4 f2 }
  f'4 ees4 a8 b8 c4   %5
  bes4 ees4 a2 
  bes8 c8 d4 ees8 d8 c4 
  bes8 c8 d8 e8 f2 
  f8 ees8 d4 c4 f,4 
  g4 a4 bes4 a4   %10
  g2 bes4 b4 
  c4 g4 a4 bes4 
  bes4 a4 f2 
  
}

baixo = \relative c' {
  \repeat volta 2 {
    bes4 a4 bes4 f4 
    g4 a8 bes8 c8 c,8 f4 
    g4 a4 bes4 g4 
    f8 ees8 f4 bes,2 }
  bes4 c4 d4 ees8 f8   %5
  g8 f8 ees4 d2 
  d4 bes4 ees4 f4 
  g8 a8 bes4 f2 
  bes4 bes,4 c4 d4 
  ees8 d8 c4 bes8 c8 d4   %10
  g,2 g'4 d4 
  ees4 e4 f8 ees8 d8 bes8 
  f'2 bes,2 
  
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