
\version "2.10.33"

\header {
  title = "284 - Wenn einer schon ein Haus aufbaut"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f''4 
  f f e c 
  d e f f 
  e d c bes 
  a g a a 
  g a8 b c4 d 
  c b c c 
  d e f e 
  d d c c 
  bes a d c 
  bes a g g 
  a b c d 
  c b c2 
}


alto = \relative c {
  \partial 4 a''4 
  a a g a8 g 
  f4 g a a 
  g8 f f g g a d, e 
  f4 e8 d cis4 d 
  d8 c c4 c8 f f4 
  f8 e d4 e f 
  f bes a8 g g4 
  fis gis a a 
  a8 g g f f dis dis d 
  d e f4 e e 
  dis8 d d4 dis f 
  f8 dis d4 e2 
}


tenor = \relative c {
  \partial 4 c'4 
  c c8 d e4 f8 e 
  d c bes4 c d8 c 
  bes c d4 e8 d d cis 
  d a bes4 e f 
  g f e8 a a g 
  g4 g g a 
  bes bes c8 d e4 
  a,8 b16 c d8 e e4 e 
  f8 c c4 bes fis 
  g c c c 
  c g g gis8 g 
  g4 g g2 
}


baixo = \relative c {
  \partial 4 f8 g 
  a4 g8 f c' bes a4 
  bes8 a g4 f d 
  g8 a bes4 e8 fis g4 
  d8 c bes4 a d 
  e f8 g a4 bes 
  c g c, f 
  bes a8 g a b c4 
  c8 b16 a b8 e, a4 a, 
  d8 e f4 bes,8 c d4 
  g, a8 bes c4 c' 
  fis, f dis b 
  c g c2 
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