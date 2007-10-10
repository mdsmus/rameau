
\version "2.10.33"

\header {
  title = "281 - Auf meinen lieben Gott"
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
  bes2. bes4 
  bes c d d 
  c2 d4 d 
  bes c d d 
  c2 bes4 d 
  f d d d 
  c2 c4 c 
  d c bes c8 bes 
  a2 g1 
}


alto = \relative c {
  \partial 4 d'4 
  d d d g 
  fis2. fis4 
  g g8 fis g4 a 
  f2. f4 
  g a bes bes 
  bes a bes a 
  g a8 g f4 f 
  g f f bes 
  c bes a g 
  g f8 e f4 g 
  fis fis g g 
  g fis d1 
}


tenor = \relative c {
  \partial 4 bes'4 
  bes a g8 bes ees4 
  a2. a4 
  bes c d ees 
  d2. d4 
  d f f g 
  g f f d 
  d f bes, bes 
  bes a d f 
  f f8 g a a, bes4 
  bes a8 g a4 g 
  a d d c8 d 
  ees4 d8 c b1 
}


baixo = \relative c {
  \partial 4 g4 
  g' fis g ees 
  d2. c4 
  bes a g c 
  d2. d4 
  g f bes8 a g f 
  ees4 f bes, fis 
  g8 g' f ees d c bes d 
  ees c f4 bes, bes' 
  a bes fis g 
  e c f ees 
  d8 c bes a g f' ees d 
  c4 d g,1 
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