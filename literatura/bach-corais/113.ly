
\version "2.10.33"

\header {
  title = "113 - Christus, der uns selig macht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \minor
}

soprano = \relative c {
  f''4 f f f 
  ees des c2 
  des4 ees f f 
  ees des c2 
  bes4 c des bes 
  bes8 aes fis4 f2 
  fis4 aes bes bes 
  aes fis f2 
  bes4 a bes c 
  des c8 bes bes2 
  des4 ees f f 
  ees des8 c c2 
  bes4 c des8 c bes4 
  bes8 aes fis4 f2 
  fis4 aes bes bes 
  aes fis f1. 
}


alto = \relative c {
  a''4 a bes c 
  bes bes a2 
  f4 fis aes aes 
  fis f f2 
  f4 f f fis 
  f ees d2 
  ees4 ees e e 
  ees2 d 
  f4 ees f fis 
  f f fis2 
  aes4 aes aes bes 
  bes2 a 
  f4 f f fis 
  f ees d2 
  ees4 f fis fis 
  f ees2 des4 
  c1 
}


tenor = \relative c {
  c'4 c des c8 des 
  ees f fis4 c2 
  bes4 bes b bes 
  bes2 a 
  des4 c bes8 c des ees 
  f bes, bes4 bes2 
  bes4 b des des 
  b8 des ees4 bes2 
  des4 c bes bes 
  bes8 aes des4 des2 
  f4 c des des 
  ees8 f fis4 f2 
  bes,4 a bes8 c des ees 
  f bes, bes4 bes2 
  bes4 des des des 
  des8 b bes4 a bes 
  a1 
}


baixo = \relative c {
  f4 f bes aes 
  fis f8 ees f2 
  bes4 fis d d 
  ees bes f'2 
  bes4 a bes fis 
  d ees bes2 
  ees4 b g g 
  aes a bes2 
  bes4 c des ees 
  f des fis2 
  f4 aes des8 c bes aes 
  fis4 f8 ees f2 
  des4 f bes8 aes fis4 
  d ees bes2 
  ees4 des fis,8 aes bes b 
  des4 ees f1. 
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