
\version "2.10.33"

\header {
  title = "165 - O Lamm Gottes, unschuldig"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 
  f f c' c 
  d2 c4 c 
  f, g a bes 
  a g8 f f4 f 
  f f c' c 
  d2 c4 c 
  f, g a bes 
  a g8 f f4 a 
  a a g a 
  f8 e d4 c c' 
  d c c a8 bes 
  c4 bes a d 
  c8 bes a4 g a 
  c a g2 
  f1 
}


alto = \relative c {
  \partial 4 c'4 
  c16 d dis8 dis d e c f e 
  a4 g8 f e4 e4. d4 c8 c d16 e f4. e16 d e4 c c 
  c16 d dis8 dis d e c f e 
  a4 g8 f e4 e4. d4 c8 c d16 e f4. e16 d e4 c f 
  f f f e 
  d8 c4 b8 g4 dis' 
  d8 e f g16 a g4 f 
  a4. g4 fis8 g4 
  g f g4. f16 e 
  f4 f2 e4 
  c1 
}


tenor = \relative c {
  \partial 4 a'8 bes 
  c4. bes16 a g4 c2 b4 g a 
  a g f4. d'8 
  c4 c8. bes16 a4 a8 bes 
  c4. bes16 a g4 c2 b4 g a 
  a g f4. d'8 
  c4 c8. bes16 a4 c 
  c d d a 
  a8 g a g16 f e4 f 
  f8 g a bes c4. d8 
  dis4 d d d8 f 
  e4. d4 c8 c4 
  c8 a f a d4 c8 bes 
  a1 
}


baixo = \relative c {
  \partial 4 f,8 g 
  a4 bes2 a8 g 
  f4 g c a 
  d e f8 e d bes 
  c4 c, f f8 g 
  a4 bes2 a8 g 
  f4 g c a 
  d e f8 e d bes 
  c4 c, f f'4. e8 d c b4 cis 
  d8 e f g c,4 a 
  bes f'4. e8 f4 
  f8 fis g g, d'4 bes8 b 
  c4 d e f 
  a,8 bes16 c d8 c bes4 c 
  f,1 
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