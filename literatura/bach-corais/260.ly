
\version "2.10.33"

\header {
  title = "260 - Nun freut euch, lieben Christen, g'mein 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 
  bes8 c d4 c bes 
  c c d bes8 c 
  d4 ees f8 ees d4 
  c2 bes4 bes 
  bes8 c d4 c bes 
  c c d bes8 c 
  d4 ees f8 ees d4 
  c2 bes4 d 
  d c bes a 
  bes8 c d4 c c 
  bes a bes f 
  bes c d bes8 c 
  d4 ees f8 ees d4 
  c2 bes 
}


alto = \relative c {
  \partial 4 f'8 ees 
  f4 bes a g 
  g f f f 
  bes bes c bes 
  bes a f f8 ees 
  f4 bes a g 
  g f f f 
  bes bes c bes 
  bes a f f 
  f f8 ees d g g fis 
  g a bes4 a a 
  a8 g g fis g4 d 
  d g fis d 
  g g f f 
  g f8 ees d2 
}


tenor = \relative c {
  \partial 4 d'8 c 
  bes4 f' f8 ees d4 
  c8 bes bes a bes4 d8 ees 
  f4 g f f 
  g f8 ees d4 d8 c 
  bes4 f' f8 ees d4 
  c8 bes bes a bes4 d8 ees 
  f4 g f f 
  g f8 ees d4 bes 
  bes a bes c 
  d8 ees f4 f d 
  d d d d8 c 
  bes a g4 a g8 a 
  bes4 bes bes bes 
  bes a f2 
}


baixo = \relative c {
  \partial 4 bes8 c 
  d4 c8 bes f'4 g8 f 
  ees4 f bes, bes 
  bes' a8 g a4 bes 
  ees, f bes, bes8 c 
  d4 c8 bes f'4 g8 f 
  ees4 f bes, bes 
  bes' a8 g a4 bes 
  ees, f bes, bes8 c 
  d ees f4 g a 
  g d8 ees f4 fis 
  g d g8 a bes a 
  g f ees4 d g, 
  g' f8 ees d c bes4 
  ees f bes,2 
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