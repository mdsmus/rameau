
\version "2.10.33"

\header {
  title = "67 - Wie nach einer Wasserquelle"
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
  d8 ees f4 ees d8 c 
  bes4 c d2 
  bes d8 ees f4 
  ees d c d 
  c2 bes 
}


alto = \relative c {
  f'4 f f f 
  f8 e f4 e c 
  g' f f ees 
  f f8 ees d2 
  f4 f f f 
  f8 e f4 e c 
  g' f f ees 
  f f8 ees d2 
  bes'4 a8 g f g16 gis g4 
  g g fis2 
  f4 bes bes a 
  g f8 g a2 
  bes4 bes bes8 a bes a 
  g f ees4 d8 e fis4 
  g2 g4 gis 
  g8 a bes4 a8 g f4 
  f4. ees8 d2 
}


tenor = \relative c {
  d'4 c bes a 
  bes c c8 bes a4 
  d c bes8 a bes4 
  bes a f2 
  d'4 c bes a 
  bes c c8 bes a4 
  d c bes8 a bes4 
  bes a f2 
  f'4 ees a8 b c4 
  bes ees a2 
  bes8 c d4 ees8 d c4 
  bes8 c d e f2 
  f8 ees d4 c f, 
  g a bes a 
  g2 bes4 b 
  c g a bes 
  bes a f2 
}


baixo = \relative c {
  bes'4 a bes f 
  g a8 bes c c, f4 
  g a bes g 
  f8 ees f4 bes,2 
  bes'4 a bes f 
  g a8 bes c c, f4 
  g a bes g 
  f8 ees f4 bes,2 
  bes4 c d ees8 f 
  g f ees4 d2 
  d4 bes ees f 
  g8 a bes4 f2 
  bes4 bes, c d 
  ees8 d c4 bes8 c d4 
  g,2 g'4 d 
  ees e f8 ees d bes 
  f'2 bes, 
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