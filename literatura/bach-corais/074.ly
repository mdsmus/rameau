
\version "2.10.33"

\header {
  title = "74 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 a''4 
  d c bes a 
  g2 a4 e' 
  f f e8 d e4 
  d2. a4 
  d c bes a 
  g2 a4 e' 
  f f e8 d e4 
  d2. f4 
  e8 d c4 d e 
  f2 f4 c 
  d c bes8 a bes4 
  a2. f'4 
  e8 f g4 f e 
  d2 e4 a, 
  bes a g c 
  a1 
}


alto = \relative c {
  \partial 4 f'4 
  f8 g a4 d,8 e f4 
  f e f a 
  a a a a8 g 
  f2. f4 
  f8 g a4 d,8 e f4 
  f e f a 
  a a a a8 g 
  f2. a4 
  g g8 f f4 bes 
  bes a8 g a4 a 
  a8 g a4 g8 fis g4 
  fis2. g4 
  g c c c 
  c b c a 
  bes a g c 
  a1 
}


tenor = \relative c {
  \partial 4 d'4 
  d8 e f4 g c, 
  d c c e 
  e d d cis 
  a2. d4 
  d8 e f4 g c, 
  d c c e 
  e d d cis 
  a2. d8 c 
  bes4 c c bes8 c 
  d4 c8 bes c4 f8 dis 
  d4 d d d 
  d2. d4 
  c8 d e4 f g 
  a g g c, 
  bes c c8 bes16 a g8 c 
  c1 
}


baixo = \relative c {
  \partial 4 d'8 c 
  bes4 a g f 
  bes, c f cis 
  d8 e f g a4 a, 
  d2. d'8 c 
  bes4 a g f 
  bes, c f cis 
  d8 e f g a4 a, 
  d2. d4 
  g a bes8 a g4 
  f2 f4 f 
  bes fis g g, 
  d'2. b4 
  c c'8 b a4 g 
  f g c, f 
  g a8 bes c4 c, 
  f1 
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