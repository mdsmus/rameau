
\version "2.10.33"

\header {
  title = "274 - O Ewigkeit, du Donnerwort"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  f'4. g8 a4 bes 
  c c d e 
  f2 f,4. g8 
  a4 bes c c 
  bes a g2 
  a f4 f 
  bes a g2 
  f1 
  f4. g8 a4 bes 
  c c d e 
  f2 f,4. g8 
  a4 bes c c 
  bes a g2 
  a f4 f 
  bes a g2 
  f1 
  c'2 g4 a 
  bes bes a4. g8 
  g2 c 
  d4 e f a, 
  g4. g8 f2 
}


alto = \relative c {
  c'4 d8 e f4 f 
  f8 g a4 a8 g bes a 
  f2 d4. e8 
  f4 g fis8 g a4 
  a8 g g f c2 
  c d8 e f4 
  f8 e f4 f e 
  c1 
  c4 d8 e f4 f 
  f8 g a4 a8 g bes a 
  f2 d4. e8 
  f4 g fis8 g a4 
  a8 g g f c2 
  c d8 e f4 
  f8 e f4 f e 
  c1 
  f2 f8 e dis d 
  d4 g g fis 
  d2 f4. dis8 
  d f bes4 a8 g f4 
  f e c2 
}


tenor = \relative c {
  a'4 bes c d 
  c f f8 g g cis, 
  d2 a4 bes 
  f d' dis d 
  d c8 d e2 
  f4 dis d d8 c 
  bes c d4 d c8 bes 
  a1 
  a4 bes c d 
  c f f8 g g cis, 
  d2 a4 bes 
  f d' dis d 
  d c8 d e2 
  f4 dis d d8 c 
  bes c d4 d c8 bes 
  a1 
  a8 bes c2 c4 
  bes bes dis d8. c16 
  bes2 a8 c f2 g4 f8 e d4 
  d c8 bes a2 
}


baixo = \relative c {
  f,4 f'2 d4 
  a a' b cis8 a 
  d2 d, 
  d'4 c8 bes a g fis d 
  g4 a8 bes c2 
  f, bes8 c bes a 
  g4 d8 c bes4 c 
  f,1 
  f4 f'2 d4 
  a a' b cis8 a 
  d2 d, 
  d'4 c8 bes a g fis d 
  g4 a8 bes c2 
  f, bes8 c bes a 
  g4 d8 c bes4 c 
  f,1 
  a'4. bes8 c4 fis, 
  g8 f dis d c4 d 
  g,2 a 
  bes8 bes' a g d' d, d' c 
  bes g c c, f2 
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