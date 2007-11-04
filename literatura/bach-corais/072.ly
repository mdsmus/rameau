\version "2.10.33"

\header {
  title = "72 - Erhalt uns, Herr, bei deinem Wort"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key g \minor
}


soprano = \relative c'' {
  \partial 4 g8  a8 
    bes4 a8 g8 fis4 g8 a8 
  bes4 a4 g4 bes4 
  c4 c4 d4 bes4 
  c4 c4 d4 d4 
  ees4 d8 ees8 f8 ees8 d4   %5
  c8 bes8 c4 bes4 d4 
  bes4 c4 bes4 a4 
  g4 fis4 g4 
}

alto = \relative c' {
  \partial 4 d4 
    g8 f8 ees4 d4 d8 fis8 
  g4 fis4 d4 g4 
  f8 g8 a4 bes4 d,4 
  g8 bes8 a8 g8 fis4 g4 
  g8 a8 bes4 c4 bes4   %5
  a8 bes4 a8 f4 a4 
  g4 g8 fis8 g4 fis4 
  g8 ees8 d4 d4 
}

tenor = \relative c' {
  \partial 4 bes8  c8 
    d4 c8 bes8 a4 bes8 c8 
  d8 ees8 a8 d8 bes4 d4 
  c4 f4 f4 g4 
  g4 c,8 d16 ees16 a4 bes4 
  c4 f,4 f4 f'4   %5
  ees8 d8 ees8 c8 d4 d4 
  d4 c4 d4 d8 c8 
  bes4 a8 b16 c16 b4 
}

baixo = \relative c {
  \partial 4 g4 
    g'4 c,4 d8 c'8 bes8 a8 
  g8 c,8 d4 g,4 g'4 
  a4 f4 bes8 a8 g8 f8 
  ees8 d8 ees4 d4 g4 
  c,4 bes4 a4 bes4   %5
  f'4 f4 bes,4 fis'4 
  g8 g,8 a4 bes8 c8 d4 
  ees8 c8 d4 g,4 
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