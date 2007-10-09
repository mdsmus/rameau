
\version "2.10.33"

\header {
  title = "69 - Komm, heiliger Geist, Herre Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 f''4 
  g f8 ees d ees f4 
  c2 d4 e 
  f2 s4 f 
  g f c8 d ees4 
  d c bes bes 
  c8 d ees4 d8 ees f2 c4 bes8 a g4 
  f2 s4 f 
  bes c d8 ees f2 ees4 d c 
  d2 s4 d8 ees 
  f4 g f c 
  d e f f 
  g f c8 d ees4 
  d c bes bes 
  c8 d ees4 d8 ees f2 c4 bes8 a g4 
  f2 s4 f 
  bes c d8 ees f2 ees4 d c 
  g a bes c 
  d bes g2 
  f4 c'8 d16 ees d2 
  c bes 
}


alto = \relative c {
  \partial 4 bes''4 
  bes a bes f8 g 
  a2 bes4 bes 
  a2 s4 bes 
  bes a8 g f4 g8 a 
  bes4 a f f 
  f g f8 g a4. bes8 a g f d e4 
  c2 s4 c 
  f8 g a4 bes4. c8 
  d4. c8 bes a g4 
  fis2 s4 bes 
  a8 b c4 c8 bes a g 
  f4 g a bes8 a 
  g a bes4 a g 
  f8 g a4 f g 
  g g8 a bes2. a4 bes8 f4 e8 
  c2 s4 f8 ees 
  d g f ees d4. ees16 f 
  g4 g g g8 f 
  ees2 d4 f 
  f8*5 d8 ees4 
  d f2 g f8 ees d2 
}


tenor = \relative c {
  \partial 4 d'4 
  ees8 d c4 bes bes 
  f'2 f4 bes, 
  c2 s4 bes 
  ees8 d c bes a bes ees,4 
  f f'8 ees d4 d 
  c bes8 c d4 c8 bes 
  c4 f f c8 bes 
  a2 s4 a 
  bes ees f8 ees d c 
  b a g4 fis g 
  a2 s4 bes8 c 
  d4 e f4. ees8 
  d c bes4 c d 
  ees f f bes,8 c 
  d bes f' ees d4 ees 
  ees8 d c4 d8 c bes c 
  d e f2 c8 bes 
  a2 s4 a 
  bes8 ees d c bes4. c8 
  d4. c8 bes a g4 
  c2 bes4 a 
  bes2. bes8 a 
  bes4 c2 bes a16 g a8 f2 
}


baixo = \relative c {
  \partial 4 bes'4 
  ees, f g d8 ees 
  f2 bes8 a g4 
  f2 s4 d 
  ees f ees8 d c4 
  d8 ees f4 bes, bes' 
  a g8 a bes4 a8 g 
  a g f e d bes c4 
  f2 s4 f8 ees 
  d ees d c bes4 bes'8 gis 
  g4 c, d ees 
  d2 s4 g 
  d' c8 bes a g f4 
  bes8 a g4 f bes 
  ees, d8 ees f4 g8 a 
  bes ees, f4 bes, ees8 d 
  c4 c' g d8 ees 
  f g a f d' bes c4 
  f,2 s4 d 
  g a bes8 c d c 
  b g c4 g8 f ees d 
  ees c f4 bes, f' 
  bes,8 c d4 ees2 
  bes'4 a bes8 a g f 
  ees c f4 bes,2 
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