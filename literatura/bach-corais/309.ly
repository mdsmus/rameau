
\version "2.10.33"

\header {
  title = "309 - An Wasserflüssen Babylon"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key aes \major
}

soprano = \relative c {
  \partial 4 ees''4 
  f ees8 des c des ees4 
  des8 c des4 c bes 
  c des ees des8 c 
  bes aes bes4 aes ees' 
  f ees8 des c des ees4 
  des8 c des4 c bes 
  c des ees des8 c 
  bes aes bes4 aes aes 
  bes c des8 c bes4 
  c bes aes aes8 bes 
  c4 des ees f 
  c d ees c8 des 
  ees4 f ees8 des c4 
  des2 c4 f 
  f f bes, ees 
  des c bes des 
  c bes aes bes8 aes 
  fis4 f ees ees 
  aes bes c4. des8 
  ees4 des8 c bes4 c8 des 
  bes2 aes4 
}


alto = \relative c {
  \partial 4 aes''4 
  aes g aes g 
  f8 aes4 g8 aes4 bes 
  aes aes aes aes 
  aes g ees aes 
  aes g aes g 
  f8 aes4 g8 aes4 bes 
  aes aes aes aes 
  aes g ees ees 
  ees8 f g4 f f8 ees 
  ees4 des c f 
  ees f fis f8 g 
  aes g aes bes g4 ees 
  aes aes bes c 
  c8 a bes4 a c 
  bes f8 des ees f fis4 
  f ees des bes' 
  ees,8 f fis4 f8 ees f4. ees4 d8 ees4 ees8 des 
  c bes aes fis aes4 aes' 
  g aes aes aes2 g4 ees 
}


tenor = \relative c {
  \partial 4 c'4 
  des8 c bes4 f' bes,8 c 
  des f ees4 ees ees 
  ees aes,8 bes c aes f'4 
  bes,8 c des4 c c 
  des8 c bes4 f' bes,8 c 
  des f ees4 ees ees 
  ees aes,8 bes c aes f'4 
  bes,8 c des4 c c 
  bes ees aes, bes4. aes4 g8 aes4 aes 
  aes aes aes aes 
  aes8 bes16 bes bes4 bes aes 
  aes8 ees' des c bes4 f' 
  f2 f4 f8 ees 
  des c bes4. a8 bes c 
  a bes4 a8 bes4 f8 g 
  aes4 ees'8 des b4 bes 
  bes aes g g 
  aes ees' ees f 
  ees2 f8 ees des4 
  ees8 f ees des c4 
}


baixo = \relative c {
  \partial 4 aes'4 
  des, ees f g8 aes 
  bes4 ees, aes g 
  aes8 g f4 c des 
  ees2 aes,4 aes' 
  des, ees f g8 aes 
  bes4 ees, aes g8 s8 
  aes g f4 c des 
  ees2 aes,4 aes' 
  g f8 ees f4 g 
  aes ees aes, des 
  aes'8 fis f ees des c des ees 
  f4 bes, ees aes8 bes 
  c4 des g a 
  bes bes, f' a, 
  bes8 c des bes fis'4 f8 ees 
  f4 f, bes bes 
  c8 d ees2 d4 
  ees bes ees c 
  f ees aes8 g f4 
  c8 bes aes4 des8 c bes4 
  ees8 des ees4 aes, 
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