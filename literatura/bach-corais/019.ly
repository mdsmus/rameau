
\version "2.10.33"

\header {
  title = "19 - Ich hab mein Sach Gott heimgestellt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g g fis bes 
  a g fis fis 
  fis fis g e 
  fis fis g a 
  a c a f 
  g a bes bes 
  a g fis fis 
  fis fis g e 
  fis fis g2 
}


alto = \relative c {
  \partial 4 d'4 
  d d8 cis d4 g8 f 
  dis d e4 d d 
  c d d c 
  c8 dis d4 d f 
  f g f f 
  dis8 d c dis d4 g4. fis8 g g, d'4 d 
  c8 d dis d d4 e 
  d d d2 
}


tenor = \relative c {
  \partial 4 bes'4 
  bes8 a g4 a d 
  c bes8 a a4 a 
  a a g g 
  a8 c c bes16 a bes4 c 
  c c c bes 
  bes a8 c bes4 d 
  d4. c8 a4 a 
  a a g16*5 a16 bes8 
  a g a16 bes c8 c b4. 
}


baixo = \relative c {
  \partial 4 g'4 
  g8 f dis4 d8 c bes g 
  c4 cis d d8 dis4 d c8 c b c bes 
  a4 d g, f' 
  f8 g f e f dis4 d8 
  dis e f fis g4 g, 
  d' dis d d 
  a8 bes c4 bes8 b c cis 
  d4 d, g2 
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