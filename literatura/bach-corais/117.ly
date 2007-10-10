
\version "2.10.33"

\header {
  title = "117 - O Welt, ich muß dich lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key aes \major
}

soprano = \relative c {
  \partial 4 c''4 
  aes bes c8 des ees4 
  des2 c4 c8 des 
  ees4 ees bes c 
  aes2 g4 ees 
  aes bes c c 
  bes2. c4 
  aes bes c8 des ees4 
  des2 c4 c8 des 
  ees4 ees bes c 
  aes2 g4 ees 
  aes bes c des 
  c bes aes2 
}


alto = \relative c {
  \partial 4 aes''4 
  f g aes8 bes c4 
  c bes aes aes 
  aes8 g aes f g f ees4 
  ees d ees bes 
  ees des c8 des ees4 
  ees2. g4 
  f ees ees f 
  f8 ees f g a4 aes 
  bes aes8 g f4 g 
  g f e ees 
  ees8 f ees des c ees f g 
  aes4 g ees2 
}


tenor = \relative c {
  \partial 4 ees'4 
  des des ees8 des c bes 
  aes4 ees' ees f 
  ees ees ees g, 
  aes8 g aes4 bes g8 f 
  ees4 f8 g aes4 aes 
  g2. c4 
  c8 des c bes aes bes c4 
  bes8 c des ees f4 f 
  ees8 des c4 d g, 
  c2 c4 c 
  c8 des c bes aes4 aes 
  f' bes,8 c16 des c2 
}


baixo = \relative c {
  \partial 4 aes'4 
  des8 c bes4 aes4. g8 
  f4 g aes f 
  c8 bes c des ees des c4 
  f2 ees4 des 
  c bes aes8 bes c des 
  ees2. e4 
  f g aes a 
  bes bes, f' f 
  g aes aes8 g f e 
  f g aes bes c4 c, 
  f g aes8 g f ees 
  des4 ees aes,2 
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