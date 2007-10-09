
\version "2.10.33"

\header {
  title = "204 - Wer nur den lieben Gott läßt walten"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 d'4 
  g a bes a 
  g a fis2 
  d4 f f ees 
  d g g fis 
  g2. d4 
  g a bes a 
  g a fis2 
  d4 f f ees 
  d g g fis 
  g2. a4 
  bes c d d 
  c c bes d 
  c bes a g8 a 
  bes4 a g2 
}


alto = \relative c {
  \partial 4 bes'4 
  d d d d 
  bes ees d2 
  a4 d d c 
  bes bes8 c d4 d 
  d2. bes4 
  d d d d 
  bes ees d2 
  a4 d d c 
  bes bes8 c d4 d 
  d2. fis4 
  g f f g 
  g f f f 
  fis g g8 fis g4 
  g fis d2 
}


tenor = \relative c {
  \partial 4 g'4 
  bes a g fis 
  g c a2 
  fis4 a bes f 
  f g8 a bes4 a 
  bes2. g4 
  bes a g fis 
  g c a2 
  fis4 a bes f 
  f g8 a bes4 a 
  bes2. d4 
  d c bes bes 
  bes a d bes 
  c d ees8 d16 c bes8 c 
  d4 d8 c b2 
}


baixo = \relative c {
  \partial 4 g4 
  g' fis g d 
  ees c d2 
  d,4 d' g, a 
  bes ees d d 
  g,2. g4 
  g' fis g d 
  ees c d2 
  d,4 d' g, a 
  bes ees d d 
  g,2. d'4 
  g a bes g 
  ees f bes, bes' 
  a g c,8 d ees4 
  d8 c d4 g,2 
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