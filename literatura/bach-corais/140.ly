
\version "2.10.33"

\header {
  title = "140 - In allen meinen Taten"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 g''4 
  c c d d 
  e2 d4 d 
  c b a a 
  b2 b4 g 
  g g c c 
  b2 s4 b 
  e e c c 
  d2 b4 b 
  c c a a 
  b2 g4 g 
  c d e d 
  c1 
}


alto = \relative c {
  \partial 4 e'4 
  e8 f g4 a g 
  g2 g4 g4. fis8 g4 g fis 
  g2 g4 d 
  e e a a 
  gis2 s4 g 
  g g f f 
  fis8 g a fis g4 g 
  g g fis fis 
  fis b, b b 
  c f e8 f g f 
  e1 
}


tenor = \relative c {
  \partial 4 c'4 
  c c c b 
  c2 b4 b 
  c d e d 
  d2 d4 b 
  c c8 d e4 e 
  e2 s4 e4. d8 c b a b c a 
  a4 d d d 
  e e e d 
  dis8 e fis dis e4 d 
  g, b c b 
  g1 
}


baixo = \relative c {
  \partial 4 c4 
  c8 d e4 f g 
  c,8 d e f g4 g, 
  a b c d 
  g2 g,4 g'8 f 
  e d c b a b c d 
  e2 s4 e8 d 
  c d e c f g a f 
  d e fis d g4 g, 
  c8 d e c d e fis d 
  b cis dis b e4 g8 f 
  e f e d c4 g' 
  c,1 
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