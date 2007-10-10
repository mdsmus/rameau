
\version "2.10.33"

\header {
  title = "253 - Ach Gott, vom Himmel sieh' darein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 a''4 
  bes a g d' 
  d8 c bes4 a2 
  s4 c bes a 
  g a8 bes16 c bes4 a 
  g2. a4 
  bes a g d' 
  d8 c bes4 a2 
  s4 c bes a 
  g a8 bes16 c bes4 a 
  g2. g4 
  a f e d8 e 
  f4 g a2 
  s4 a g bes 
  a bes g fis 
  g2. g4 
  d' bes c d 
  c bes a2 
}


alto = \relative c {
  \partial 4 e'4 
  fis8 g4 fis8 g a bes4 
  a4. g8 fis2 
  s4 fis g f 
  dis8 f g4 g fis 
  d2. fis4 
  g fis g8 a bes4 
  a4. g8 fis2 
  s4 fis g f 
  dis8 f g4 g fis 
  d2. d4 
  e d cis d 
  c d8 e f2 
  s4 f f8 dis d g4 fis8 g4 g8 c, d4 
  d2. d4 
  d g f f8 g 
  a4 g d2 
}


tenor = \relative c {
  \partial 4 cis'4 
  d d d d 
  d d d2 
  s4 d d d8 c 
  bes4 dis d4. c8 
  bes2. d4 
  d d d d 
  d d d2 
  s4 d d d8 c 
  bes4 dis d4. c8 
  bes2. bes4 
  a a a8 g f g 
  a4 bes c2 
  s4 c c bes8. c16 
  d4 d8 c bes a16 g a4 
  bes2. bes4 
  a d c bes 
  dis e fis2 
}


baixo = \relative c {
  \partial 4 a'4 
  d, d'8 c bes4 a8 g 
  fis4 g d2 
  s4 a bes8 c d4 
  dis d8 c d2 
  g,2. d'4 
  g d'8 c bes4 a8 g 
  fis4 g d2 
  s4 a bes8 c d4 
  dis d8 c d2 
  g,2. g'4 
  cis, d a bes 
  a g f2 
  s4 f c' g 
  d' bes dis d 
  g,2. g'4 
  fis g a bes 
  c cis d2 
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