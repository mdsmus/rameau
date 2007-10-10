
\version "2.10.33"

\header {
  title = "311 - Jesus Christ, unser Herre"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 c''4 
  a c d c 
  bes2 a4 a 
  g a g g 
  f2. c'4 
  a c d c 
  bes2 a4 a 
  g a g g 
  f2. g4 
  g a bes c8 bes 
  a2 g4 g 
  a8 b c4 d8 c b4 
  c2. c4 
  a c d c 
  bes2 a4 a 
  g a g g 
  f1 
}


alto = \relative c {
  \partial 4 g''4 
  f8 g a4 bes8 a g a 
  bes a g4 f f 
  e f f e 
  c2. g'4 
  f8 g a4 bes8 a g a 
  bes a g4 f f 
  e f f e 
  c2. c8 d 
  e4 c d c 
  c4. d8 e4 e 
  f g a g 
  g2. e4 
  c f f dis 
  d4. e8 fis4 d 
  e f f e 
  c1 
}


tenor = \relative c {
  \partial 4 c'4 
  c dis f e 
  f c c c 
  c c c8 bes16 a bes4 
  a2. c4 
  c dis f e 
  f c c c 
  c c c8 bes16 a bes4 
  a2. g4 
  c f, bes8 a g4 
  a8 g f4 c' c 
  c8 d e4 d4. e16 f 
  e2. g,4 
  a a bes a 
  bes8 c d4 d f 
  c c c8 bes16 a bes4 
  a1 
}


baixo = \relative c {
  \partial 4 e4 
  f8 dis d c bes4 c 
  d e f f 
  bes8 a g f c'4 c, 
  f2. e4 
  f8 dis d c bes4 c 
  d e f f 
  bes8 a g f c'4 c, 
  f2. e8 d 
  c c' bes a g f e4 
  f a,8 bes c4 c 
  f8 e d c f4 g 
  c,2. c4 
  f8 dis4 d16 c bes8 a' g fis 
  g a bes c d4 d8 c 
  bes a g f c'4 c, 
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