
\version "2.10.33"

\header {
  title = "27 - Es spricht der Unweisen Mund"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 
  bes a8 g f4 bes 
  c d bes f 
  bes c d ees 
  c8 bes c4 bes bes 
  bes a8 g f4 bes 
  c d bes f 
  bes c d ees 
  c8 bes c4 bes bes 
  g a bes8 a g4 
  f e f f 
  bes c d ees 
  d c d c 
  d ees f8 ees d4 
  c8 bes c4 bes2 
}


alto = \relative c {
  \partial 4 f'4 
  f ees d d 
  ees f ees c 
  f f f g 
  f2 f4 f 
  f ees d d 
  ees f ees c 
  f f f g 
  f2 f4 f 
  e f2 e8 d 
  c4 c c c 
  f8 g a4 bes c4. bes4 a8 bes4 f 
  f g a f 
  f2 f 
}


tenor = \relative c {
  \partial 4 d'4 
  d c4. bes8 bes4. a8 bes gis g4 a 
  bes ees d8 c bes4. a16 g a4 d d 
  d c4. bes8 bes4. a8 bes gis g4 a 
  bes ees d8 c bes4. a16 g a4 d d 
  c c d g,8 a16 bes 
  c8 bes16 a g8 a16 bes a4 a 
  bes ees f g8 f 
  f4 f f f8 ees 
  d c bes4 c4. bes4 a16 g a4 d2 
}


baixo = \relative c {
  \partial 4 bes4 
  bes c d g 
  f bes, ees ees 
  d a bes ees 
  f2 bes,4 bes 
  bes c d g 
  f bes, ees ees 
  d a bes ees 
  f2 bes,4 bes2 a4 g c8 bes 
  a bes c4 f, f'8 ees 
  d ees d c bes bes'4 a8 
  bes4 f bes, a' 
  bes8 a g4 f bes 
  f2 bes, 
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