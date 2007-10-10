
\version "2.10.33"

\header {
  title = "212 - Lob sei dir, gütiger Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  ees'4 ees bes' bes 
  c d ees2 
  d4. ees8 f4 bes, 
  ees d c2 
  bes ees4 ees 
  bes bes aes aes 
  g2 bes4 bes 
  aes g f2 
  ees f4 f 
  g8 a bes4 bes a 
  bes2 c4 d 
  ees2 bes4 bes 
  aes g f2 
  ees1 
}


alto = \relative c {
  bes'4 bes ees g8 f 
  ees4 f g2 
  f4 bes4. aes8 g4. f8 f4 g f8 ees 
  d2 g4 g 
  f f8 g4 c,8 f ees16 d 
  ees2 f4 ees 
  f4. ees8 ees4 d 
  bes2 d4 d 
  ees f8 g f4 f 
  f2 f8 aes4 g8 
  g2 f8 aes4 g8 
  f4. ees4 d16 c d4 
  bes1 
}


tenor = \relative c {
  g'4 g8 aes bes ees4 cis8 
  c bes aes4 bes2 
  bes4 bes bes bes4. a8 bes2 a4 
  f2 bes4 bes8 c 
  d4. c8 c4 bes 
  bes2 d8 c bes4 
  bes bes c8 f, bes aes 
  g2 bes4. aes8 
  bes c d4 c8 d ees4 
  d2 c8 f d4 
  c2 f4. ees4 d16 c bes4 c bes8 aes 
  g1 
}


baixo = \relative c {
  ees4. f8 g4 ees 
  aes8 g f4 ees2 
  bes'8 aes g4 d ees8 d 
  c f bes, d ees c f4 
  bes,2 ees,8 f g aes 
  bes c d ees f ees d bes 
  ees2 bes'8 aes g f 
  ees d ees4 aes, bes 
  ees,2 bes''8 aes g f 
  ees4 d8 ees f2 
  bes, aes'4 b, 
  c2 d4 ees 
  f g aes bes8 bes, 
  ees1 
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