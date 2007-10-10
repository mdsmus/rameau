
\version "2.10.33"

\header {
  title = "174 - Jesus Christus, unser Heiland, der den Tod überwandt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  g''4 f f g 
  a g f e 
  d2 s4 f 
  g a g fis 
  g2 s4 c 
  g8 a bes4 a g 
  a2 s4 g 
  f g a g 
  f e d f 
  g a g fis 
  g1 
}


alto = \relative c {
  d'4 d d4. c8 
  c f4 e8 d4. cis8 
  a2 s4 d 
  d dis8 d d4 d 
  d2 s4 g8 f 
  dis4 d8 g4 fis8 g g, 
  d'2 s4 d8 cis 
  d f4 e8 f4 e4. d4 cis8 a4 d 
  d dis d d 
  d1 
}


tenor = \relative c {
  bes'4 bes a8 bes g4 
  f8 a bes4 b e,8 a16 g 
  f2 s4 a 
  bes8 g c4. bes8 a4 
  bes2 s4 c 
  c d d4. c8 
  fis,2 s4 bes 
  a c c bes 
  a16*7 g16 f4 a 
  bes c4. bes8 a c 
  b1 
}


baixo = \relative c {
  g8 a bes c d4 e 
  f g gis a8 a, 
  d2 s4 d8 c 
  bes4 fis g d' 
  g,2 s4 dis'8 d 
  c4 g d' dis 
  d2 s4 g, 
  d' c f8 e d cis 
  d4 a d, d'8 c 
  bes a g fis g4 d 
  g1 
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