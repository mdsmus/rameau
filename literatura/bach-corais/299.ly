
\version "2.10.33"

\header {
  title = "299 - Meinen Jesum laß ich nicht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  bes''4 bes c c 
  d d8 ees16 f ees2 
  f4 f ees ees 
  d c8 d16 ees c2 
  bes bes4 bes 
  c c bes aes8 g 
  g2 bes4 bes 
  aes aes g f8 g16 aes 
  f2 ees 
  bes'4 bes c c 
  d d8 ees16 f ees2 
  bes4 bes8 c16 cis c8 bes aes g 
  f g16 aes f4 ees2 
}


alto = \relative c {
  g''4 g ees aes 
  aes8 g aes4 g2 
  bes4 bes8 aes g4. a8 
  bes a g ees f4. ees8 
  d2 ees4 ees 
  ees aes aes8 g f4 
  e2 e8 f g e 
  c4 f8 d ees4 ees 
  ees d bes2 
  g'4 g aes aes8 g 
  f4 g g2 
  ees4 ees ees8 d ees4 
  ees d bes2 
}


tenor = \relative c {
  ees'4 ees c f 
  f8 ees f d bes2 
  d8 ees f d d c16 b c4 
  bes bes bes8 g a4 
  f2 g8 aes bes g 
  aes bes c4 f,8 g aes bes 
  c2 bes8 aes g4 
  aes bes bes c8 aes 
  bes g aes4 g2 
  ees'4 ees ees f 
  b,8 c d b c2 
  g4 g aes8 f ees bes' 
  c4 bes8 aes g2 
}


baixo = \relative c {
  ees8 f g ees aes g aes f 
  bes4 bes, ees2 
  bes8 c d bes c d ees f 
  g f ees c f4 f, 
  bes2 ees8 f g ees 
  aes g f ees d e f4 
  c2 g'8 f e c 
  f ees d bes ees g aes f 
  bes4 bes, ees2 
  ees'8 cis c bes aes g f ees 
  d c b g c2 
  ees8 cis c bes aes bes c bes 
  aes4 bes ees2 
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