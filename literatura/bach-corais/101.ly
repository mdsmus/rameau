
\version "2.10.33"

\header {
  title = "101 - Herr Christ, der einge Gottes-Söhn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 
  bes8 c d4 c bes 
  a2 g4 d' 
  ees c d c 
  bes2. bes4 
  bes8 c d4 c bes 
  a2 g4 d' 
  ees c d c 
  bes2. bes8 c 
  d4 d ees ees 
  f ees8 d c4 f 
  d d c bes 
  a2 g4 d' 
  ees c d c 
  bes1 
}


alto = \relative c {
  \partial 4 f'4 
  g8 a bes4 a g 
  g fis g g 
  g f f f 
  f2. f4 
  g8 a bes4 a g 
  g fis g g 
  g f f f 
  f2. f4 
  bes bes8 a g4 g 
  f2 f4 f 
  f f f8 ees d4 
  ees8 c d4 d g 
  g f f8 g a4 
  f1 
}


tenor = \relative c {
  \partial 4 d'4 
  ees f f8 ees d4 
  ees d8 c bes4 bes 
  bes a bes bes8 a 
  d2. d4 
  ees f f8 ees d4 
  ees d8 c bes4 bes 
  bes a bes bes8 a 
  d2. d8 ees 
  f4 g g8 f ees d 
  c4 bes a c 
  bes bes a a8 g 
  g4 fis bes b 
  c8 d ees a bes4 f'8 ees 
  d1 
}


baixo = \relative c {
  \partial 4 bes'4 
  ees, bes f' g 
  c, d ees g 
  c, f8 ees d ees f4 
  bes,2. bes'4 
  ees, bes f' g 
  c, d ees g 
  c, f8 ees d ees f4 
  bes,2. bes4 
  bes'8 a g f ees d c bes 
  a4 bes f a 
  bes8 c d ees f fis g bes, 
  c a d4 g, g' 
  c8 bes a f bes ees, f f, 
  bes1 
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