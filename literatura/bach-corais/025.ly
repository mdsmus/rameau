
\version "2.10.33"

\header {
  title = "25 - Auf meinen lieben Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \minor
}

soprano = \relative c {
  \partial 4 f'4 
  f g aes bes 
  c2 s4 c 
  c4. bes8 aes4 bes 
  g2 s4 g 
  aes bes c c 
  bes2 c4 c 
  aes bes c des8 ees 
  c4 bes8 aes aes4 c 
  ees c c c 
  bes2 bes4 bes 
  c4. bes8 aes4 bes8 aes 
  g2 f 
}


alto = \relative c {
  \partial 4 c'4 
  c d8 e f e f g 
  e2 s4 ees4. f8 g4 g8 f e f 
  e2 s4 e 
  f ees ees f 
  f ees ees ees 
  f f8 g aes4 aes 
  aes g ees aes 
  bes aes aes aes 
  aes g8 f g4 g 
  g8 f e4 f f2 e4 c2 
}


tenor = \relative c {
  \partial 4 aes'8 bes 
  c4 bes c des 
  g2 s4 aes 
  aes g c des 
  c2 s4 c 
  c8 des c bes aes4 aes2 g4 aes aes 
  aes des c f 
  ees des8 c c4 ees 
  ees ees f ees 
  f8 ees d4 ees ees8 des 
  c4 c c bes8 c 
  des4 c8 bes a2 
}


baixo = \relative c {
  \partial 4 f8 g 
  aes4 g f des 
  c2 s4 aes8 bes 
  c des ees e f4 bes, 
  c2 s4 c 
  f g aes8 g f ees 
  des4 ees aes, aes 
  des8 c bes4 f'8 ees des4 
  ees2 aes,4 aes' 
  g aes8 g f ees d c 
  ees4 bes ees g8 f 
  e d c4 f8 ees des c 
  bes4 c f,2 
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