\version "2.10.33"

\header {
  title = "185 - Ihr lieben Christen, freut euch nun"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key c \major
}


soprano = \relative c' {
  \partial 4 d4 
    d4 c4 f4 g4 
  a4. gis8 a4 b4 
  c4 b4 c4 a4 
  b8 d4 cis8 d4 d4 
  c4 a4 f4 d4   %5
  e4 d4 cis4 e4 
  g8 f8 e4 f4 d4 
  e4. e8 d2 
  
}

alto = \relative c' {
  \partial 4 a4 
    a8 b8 c4 d4 e4 
  e4 e4 e4 g4 
  g4 g4 g4. f16 e16 
  d4 e4 fis4 g8 f8 
  e4 c4 c4 ais4   %5
  b8 a8 b4 a4 cis4 
  d4 a4 a4 ais4 
  b8 d4 cis8 a2 
  
}

tenor = \relative c {
  \partial 4 f4 
    f4 g4 a8 f8 c'4~ 
  c8 b16 a16 b8 d8 c4 d4 
  e4 f8 d8 c4 c8 d16 c16 
  b8 a8 g8 a8 a4 d4 
  g,4. f8 f4 f4   %5
  g4 f8 e8 e4 a4 
  g4. g8 f4 f4 
  g8 ais8 a8. g16 fis2 
  
}

baixo = \relative c {
  \partial 4 d8  e8 
    f4. e8 d4 c8 b8 
  a4 e'4 a,4 g'8 f8 
  e8 c8 d8 f8 e8 c8 f8 d8 
  g8 f8 e8 a8 d,4 b4 
  c8 e8 f4 a,8 f8 ais8 a8   %5
  g4 gis4 a4 a4 
  b4 cis4 d8 c8 ais8 a8 
  g4 a4 d,2 
  
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