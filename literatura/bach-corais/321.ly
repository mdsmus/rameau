
\version "2.10.33"

\header {
  title = "321 - Wir Christenleut"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''8 a 
  bes4 a g g 
  bes a g d' 
  c bes a a 
  bes bes c c 
  d d c bes 
  a2 g4 d' 
  c bes a d 
  c bes a a 
  bes bes c c 
  d d c bes 
  a2 g 
}


alto = \relative c {
  \partial 4 d'8 fis 
  g4 fis g ees 
  e fis d d8 ees 
  f ees d e fis4 fis 
  g g g a 
  bes bes a g 
  g fis g f 
  f d d f 
  g f8 e f4 e 
  fis g g a 
  a8 c bes a g fis g4 
  g fis d2 
}


tenor = \relative c {
  \partial 4 bes'8 c 
  d4 d8 c bes4 c 
  g d' bes f8 g 
  a4 bes8 c d4 d 
  d ees ees8 d c4 
  f g ees d 
  ees d8 c bes4 bes 
  a g fis bes 
  bes8 g c4 c cis 
  d8 c bes a g g' f ees 
  d4 d g,8 a bes g 
  e'4 d8 c b2 
}


baixo = \relative c {
  \partial 4 bes'8 a 
  g4 d ees c 
  cis d g, bes 
  f' g d d 
  g8 f ees d c4 f8 ees 
  d c bes a g fis g4 
  c d g, bes 
  f' g d bes' 
  e c f a 
  d, ees e f 
  fis g ees d 
  cis d g,2 
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