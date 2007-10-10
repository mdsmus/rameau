
\version "2.10.33"

\header {
  title = "95 - Werde munter, mein Gemüte"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  d''4 ees f f 
  ees d c c 
  d ees f ees8 d 
  c4. bes8 bes2 
  d4 ees f f 
  ees d c c 
  d ees f ees8 d 
  c4. bes8 bes2 
  c4 d ees ees 
  d d c2 
  ees4 f g g 
  f f ees2 
  d4 ees f f 
  ees d c c 
  d ees f ees8 d 
  c4. bes8 bes4 bes2. 
}


alto = \relative c {
  f'4 g8 a bes4 bes 
  bes8 a bes4 a a 
  bes a8 g f4 g 
  g f f2 
  f4 g8 a bes4 bes 
  bes8 a bes4 a a 
  bes a8 g f4 g 
  g f f2 
  f4 f ees8 f g4 
  gis g8 f ees2 
  g4 bes bes8 gis bes g 
  c4 bes8 gis g2 
  g4 g f8 ees d4 
  ees f8 g a4 a 
  bes a8 g f4 g 
  g f f f2. 
}


tenor = \relative c {
  bes'4 bes bes8 c d4 
  ees f f f 
  f c c8 a bes4 
  bes a d2 
  bes4 bes bes8 c d4 
  ees f f f 
  f c c8 a bes4 
  bes a d2 
  a4 b c c 
  c b g2 
  c4 d ees ees 
  ees d bes2 
  bes4 bes bes bes 
  bes8 a bes4 f' f 
  f ees d8 c bes4 
  bes a8 ees d4 d2. 
}


baixo = \relative c {
  bes'8 a g4 d g 
  c, d8 ees f4 f 
  bes, c d g8 f 
  ees4 f bes,2 
  bes'8 a g4 d g 
  c, d8 ees f4 f 
  bes, c d g8 f 
  ees4 f bes,2 
  f'8 ees d4 c8 d ees c 
  f4 g c,2 
  c'4 bes8 gis g f ees4 
  gis bes ees,2 
  g4 f8 ees d4 g 
  c, d8 ees f4 f 
  bes, c d g8 f 
  ees4 f bes, bes2. 
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