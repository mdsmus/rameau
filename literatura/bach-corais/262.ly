
\version "2.10.33"

\header {
  title = "262 - Ach Gott, vom Himmel sieh' darein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 a''4 
  bes a g d' 
  d8 c bes4 a c 
  bes a g c 
  bes a g a 
  bes a g d' 
  d8 c bes4 a c 
  bes a g c 
  bes a g g 
  a f e d8 e 
  f4 g a f 
  g8 a bes4 a bes 
  g fis g g 
  d' bes c d 
  c bes a2 
  a2. 
}


alto = \relative c {
  \partial 4 fis'4 
  g fis g bes 
  a g fis gis 
  g fis cis d 
  d2 d4 fis 
  g fis g bes 
  a g fis gis 
  g fis cis d 
  d2 d4 d 
  e d cis d 
  d d e d8 c 
  bes c d4 c d 
  d8 dis d4 d d 
  d d dis f 
  dis d cis8 d4 cis8 
  d2. 
}


tenor = \relative c {
  \partial 4 d'4 
  d c d g 
  d d d dis 
  e d8 c bes4 a 
  g fis16 a c8 bes4 d 
  d c d g 
  d d d dis 
  e d8 c bes4 a 
  g fis16 a c8 bes4 bes 
  a a a a 
  a d cis a 
  g f8 g a g fis4 
  g8 c a4 bes bes 
  a g g g 
  g8*5 f8 e4 
  fis2. 
}


baixo = \relative c {
  \partial 4 d4 
  g a bes a8 g 
  fis4 g d c 
  cis d e fis 
  g d g, d' 
  g a bes a8 g 
  fis4 g d c 
  cis d e fis 
  g d g, g' 
  cis, d a'8 g f e 
  d c bes4 a d 
  dis d8 e f dis d c 
  bes c d4 g, g' 
  fis g8 f dis d c b 
  c4 g a2 
  d2. 
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