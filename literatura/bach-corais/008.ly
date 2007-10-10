
\version "2.10.33"

\header {
  title = "8 - Freuet euch, ihr Christen alle"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \minor
}

soprano = \relative c {
  c''4 c bes aes 
  g4. f8 f4 f 
  aes4. bes8 c4 c 
  bes4. aes8 aes2 
  aes4 bes bes aes 
  g4. f8 f2 
  c'4 c des des 
  bes bes c c 
  aes aes des des 
  c c bes2 
  g4 aes bes aes 
  g g f2 
  f'4 f ees ees 
  d d c c 
  c c des c 
  bes4. aes8 aes4 aes 
  aes aes des des 
  bes bes ees ees 
  c c f f 
  e e f f
}


alto = \relative c {
  f'4 f f8 e f4 
  f8 g e4 f c 
  f4. g8 aes4 aes 
  aes8 f g4 ees2 
  f4 g e f 
  f e c2 
  f4 f f f 
  g8 aes bes g aes4 aes 
  f f bes bes 
  bes a f2 
  e4 f f8 e f4 
  f e c2 
  aes'4 aes g g 
  g8 aes g f e4 e 
  f f f8 g aes4 
  aes8 f g4 ees ees 
  f f bes bes 
  g g c c 
  aes8 g aes bes c4 bes8 aes 
  g4 g a a 
}


tenor = \relative c {
  aes'4 a bes c 
  des c8 bes aes4 aes 
  c4. bes8 ees4 ees 
  f ees8 des c2 
  des4 des g f8 aes 
  des4 c8 bes aes2 
  a8 bes c a bes4 bes 
  bes ees ees ees 
  des des f f 
  fis f8 ees des2 
  c4 c bes c 
  des c8 bes aes2 
  c4 c c c 
  c b c g 
  a a bes ees, 
  ees'4. des8 c4 c 
  des des f f 
  ees ees g g 
  f f c f, 
  c' c c c
}


baixo = \relative c {
  f4 ees des c 
  bes c f, f 
  f' ees8 des c bes aes4 
  des ees aes,2 
  des4 c8 bes c4 des 
  bes c f,2 
  f'8 g a f bes, c des bes 
  ees f g ees aes4 aes 
  des,8 ees f des bes c des bes 
  ees c f4 bes,2 
  bes'4 aes g f 
  bes, c f,2 
  f8 g aes bes c d ees f 
  g4 g, c c 
  f8 ees des c bes4 c8 des 
  ees4 ees aes, aes 
  des8 ees des c bes c des bes 
  ees f ees des c des ees c 
  f e f g aes g aes bes 
  c4 c, f f
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