
\version "2.10.33"

\header {
  title = "301 - Wo Gott, der Herr, nicht bei uns hält"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 bes''4 
  bes g8 a bes c d4 
  c c bes bes 
  a g8 a bes4 c8 bes 
  a2 g4 bes 
  bes g8 a bes c d4 
  c c bes bes 
  a g8 a bes4 c8 bes 
  a2 g4 c 
  d d a8 bes c4 
  bes bes a bes 
  c g8 a bes4 a 
  g g f bes 
  a g8 a bes4 c8 bes 
  a2 g 
}


alto = \relative c {
  \partial 4 g''4 
  f ees d d 
  ees ees16 d ees8 d4 d 
  d8 c' bes a g4 g8 f 
  ees4 d8 c bes4 g' 
  f ees d d 
  ees ees16 d ees8 d4 d 
  d8 c' bes a g4 g8 f 
  ees4 d8 c bes4 f' 
  f f c4. a'8 
  a g16 fis g4 f g 
  g8 f ees4 d8 e f4 
  f e c d 
  c8 d e fis g4 g 
  g fis d2 
}


tenor = \relative c {
  \partial 4 d'4 
  d8 c bes4 bes f 
  g a f g 
  fis8 ees' d c bes a g4 
  g fis g d' 
  d8 c bes4 bes f 
  g a f g 
  fis8 ees' d c bes a g4 
  g fis g f 
  bes bes f' fis8 a, 
  bes c d4 d d 
  g, c bes c 
  c8 g c bes a4 f8 g 
  a bes c4 d c8 d 
  ees a d c b2 
}


baixo = \relative c {
  \partial 4 g'4 
  d ees8 f g a bes4 
  ees, f bes, g 
  d' e8 fis g f ees d 
  c4 d g, g' 
  d ees8 f g a bes4 
  ees, f bes, g 
  d' e8 fis g f ees d 
  c4 d g, a 
  bes8 c d ees f g a fis 
  g a bes c d4 g,8 f 
  ees d c4 g a8 bes 
  c bes c4 f, d'8 e 
  f4 c g'8 f ees d 
  c4 d g,2 
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