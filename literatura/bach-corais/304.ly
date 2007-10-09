
\version "2.10.33"

\header {
  title = "304 - Auf meinen lieben Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g a bes c 
  d2. d4 
  d c bes c 
  a2. a4 
  bes c d d 
  c2 d4 d 
  bes c d d 
  c2 bes4 d 
  f d d d 
  c2 c4 c 
  d c bes c 
  a2 g4 
}


alto = \relative c {
  \partial 4 d'4 
  ees e8 fis g4 g 
  fis2. fis4 
  g g8 fis g4 a 
  fis2. fis4 
  g a bes bes 
  bes a8 g a4 fis 
  d c f g 
  g f8 ees d4 f 
  f f8 g a4 g 
  g8 f g e f4 f8 ees 
  d4 e8 fis g4 g 
  g fis d 
}


tenor = \relative c {
  \partial 4 bes'4 
  c c d ees 
  a2. a4 
  bes c d ees 
  d2. d4 
  d ees f f 
  g f8 ees d4 a 
  bes f'8 ees d c bes4 
  bes a f bes 
  c d d8 c bes4 
  bes8 a bes g a4 a 
  bes a g8 bes ees4 
  d8 c16 bes c4 b 
}


baixo = \relative c {
  \partial 4 g'4 
  c8 bes a4 g8 f ees4 
  d2. c4 
  bes a g c 
  d2. d4 
  g f8 ees d c bes4 
  ees f fis d 
  g a bes8 a g f 
  ees4 f bes, bes' 
  a bes fis g8 f 
  e4 c f f 
  bes, c8 d ees4 d8 c 
  d2 g,4 
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