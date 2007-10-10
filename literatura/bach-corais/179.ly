
\version "2.10.33"

\header {
  title = "179 - Wachet auf, ruft uns die Stimme"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  ees'2 g 
  bes2. bes4 
  bes2 bes 
  c1 
  bes 
  s2 bes 
  ees bes 
  ees4 f g2 
  f ees 
  d c 
  bes1 
  s2 bes 
  ees bes 
  c g 
  aes4 g f2 
  ees1 
  ees2 g 
  bes2. bes4 
  bes2 bes 
  c1 
  bes 
  s2 bes 
  ees bes 
  ees4 f g2 
  f ees 
  d c 
  bes1 
  s2 bes 
  ees bes 
  c g 
  aes4 g f2 
  ees1 
  s2 bes' 
  bes2. aes4 
  g2 f 
  ees1 
  s2 bes' 
  bes2. aes4 
  g2 f 
  ees1 
  s2 f 
  g aes 
  g1 
  s2 bes 
  c d 
  ees ees4 f 
  g2 f 
  ees bes 
  ees bes 
  c g 
  aes4 g f2 
  ees1 
}


alto = \relative c {
  bes'2 ees 
  g f 
  g f 
  g f 
  f1 
  s2 f 
  bes2. aes4 
  g aes bes2 
  bes c 
  c4 bes2 a4 
  f1 
  s2 g 
  aes g 
  ees ees 
  ees d 
  bes1 
  bes2 ees 
  g f 
  g f 
  g f 
  f1 
  s2 f 
  bes2. aes4 
  g aes bes2 
  bes c 
  c4 bes2 a4 
  f1 
  s2 g 
  aes g 
  ees ees 
  ees d 
  bes1 
  s2 f' 
  g2. f4 
  bes, c d2 
  c1 
  s2 d4 ees 
  f2 f 
  f4 ees2 d4 
  bes1 
  s2 d 
  ees2. d4 
  ees1 
  s2 g 
  g4 f f g 
  g2 g4 aes 
  bes2. aes4 
  g2 g4 aes 
  bes aes bes g 
  aes2 ees 
  ees d 
  bes1 
}


tenor = \relative c {
  g'2 bes 
  ees d 
  ees bes 
  bes a 
  d1 
  s2 d 
  ees ees 
  bes ees 
  f f 
  f2. c4 
  d1 
  s2 ees 
  ees ees4 cis 
  c2 c 
  c4 bes aes2 
  g1 
  g2 bes 
  ees d 
  ees bes 
  bes a 
  d1 
  s2 d 
  ees ees 
  bes ees 
  f f 
  f2. c4 
  d1 
  s2 ees 
  ees ees4 cis 
  c2 c 
  c4 bes aes2 
  g1 
  s2 bes 
  ees4 d c d 
  ees2 bes4 aes 
  g1 
  s2 bes 
  bes4 c d2 
  bes4 c2 bes4 
  g1 
  s2 bes 
  bes c4 aes 
  bes1 
  s2 ees 
  ees d 
  c ees 
  ees d 
  ees ees 
  bes ees 
  ees2. c4 
  c bes aes2 
  g1 
}


baixo = \relative c {
  ees4*5 g4 bes aes 
  g f ees d 
  ees c f2 
  bes,1 
  s2 bes'4 aes 
  g aes g f 
  ees2 ees' 
  d4 c bes a 
  bes2 f 
  bes,1 
  s2 ees4 cis 
  c d ees2 
  aes4 bes c2 
  f, bes, 
  ees1 
  ees4*5 g4 bes aes 
  g f ees d 
  ees c f2 
  bes,1 
  s2 bes'4 aes 
  g aes g f 
  ees2 ees' 
  d4 c bes a 
  bes2 f 
  bes,1 
  s2 ees4 cis 
  c d ees2 
  aes4 bes c2 
  f, bes, 
  ees1 
  s2 d 
  ees f 
  g4 aes bes bes, 
  c1 
  s2 g' 
  d4 c bes2 
  ees4 c aes bes 
  ees1 
  s2 bes'4 aes 
  g2 f 
  ees1 
  s2 ees' 
  a b 
  c c 
  g4 aes bes2 
  c, ees4 f 
  g f g ees 
  aes, bes c2 
  f bes, 
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