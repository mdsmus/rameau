
\version "2.10.33"

\header {
  title = "227 - Lobet den Herren, denn er ist sehr freundlich"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 g''4 
  d g g2 
  a s4 a 
  bes8 c d4 cis2 
  d bes4 bes 
  c c d2 
  bes s4 d 
  c c c a 
  d c bes a 
  g2 a 
  bes4 a g fis 
  g2 a 
  s4 d bes bes 
  bes d c bes 
  a g a2 
  g s4 g 
  d g g2 
  a s4 a 
  bes8 c d4 cis2 
  d1 
}


alto = \relative c {
  \partial 4 d'8 c 
  bes c d4. c16 bes a8 g 
  d'2 s4 fis 
  g a a2 
  a g8 a bes4 
  bes a bes4. gis8 
  g2 s4 bes 
  a8 g f e f g a g 
  a fis g a4 g fis8 
  g8. fis16 g8 g, d'2 
  d8 e f fis g dis d4. c8 d bes d2 
  s4 fis d g 
  f4. g16 f e8 fis g4. fis8 g4 g fis 
  d2 s4 d 
  d d4. c16 bes a8 g 
  d'2 s4 fis 
  g a8 e e fis g4 
  fis1 
}


tenor = \relative c {
  \partial 4 bes'8 a 
  g a bes4. a16 g c4 
  fis,2 s4 d' 
  d8 e f4 e8 d e16 fis g8 
  fis2 d4 f 
  g f f f 
  f2 s4 f 
  f8 bes, a g a bes c4. bes4 a8 bes16 c d8 d8. c16 
  bes8 d4 c8 fis,2 
  g4 c d8 c16 bes a4 
  g8 d g2 fis4 
  s4 a g8 a bes c 
  d dis d bes g a bes16 c d8 
  dis d16 c bes8 c16 d dis4 d8. c16 
  bes2 s4 bes8 a 
  g a bes a g4. c8 
  fis,2 s4 d' 
  d a8 bes a2 
  a1 
}


baixo = \relative c {
  \partial 4 g8 a 
  bes a g4 dis'2 
  d s4 d 
  g f8 g a2 
  d, g8 f dis d 
  dis c f f, bes c d bes 
  dis2 s4 bes 
  f'8 g a bes a g f e 
  fis d e fis g4 d 
  dis2 d 
  g,4 a bes8 c d c 
  bes a bes g d'2 
  s4 d g8 f dis4 
  d8 c bes4. a8 g bes 
  c d dis d c a d4 
  g,2 s4 g8 a 
  bes a g f dis2 
  d s4 d' 
  g f8 g a4 a, 
  d1 
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