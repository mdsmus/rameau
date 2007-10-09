
\version "2.10.33"

\header {
  title = "107 - Herzlich lieb hab ich dich, o Herr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  \partial 4 ees''4 
  d c bes aes8 g 
  c4 c bes ees 
  d c bes aes8 g 
  c4 c bes bes 
  c d ees8 f g4 
  f ees2 d4 
  ees2. ees4 
  d c bes aes8 g 
  c4 c bes ees 
  d c bes aes8 g 
  c4 c bes bes 
  c d ees8 f g4 
  f ees2 d4 
  ees2. ees4 
  ees f ees8 d c d 
  ees4 ees d d 
  ees f ees8 d c d 
  ees g f4 d g 
  g g f ees 
  ees d ees d 
  ees d c bes 
  bes a bes g' 
  f ees d g 
  aes8 g f4 g ees 
  ees d ees ees 
  ees ees f ees 
  ees2. d4 
  ees1 
}


alto = \relative c {
  \partial 4 bes''4 
  bes g g f8 ees 
  ees4 aes g g 
  g8 f ees f g f ees d 
  ees f f4 g g 
  aes8 c bes aes g f ees4 
  f2 g4 aes 
  g2. g4 
  bes g g f8 ees 
  ees4 aes g g 
  g8 f ees f g f ees d 
  ees f f4 g g 
  aes8 c bes aes g f ees4 
  f2 g4 aes 
  g2. g4 
  aes aes g4. g8 
  f g a4 bes bes 
  bes aes g aes 
  bes c bes bes 
  bes c c aes 
  g f g aes 
  g f8 bes g4 g 
  g f f ees 
  f8 g16 aes g8 a b4 c 
  c b8 c g4 g 
  fis8 f f4 g g 
  aes aes aes g 
  f2 f 
  g1 
}


tenor = \relative c {
  \partial 4 g''4 
  f ees d cis 
  c8 bes c d ees4 g,8 aes 
  bes4 c8 d ees4 aes,8 bes 
  c ees d c d4 ees 
  ees8 aes g f ees bes cis4 
  c2 bes 
  bes2. g'4 
  f ees d cis 
  c8 bes c d ees4 g,8 aes 
  bes4 c8 d ees4 aes,8 bes 
  c ees d c d4 ees 
  ees8 aes g f ees bes cis4 
  c2 bes 
  bes2. bes4 
  c c c8 d ees d 
  c4 f f f 
  bes, bes bes f' 
  ees8 d c4 f ees 
  ees ees f f 
  bes, bes bes f' 
  bes,8 c d4 ees d 
  ees8 d c4 d bes8 c 
  d4 ees8 c g'4 c, 
  f8 ees d c d4 c 
  c bes bes cis 
  c8 d ees4 bes bes 
  c2 bes 
  bes1 
}


baixo = \relative c {
  \partial 4 ees4 
  bes' c g bes 
  aes aes, ees' c 
  g' aes ees8 d c bes 
  aes4 aes' g ees 
  aes bes c8 d, ees4 
  aes, a bes2 
  ees2. ees4 
  bes' c g bes 
  aes aes, ees' c 
  g' aes ees8 d c bes 
  aes4 aes' g ees 
  aes bes c8 d, ees4 
  aes, a bes2 
  ees2. ees4 
  aes8 g f4 c c'8 bes 
  a g f4 bes bes8 aes 
  g f ees d ees4 f 
  g a bes ees, 
  ees'8 d c bes aes bes c aes 
  bes4 bes, ees f 
  g8 a bes g ees f g ees 
  c4 f bes, ees 
  bes' c g e 
  f8 g aes4 b, c 
  a' bes ees, ees 
  aes8 bes c4 d, ees 
  a2 bes 
  ees,1 
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