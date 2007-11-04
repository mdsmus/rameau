\version "2.10.33"

\header {
  title = "157 - Wo Gott zum Haus nicht gibt sein Gunst"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key f \major
}


soprano = \relative c' {
  \partial 4 f4 
    c'4 c8 bes8 a4 g4 
  a4 b4 c4 c4 
  a4 c4 bes4 c4 
  a4 g4 f4 c'4 
  d4 d4 a4 c4   %5
  bes4 bes4 a4 f'4 
  e4 d4 c4. d8 
  bes8 a8 g4 f2 
  
}

alto = \relative c' {
  \partial 4 c4 
    f8 g8 a8 g4 f4 e8 
  f8 e8 d4 e4 g4~ 
  g8 f8 g8 a4 g16 f16 g4~ 
  g8 f4 e8 c4 f4 
  f4 f4 c4. a'8~   %5
  a8 g16 fis16 g4. fis8 a4 
  a8 g8 f8 g8 a8 g8 f4 
  f4. e8 c2 
  
}

tenor = \relative c' {
  \partial 4 a8  bes8 
    c8 d8 e4 c4 c4 
  c4 g4 g4 c4 
  c4. e8 f8 d8 c4 
  c4 c8 bes8 a4 a4 
  bes4 f8 g8 a4 f'8 dis8   %5
  d4 d4 d4 d4 
  c4 d8 e8 f4 a,4 
  bes4. c16 bes16 a2 
  
}

baixo = \relative c {
  \partial 4 f8  g8 
    a8 bes8 c4 f,4 c4 
  f4 g4 c,4 e4 
  f4 e8 c8 d8 g8 e8 c8 
  f4 c4 f,4 f'4 
  bes,8 c8 d8 e8 f8 g8 a8 fis8   %5
  g8 a8 bes8 c8 d4 d,4 
  a'4 bes4 f8 e8 d4 
  g4 c,4 f2 
  
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