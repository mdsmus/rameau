
\version "2.10.33"

\header {
  title = "272 - Ich dank dir, lieber Herre"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 
  bes bes bes c 
  gis g f c' 
  d c bes a8 g 
  a4 g f bes 
  bes bes bes c 
  gis g f c' 
  d c bes a8 g 
  a4 g f f' 
  ees d c bes 
  bes8 c d4 c d 
  ees d c b 
  c2. f,4 
  bes c d ees 
  f ees8 d c4 ees 
  d c f bes,8 c 
  d4 c bes2 
}


alto = \relative c {
  \partial 4 f'4 
  g gis g g 
  g8 f4 e8 f4 f 
  f e f c4. f4 e8 c4 f 
  g f g g 
  g8 f4 e8 f4 f 
  f e f c4. f4 e8 c4 bes'8 a 
  g4 f8 g a4 bes8 gis 
  g4 f f f 
  ees gis8 g4 f8 g4 
  g2. c,4 
  f g8 a bes4 a8 g 
  f4 g a bes 
  gis g f f8 g 
  f ees4 d8 d2 
}


tenor = \relative c {
  \partial 4 d'4 
  d8 ees f4 ees8 d c4 
  c bes a c 
  bes8 a g4 f c' 
  c bes a bes 
  bes8 c d4 ees8 d c4 
  c bes a c 
  bes8 a g4 f c' 
  c bes a d8 c 
  bes c d ees f4 f 
  bes,2 a4 b 
  c4. b8 c4 d 
  ees2. a4 
  bes ees, f8 f' ees4. d8 c bes f'4 bes, 
  bes4. c8 a4 bes 
  bes a f2 
}


baixo = \relative c {
  \partial 4 bes'8 a 
  g4 d ees e 
  f c f, a 
  bes c d e 
  f c f, d' 
  ees bes ees e 
  f c f, a 
  bes c d e 
  f c f, d' 
  g bes ees, d 
  ees bes f' d 
  c f8 g gis4 g 
  c,2. ees4 
  d c bes c 
  d ees f g 
  f ees2 d8 ees 
  f4 f, bes2 
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