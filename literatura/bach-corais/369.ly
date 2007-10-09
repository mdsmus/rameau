
\version "2.10.33"

\header {
  title = "369 - Wachet doch, erwacht, ihr Schläfer"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \minor
}

soprano = \relative c {
  f''4 f c des 
  ees des8 c c4 bes 
  des des c bes 
  a bes c2 
  f4 f c des 
  ees des8 c c4 bes 
  des des c bes 
  a bes c2 
  c4 des ees8 des c4 
  des c8 bes bes4 aes 
  des ees f8 ees des4 
  ges f ees des 
  c des ees f 
  ees des c2 
  bes4 c des ees8 des 
  c4. c8 bes2 
}


alto = \relative c {
  bes''4 f8 g a4 f 
  ees8 f ges4 f8 ees des4 
  f bes8 aes ges f f ees 
  ees c f g a2 
  bes4 f8 g a4 f 
  ees8 f ges4 f8 ees des4 
  f bes8 aes ges f f ees 
  ees c f g a2 
  a4 bes bes aes 
  aes8 g aes4 g ees 
  bes' aes aes bes8 aes 
  bes c des4 aes8 ges f4 
  aes aes aes aes8 bes 
  c4 bes a2 
  bes4 f f ees8 f 
  ges4 f8 ees d2 
}


tenor = \relative c {
  des'8 c bes4 f'8 ees des c 
  bes4 c a f 
  bes bes bes8 a bes4 
  c bes8 des c2 
  des8 c bes4 f'8 ees des c 
  bes4 c a f 
  bes bes bes8 a bes4 
  c bes8 des c2 
  f4 f ees ees 
  des8 ees f4 ees8 des c4 
  f8 ges f ees des c bes4 
  ees aes,8 bes c4 des 
  ees f ees des 
  ges8 f f e f2 
  f4 f bes, bes 
  bes a f2 
}


baixo = \relative c {
  bes8 c des ees f4 bes8 aes 
  ges4 f8 ees f4 bes, 
  bes'8 aes ges f ees f ges4 
  c,8 ees des bes f'2 
  bes,8 c des ees f4 bes8 aes 
  ges4 f8 ees f4 bes, 
  bes'8 aes ges f ees f ges4 
  c,8 ees des bes f'2 
  f4 bes8 aes g ees aes g 
  f ees des4 ees aes, 
  bes c des ges8 f 
  ees4 f8 ges aes4 des, 
  aes'8 ges f ees des c des4 
  a bes f'2 
  des'8 c bes a bes aes ges f 
  ees4 f bes,2 
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
