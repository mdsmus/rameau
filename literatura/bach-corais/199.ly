
\version "2.10.33"

\header {
  title = "199 - Hilf, Gott laß mirs gelingen"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 g''4 a2 g4 f2 
  d4 f2. 
  g2 a4 bes2 d4 c2 
  bes4 a2. 
  g2 g4 a2 g4 f2 
  d4 f2. 
  g2 a4 bes2 d4 c2 
  bes4 a2. 
  g2 c4 c2 c4 d2 
  c4 bes a g 
  f2 f4 bes2 a4 bes2 
  c4 d2 c4 
  bes4. a8 g4 fis2 a4 bes2 
  d4 c2 bes4 
  a2. g 
}


alto = \relative c {
  \partial 4 d'8 e f8*5 e8 d4 a 
  bes c8 dis d c b4 
  e2 e8 fis g fis 
  g8*7 fis8 
  g4 g2 fis4 
  d2 d8 e f8*5 e8 d4 a 
  bes c8 dis d c b4 
  e2 e8 fis g fis 
  g8*7 fis8 
  g4 g2 fis4 
  d2 g4. f4 e8 f4. e8 f g 
  a g f8*5 e8 
  c2 d4 g2 a4. d,8 g4 
  a bes8 a g4. fis8 
  g4 d4. c8 d2 fis4 g2 
  f4 e8 d e fis g4 
  g2 fis4 d2. 
}


tenor = \relative c {
  \partial 4 bes'4 c16*11 bes16 a4 f4. g8 a2 g8 f 
  c'2 c4 d4. c8 bes a g fis g4 
  d' dis d8 a d c 
  bes2 bes4 c16*11 bes16 a4 f4. g8 a2 g8 f 
  c'2 c4 d4. c8 bes a g fis g4 
  d' dis d8 a d c 
  bes2 c8 bes a4 
  bes c2 bes4 
  c d2 g,8 c 
  a2 bes8 c d bes 
  dis4. d8 d2 
  dis4 f dis8 d dis c 
  d dis f f, g4 a2 d4. bes8 dis4 
  d8 bes g4 c8 a bes d 
  dis d c bes c a b2. 
}


baixo = \relative c {
  \partial 4 g'4 f2 c4 d2 
  bes4 a2 d4 
  c2 a4 g2 bes4 dis2 
  d4 c d d, 
  g2 g'4 f2 c4 d2 
  bes4 a2 d4 
  c2 a4 g2 bes4 dis2 
  d4 c d d, 
  g2 e'4 f 
  g a bes2 
  f8 e d c bes4 c 
  f,2 bes8 a g4 
  g' fis g f8 dis 
  d c bes4 bes' a 
  g f dis d2 d4 g4. dis8 
  bes'2 a4 g 
  c, a d g,2. 
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