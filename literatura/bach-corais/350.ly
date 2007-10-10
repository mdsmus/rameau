
\version "2.10.33"

\header {
  title = "350 - Werde munter, mein Gemüte"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  d''4 ees f f 
  ees d c c 
  d ees f d 
  c4. c8 bes2 
  d4 ees f f 
  ees d c c 
  d ees f d 
  c4. c8 bes2 
  c4 d ees ees 
  d4. c8 c2 
  ees4 f g g 
  f f8. ees16 ees2 
  d4 ees f bes, 
  ees d c c 
  d ees f d 
  c c bes bes4*5 
}


alto = \relative c {
  bes''4 bes a bes8 a 
  g a bes4 a a 
  bes a8 g f4 g 
  g f f2 
  bes4 bes a bes8 a 
  g a bes4 a a 
  bes a8 g f4 g 
  g f f2 
  a4 b c g 
  g f8 ees ees2 
  g4 bes bes bes 
  bes bes8 gis g2 
  g4 g f ees 
  f f f f 
  f g f f 
  g f f f4*5 
}


tenor = \relative c {
  d'4 bes8 c d4 d 
  ees f f f 
  f ees d8 c bes4 
  bes a d2 
  d4 bes8 c d4 d 
  ees f f f 
  f ees d8 c bes4 
  bes a d2 
  f4 f, g c 
  c8 a b4 g2 
  c4 d ees ees 
  ees8 c d4 bes2 
  bes4 bes bes8 gis g4 
  c bes a a 
  bes bes c bes 
  bes a d d4*5 
}


baixo = \relative c {
  bes'4 g d g 
  c, bes f' f 
  bes, c d g8 f 
  ees4 f bes,2 
  bes'4 g d g 
  c, bes f' f 
  bes, c d g8 f 
  ees4 f bes,2 
  f'4 d c8 d ees f 
  g4 g, c2 
  c'4 bes8 gis g f ees4 
  bes' bes, ees2 
  g4 f8 ees d4 ees 
  a bes f' f 
  bes a8 g a f bes4 
  ees, f bes, bes4*5 
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