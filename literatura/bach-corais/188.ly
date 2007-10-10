
\version "2.10.33"

\header {
  title = "188 - Ach Herre Gott, mich treibt die Not"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key f \major
}

soprano = \relative c {
  f'4 f f bes2 g4 a2 
  b4 c2. 
  a4 bes c d2 bes4 c2. bes 
  c4 a8 bes c4 d2 c4 c4. bes8 
  a4 g2. 
  c4 c c bes2 a4 a g2 f2. 
}


alto = \relative c {
  c'4 c f2 
  e8 d e4 f2 
  f4 g2. 
  f4 f g8 a bes2 bes2. 
  a4 f2. 
  g4 f f f2 f4 g8 f e4 
  f2 e 
  f4 g8 bes a4 g 
  f8 e f4 f2 
  e4 c2. 
}


tenor = \relative c {
  a'4 a a g8 a 
  bes4 c c2 
  d4 e2. 
  c4 d dis f2 f4 g8 f dis d 
  c dis dis d16 c d2 
  c4 c c2 
  bes4 a g c 
  c c2. 
  c4 c f8 e d4 
  c c c d 
  c8 bes a2. 
}


baixo = \relative c {
  f4 f8 e d4 g 
  g, c f e 
  d c2. 
  f8 dis d4 c bes 
  c d dis c 
  f bes,2. 
  e'4 f a, bes8 c 
  d e f4 e c 
  f c2. 
  a'4 e f g 
  c, f a, bes 
  c f,2. 
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