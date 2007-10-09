
\version "2.10.33"

\header {
  title = "22 - Schmücke dich, o liebe Seele"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  g''4 f ees f 
  g8 aes bes4 aes2 
  g bes4 g 
  aes g8 f ees f g4 
  f2 ees 
  g4 f ees f 
  g8 aes bes4 aes2 
  g bes4 g 
  aes g8 f ees f g4 
  f2 ees 
  bes'4 c8 d ees4 ees 
  d8 c bes c c2 
  bes bes4 c8 d 
  ees4 ees d8 c bes c 
  c2 bes 
  f4 g aes aes 
  g8 bes aes g f4 f 
  bes g aes g8 f 
  ees f g4 f2 
  ees1 
}


alto = \relative c {
  ees'4 d c bes 
  bes ees2 d4 
  ees2 f4 ees 
  ees ees8 d c d ees2 d4 bes2 
  ees4 d c bes 
  bes ees2 d4 
  ees2 f4 ees 
  ees ees8 d c d ees2 d4 bes2 
  g'4 f ees8 f g4 
  g d g f8 ees 
  d2 ees4 ees8 f 
  g4 g f f8 g 
  f ees16 d ees4 d2 
  d4 ees d8 ees f4 
  ees8 g f ees d4 d 
  d ees4. d8 ees d 
  c d ees2 d4 
  bes1 
}


tenor = \relative c {
  bes'4 bes8 aes g4 f 
  ees8 f g4 f8 ees f4 
  ees2 bes'4 bes 
  c bes c bes 
  bes8 aes16 g aes4 g2 
  bes4 bes8 aes g4 f 
  ees8 f g4 f8 ees f4 
  ees2 bes'4 bes 
  c bes c bes 
  bes8 aes16 g aes4 g2 
  ees'4 a8 b c4 c 
  bes8 a bes2 a4 
  bes2 g4 aes 
  bes8 a bes c d ees f bes, 
  bes4 a bes2 
  bes4 bes aes8 g f4 
  bes c d8 c bes4 
  bes bes aes bes 
  c bes bes8 aes16 g aes4 
  g1 
}


baixo = \relative c {
  ees4 bes c d 
  ees g,8 aes bes2 
  ees, d'4 ees 
  c8 d ees4 aes, g8 aes 
  bes2 ees, 
  ees'4 bes c d 
  ees g,8 aes bes2 
  ees, d'4 ees 
  c8 d ees4 aes, g8 aes 
  bes2 ees, 
  ees'4 d c8 d ees f 
  g4. f8 ees4 f 
  bes,2 ees4 aes, 
  g8 f g a bes c d ees 
  f4 f, bes2 
  bes'4 aes8 g f4 ees8 d 
  ees4 aes, bes bes 
  g c f, g 
  aes g8 aes bes2 
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