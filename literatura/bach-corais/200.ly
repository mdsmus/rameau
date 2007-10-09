
\version "2.10.33"

\header {
  title = "200 - Christus ist erstanden, hat überwunden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  c''4 g a b 
  c2 c4 g 
  c ais a2 
  g g4 a 
  ais c ais a 
  g2 g4 c 
  c b c2 
  c4 c d d 
  c ais a2 
  g4 a ais a 
  g2 ais4 c 
  d dis8 d c2 
  d d4 c 
  d c ais g 
  a b c2 
}


alto = \relative c {
  g''4 g4. fis8 g4 
  g4. f4 e8 e4. fis8 g4 g fis 
  d2 d8 dis4 d ais'8 a g fis g4 fis8 
  d2 e8 f g4 
  g g g2 
  a4 a8 g f g a2 ais8 g f2 
  e4 e8 fis g4. fis8 
  g2 d8 ais'4 a8 
  ais2 ais4 a 
  ais2 ais4. a8 
  ais4 a g e 
  f8 e d f e2 
}


tenor = \relative c {
  e'4 d c d 
  c8 ais a4 g c8 ais 
  c4 d dis d8 c 
  ais2 ais4 c 
  ais8 g dis'4 d16*7 c16 
  ais2 c4. d8 
  e d16 c d8 f4 e16 d e4 
  f f f8 e d e 
  f4. e8 c2 
  c4 c d dis8 d16 c 
  ais2 ais8 d f4 
  f dis8 f g dis c f 
  f2 f4 f 
  f dis8 d d4 c 
  c g g2 
}


baixo = \relative c {
  c'4 b a g8 f 
  e4 f c c'8 ais 
  a4 g c, d 
  g,2 g'4 fis 
  g c, d d, 
  g2 c8 d e f 
  g4 g, c2 
  f8 g f e d e f g 
  a f g c, f2 
  c'8 ais a4 g8 ais, c d 
  dis2 g4 f 
  ais8 a g f dis c f4 
  ais,2 ais'4 f 
  ais8 a g fis g a ais c 
  f,4 g c,2 
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