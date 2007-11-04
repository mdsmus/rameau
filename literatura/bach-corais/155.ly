\version "2.10.33"

\header {
  title = "155 - Hilf, Herr Jesu, laß gelingen 1"
  composer = "J. S. Bach"
}


global = {
  \time 3/4
  \key d \minor
}


soprano = \relative c'' {
  g2 g4 
  d'2 d4 
  c2 bes4 
  a2 a4 
  d2 f4   %5
  dis2 d4 
  c2 c4 
  bes2. 
  a2 bes4 
  c2 c4   %10
  bes2 c4 
  a2 a4 
  d2 d4 
  c2 bes4 
  a2 a4   %15
  g2. 
  bes2 bes4 
  bes2 bes4 
  dis2 d4 
  c2 c4   %20
  c2 d4 
  bes2 c4 
  a2 a4 
  g2 g4~ 
  g4 
}

alto = \relative c' {
  d2 d4 
  d8 e8 fis4 g4 
  a2 a8 g8 
  g4 fis8 e8 fis4 
  f2 c'4   %5
  bes4 c4. bes8 
  bes2 a4 
  f2. 
  fis2 g4~ 
  g4 fis8 g8 a4~   %10
  a4 g8 fis8 g4~ 
  g4 fis8 e8 fis4 
  fis8 g8 a4 g4~ 
  g4 fis4 g4 
  g2 fis4   %15
  d2. 
  g2 g4 
  g2 bes4 
  bes4 a4 bes4~ 
  bes4 a8 g8 a4   %20
  a2 a4 
  g2 g4 
  g2 fis4 
  d2 d4~ 
  d4 
}

tenor = \relative c' {
  bes2 bes4 
  a4 d8 c8 bes4 
  dis4 d4 d4 
  d2 d4 
  f2 f4   %5
  g4 f4 f4 
  g4 f4. dis8 
  d2. 
  d2 d4 
  dis2 e8 d8   %10
  d2 dis4 
  d2 d4 
  a4 d8 c8 bes4 
  c4 d4 d4 
  dis8 d8 c8 dis8 d8 c8   %15
  bes2. 
  d2 d4 
  dis2 f4 
  dis4 c4 f4 
  f2 f4   %20
  f2 fis4 
  d2 c8 d8 
  dis8 d8 c8 dis8 d8 c8 
  b2 b4 
  bes4 
}

baixo = \relative c' {
  g8 a8 bes4 g4 
  fis8 e8 d4 g4~ 
  g4 fis4 g4 
  d2 d4 
  bes4 bes'4 a4   %5
  g4 a4 bes4 
  dis,4 f4 f,4 
  bes2. 
  d4 c4 bes4 
  a4 g4 fis4   %10
  g4 g'4 c,4 
  d2 d4 
  d8 e8 fis4 g4 
  a4 d,4 g4 
  c,4 a4 d4   %15
  g,2. 
  g4 g'4 f4 
  dis,4 dis'4 d4 
  c,4 c'4 bes4 
  f2 f'4   %20
  f4 dis4 d4 
  g4 f4 dis8 d8 
  c4 a4 d4 
  g,2 g4~ 
  g4 
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