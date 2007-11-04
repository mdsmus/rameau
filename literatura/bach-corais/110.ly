\version "2.10.33"

\header {
  title = "110 - Vater unser im Himmelreich"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key g \minor
}


soprano = \relative c'' {
  \partial 4 g4 
    g4 ees4 f4 g8 f8 
  ees4 d4 c4 g'4 
  g4 f4 bes4 g8 f8 
  ees4 f4 g4 g8 a8 
  bes4 c8 d8 ees4 d4   %5
  c4 b4 c4 c4 
  d4 c4 bes4 a4 
  g4 a4 g4 c4 
  bes4 a4 bes8 gis8 g4 
  g4 f4 ees4 g4   %10
  gis4 g8 f8 ees4 f4 
  ees4 d4 c2 
  
}

alto = \relative c' {
  \partial 4 ees4 
    d4 c4 c8 d8 ees8 d8 
  c4 b4 g4 ees'4 
  ees4 d8 ees8 f4 ees8 d8 
  c8 b8 c8 d8 b4 ees4 
  d4 ees8 f8 g4 f4   %5
  ees8 f8 g4 g4 f4 
  f4 fis4 g4 g8 fis8 
  g4 fis4 d4 f4 
  f4 ees4 d4 ees8 d8 
  c4 d4 bes4 c4   %10
  f4 ees8 d8 c4 d8 c8 
  b8 c8 c8 b8 g2 
  
}

tenor = \relative c' {
  \partial 4 c4 
    g4 g4 c4 c8 gis8 
  g4 g8 f8 ees4 c'4 
  bes4 bes4 bes4 bes4 
  c4 gis4 d4 c'4 
  bes4 gis4 g4 a8 b8   %5
  c4 d4 ees4 a,4 
  bes4 c4 d4 ees8 d8 
  d8 c8 c8 b8 b4 a4 
  bes4 c4 f,4 ees4 
  ees4 bes'8 gis8 g4 c4   %10
  c4 b4 c8 bes8 bes4 
  g4 g8 f8 e2 
  
}

baixo = \relative c {
  \partial 4 c4 
    b4 c4 gis'4 ees8 f8 
  g4 g,4 c4 c'4 
  g8 gis8 bes4 d,4 ees4 
  gis4 gis,4 g4 c4 
  g'4 f4 ees4 f8 g8   %5
  gis4 g4 c,4 f4 
  bes4 a4 g4 c,8 d8 
  ees4 d4 g,4 f'8 ees8 
  d4 c4 bes4 c8 bes8 
  gis4 bes4 ees4 e4   %10
  f4 g4 gis8 g8 f4 
  g4 g,4 c2 
  
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