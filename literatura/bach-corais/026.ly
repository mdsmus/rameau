
\version "2.10.33"

\header {
  title = "26 - O Ewigkeit, du Donnerwort"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'8 g 
  a4 bes c c 
  d e f f,8 g 
  a4 bes c c 
  bes a g a 
  f f bes a 
  g2 f4 f8 g 
  a4 bes c c 
  d e f f,8 g 
  a4 bes c c 
  bes a g a 
  f f bes a 
  g2 f4 c' 
  g a bes bes 
  a a g c 
  d e f a, 
  g g f 
}


alto = \relative c {
  \partial 4 c'4 
  f e f a 
  bes8 a g4 a c, 
  f g g f 
  f8 e f4 e e 
  e d d8 e f4 
  f e c c 
  f e f a 
  bes8 a g4 a c, 
  f g g f 
  f8 e f4 e e 
  e d d8 e f4 
  f e c f 
  g g fis g 
  g fis d f 
  f c'8 bes a g f4 
  f e c 
}


tenor = \relative c {
  \partial 4 a'8 bes 
  c4 bes a8 c f4 
  f c c a 
  d d c8 bes a4 
  bes c c a 
  a a g a 
  d c8 bes a4 a8 bes 
  c4 bes a8 c f4 
  f c c a 
  d d c8 bes a4 
  bes c c a 
  a a g a 
  d c8 bes a4 a 
  bes c d e 
  a,8 bes c4 bes c 
  bes8 a g4 f8 g a bes 
  c g c bes a4 
}


baixo = \relative c {
  \partial 4 f4 
  f g a f 
  bes c f, f8 e 
  d4 c8 bes a4 d 
  g, a8 bes c4 cis 
  d8 e f d g4 d8 c 
  bes4 c f, f' 
  f g a f 
  bes c f, f8 e 
  d4 c8 bes a4 d 
  g, a8 bes c4 cis 
  d8 e f d g4 d8 c 
  bes4 c f, f' 
  e dis d cis 
  d d g, a 
  bes c d8 e f4 
  c c f, 
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