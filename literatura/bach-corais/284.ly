\version "2.10.33"

\header {
  title = "284 - Wenn einer schon ein Haus aufbaut"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key f \major
}


soprano = \relative c'' {
  \partial 4 f4 
    f4 f4 e4 c4 
  d4 e4 f4 f4 
  e4 d4 c4 bes4 
  a4 g4 a4 a4 
  g4 a8 b8 c4 d4   %5
  c4 b4 c4 c4 
  d4 e4 f4 e4 
  d4 d4 c4 c4 
  bes4 a4 d4 c4 
  bes4 a4 g4 g4   %10
  a4 b4 c4 d4 
  c4 b4 c2 
  
}

alto = \relative c'' {
  \partial 4 a4 
    a4 a4 g4 a8 g8 
  f4 g4 a4 a4 
  g8 f8 f8 g8 g8 a8 d,8 e8 
  f4 e8 d8 cis4 d4 
  d8 c8 c4 c8 f8 f4   %5
  f8 e8 d4 e4 f4 
  f4 bes4 a8 g8 g4 
  fis4 gis4 a4 a4 
  a8 g8 g8 f8 f8 dis8 dis8 d8 
  d8 e8 f4 e4 e4   %10
  dis8 d8 d4 dis4 f4 
  f8 dis8 d4 e2 
  
}

tenor = \relative c' {
  \partial 4 c4 
    c4 c8 d8 e4 f8 e8 
  d8 c8 bes4 c4 d8 c8 
  bes8 c8 d4 e8 d8 d8 cis8 
  d8 a8 bes4 e4 f4 
  g4 f4 e8 a8 a8 g8   %5
  g4 g4 g4 a4 
  bes4 bes4 c8 d8 e4 
  a,8 b16 c16 d8 e8 e4 e4 
  f8 c8 c4 bes4 fis4 
  g4 c4 c4 c4   %10
  c4 g4 g4 gis8 g8 
  g4 g4 g2 
  
}

baixo = \relative c {
  \partial 4 f8  g8 
    a4 g8 f8 c'8 bes8 a4 
  bes8 a8 g4 f4 d4 
  g8 a8 bes4 e8 fis8 g4 
  d8 c8 bes4 a4 d4 
  e4 f8 g8 a4 bes4   %5
  c4 g4 c,4 f4 
  bes4 a8 g8 a8 b8 c4 
  c8 b16 a16 b8 e,8 a4 a,4 
  d8 e8 f4 bes,8 c8 d4 
  g,4 a8 bes8 c4 c'4   %10
  fis,4 f4 dis4 b4 
  c4 g4 c2 
  
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