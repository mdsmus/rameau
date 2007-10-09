
\version "2.10.33"

\header {
  title = "61 - Jesu Kreuz, Leiden und Pein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  g''4 f ees f 
  g aes bes2 
  c4 bes aes g8 f 
  f2 ees 
  g4 bes aes g 
  f ees d2 
  ees4 f g g 
  aes2 g 
  g4 aes bes aes 
  g f g2 
  f4 f g8 a bes4 
  bes a bes2 
  bes4 g c bes 
  aes g f2 
  g8 aes bes4 aes g8 f 
  f2 ees 
}


alto = \relative c {
  ees'4 d4. c4 bes8 
  bes4 aes d'2 
  ees8 aes4 g f8 ees2 d4 bes2 
  ees4 f ees8 f g ees 
  d4 c b2 
  c4 d ees ees4. d16 ees f8 d ees2 
  ees4 ees e f 
  cis8 c c d ees2 
  c4 c8 d ees4 cis8 ees 
  f2 f 
  f4 ees8 f g4 g 
  ees8 f bes, c d2 
  ees4. bes8 ees f g c, 
  d ees16 c d4 bes2 
}


tenor = \relative c {
  bes'4 bes8 aes g4 f 
  ees8 ees'4 ees8 ees2 
  c4 d ees8 d ees c 
  bes4. aes8 g2 
  bes4 bes c8 d ees c 
  aes g g4 g2 
  g4 bes bes bes 
  c8 aes f bes bes2 
  c4 c bes c 
  bes aes g2 
  aes8 bes c bes bes4. c8 
  cis4 c d2 
  bes4 bes ees d8 bes 
  c d ees4 bes2 
  bes8 aes g f ees d ees4 
  bes'4. aes8 g2 
}


baixo = \relative c {
  ees4 bes c d 
  ees f g2 
  aes4 bes c bes8 aes 
  bes4 bes, ees2 
  ees8 d d c c8*5 b8 c ees g2 
  c,8 c' bes aes g f ees d 
  c f d bes ees2 
  c4 bes8 aes g g'4 f e8 f4 c2 
  f8 g aes4 g fis 
  f8 ees f4 bes,2 
  d8 bes ees4. c8 g'4. f8 g aes bes2 
  ees,4. d8 c c' bes aes 
  bes4 bes, ees2 
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