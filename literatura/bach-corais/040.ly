\version "2.10.33"

\header {
  title = "40 - Ach Gott und Herr, wie groß und schwer"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key c \major
}


soprano = \relative c'' {
  \partial 4 c4 
    b4 a4 g4 g4 
  a4 b4 c4 d4 
  c4 b4 a4 b8 c8 
  a2 g4 c4 
  b4 c4 d4 d4   %5
  e4 d8 c8 d4 g,4 
  a4 b4 c8 d8 e8 f8 
  d2 c2 
  
}

alto = \relative c'' {
  \partial 4 g4 
    g4 fis4 d4 e8 d8 
  c4 d4 e4 g4~ 
  g8 fis8 g4 fis4 g4~ 
  g4 fis4 d4 g4 
  f4 g4 g4 g4   %5
  g4 fis4 g4 g4 
  d4 d4 c4. a'8 
  g4. f8 e2 
  
}

tenor = \relative c' {
  \partial 4 e4 
    d4. c8 b4 c8 ais8 
  a8 g8 f4 g4 b4 
  c4 d4 d4 d4 
  e4 d8 c8 b4 c4 
  d4 e4 b4 b4   %5
  c4 c4 b4 c4 
  c4 b4 e8 f8 g8 c,8 
  c4 b4 g2 
  
}

baixo = \relative c {
  \partial 4 c4 
    g'4 d4 g,4 c4 
  f8 e8 d4 c4 g4 
  a4 b8 c8 d4 g4 
  c,4 d4 g,4 e'4 
  d4 c4 g'4 g4   %5
  c8 b8 a4 g4 e4 
  fis4 gis4 a4 g8 f8 
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