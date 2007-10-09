
\version "2.10.33"

\header {
  title = "256 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  bes''4 c d c 
  bes a g f 
  bes c d ees 
  d c bes2 
  bes4 c d c 
  bes a g f 
  bes c d ees 
  d c bes2 
  d4 ees f ees 
  d c d2 
  f4 f g f 
  ees d c2 
  d8 ees f4 ees d 
  bes c d2 
  bes d4 f 
  ees d c d 
  c2 bes 
}


alto = \relative c {
  f'4 f f4. e8 
  d4 c8 f f e f4 
  d f f f 
  f f f2 
  f4 f f4. e8 
  d4 c8 f f e f4 
  d f f f 
  f f f2 
  bes4 bes a g8 a 
  bes4 a bes2 
  bes4 bes bes a 
  g f f2 
  f4 bes8 gis g4 f 
  g8 fis g4. fis16 e fis4 
  d2 g4 gis 
  g d8 ees f4 f 
  f2 f 
}


tenor = \relative c {
  d'4 a bes8 a g4 
  f8 g a8. bes16 c8 g a4 
  bes a bes c 
  c8 bes bes a d2 
  d4 a bes8 a g4 
  f8 g a8. bes16 c8 g a4 
  bes a bes c 
  c8 bes bes a d2 
  f4 g c,8 d ees4 
  f f f2 
  d4 d ees c 
  bes bes a2 
  bes8 c d4. c4 bes a8 g a bes a16 g a4 
  g2 bes4 bes 
  bes bes a bes4. a16 g a4 d2 
}


baixo = \relative c {
  bes'4 f bes, c 
  d8 e f4 c f, 
  g' f8 ees d c bes a 
  bes4 f bes2 
  bes'4 f bes, c 
  d8 e f4 c f, 
  g' f8 ees d c bes a 
  bes4 f bes2 
  bes'8 a g4 f c 
  d8 ees f4 bes,2 
  bes8 c d bes ees d ees f 
  g a bes4 f2 
  bes4 bes, c d 
  ees ees d2 
  g g8 f ees d 
  ees f g f ees d c bes 
  f'4 f, bes2 
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