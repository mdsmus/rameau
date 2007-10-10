
\version "2.10.33"

\header {
  title = "218 - Herr, dein Ohren zu mir neige"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  g''4 g 
  fis g a bes 
  a2 g 
  bes4 a g bes 
  a g fis2 
  f4 ees d g 
  g fis g2 
  bes4 c d d 
  c bes c2 
  bes bes4 c 
  d d c bes 
  c2 bes 
  bes4 a g bes 
  a g fis2 
  f4 ees d g 
  g fis g1 
}


alto = \relative c {
  d'4 d 
  d d ees8 d d g 
  g4 fis d2 
  g4 g8 fis g4 g8 f 
  ees d e4 d2 
  a8 bes c4 bes8 c d4 
  ees d d2 
  g4 a bes bes8 gis 
  g f f4 g f8 ees 
  d2 f4 f 
  f f f8 ees d4 
  g f8 ees d2 
  d4 d8 c bes4 ees8 d 
  c d d4 d2 
  d4 d8 c16 bes a4 d 
  ees d d1 
}


tenor = \relative c {
  bes'4 bes 
  a bes c bes8 d 
  ees4 d8 c bes2 
  d4 d8. c16 bes8 c d4 
  c bes8 a a2 
  f4 f f bes 
  a16*5 bes16 c8 bes2 
  d4 f f f 
  ees8 c d bes4 a16 g a4 
  bes2 d4 c 
  c8 bes16 a bes4 a bes 
  bes a f2 
  g4 fis g g 
  a bes a2 
  g4 g fis g8 bes 
  a4. c8 b1 
}


baixo = \relative c {
  g8 a bes c 
  d c bes g fis4 g 
  c d bes2 
  g'4 d ees bes 
  c cis d2 
  d8 c bes a bes a g bes 
  c a d4 g,2 
  g'4 f8 ees d c bes4. a8 bes d ees c f4 
  bes,2 bes4. a8 
  bes f' bes4 f g8 f 
  ees4 f bes,2 
  g4 d' ees4. e8 
  f fis g g, d'2 
  b4 c4. bes16 a bes8 g 
  c a d4 g,1 
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