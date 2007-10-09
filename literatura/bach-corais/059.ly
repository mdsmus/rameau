
\version "2.10.33"

\header {
  title = "59 - Herzliebster Jesu, was hast du verbrochen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 g''4 
  g g fis d 
  g a bes bes 
  c bes a a 
  bes c d8 c bes4 
  ees ees d cis8 c 
  c2 bes4 bes 
  a g f d8 ees 
  f4 f g f 
  ees2 d4 d' 
  c bes8 a a2 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  ees8 d c4 d a 
  d8 e fis4 g g 
  a g fis fis 
  g a bes f 
  g8 a bes4 bes bes 
  bes a f g8 f 
  ees d e4 d a 
  d8 ees f4 f8 ees ees d 
  d c16 bes c4 bes bes' 
  a g g fis 
  d1 
}


tenor = \relative c {
  \partial 4 bes'4 
  bes a8 g a4 fis 
  g c d d 
  ees d d d 
  d ees f8 ees d c 
  bes4 bes8 c d bes g'4 
  f4. ees8 d4 d 
  c bes a f 
  bes bes bes a 
  bes f f f' 
  ees d e d8 c 
  b1 
}


baixo = \relative c {
  \partial 4 g'4 
  c,8 d ees4 d c 
  bes a g g' 
  fis g d d 
  g c bes gis 
  g fis f e 
  f2 bes,4 g 
  c cis d4. c8 
  bes c d bes ees4 f 
  g a bes bes 
  fis g cis, d 
  g,1 
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