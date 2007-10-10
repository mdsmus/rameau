
\version "2.10.33"

\header {
  title = "108 - Valet will ich dir geben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  \partial 4 ees'4 
  bes' bes c d 
  ees2 ees4 g 
  f ees ees d 
  ees2. ees,4 
  bes' bes c d 
  ees2 ees4 g 
  f ees ees d 
  ees2. ees8 f 
  g4 g f ees 
  d8 c d4 bes d 
  ees d c c 
  bes2. bes4 
  g8 aes bes4 c bes 
  bes aes g bes 
  aes g f f 
  ees1 
}


alto = \relative c {
  \partial 4 bes'4 
  ees g aes g 
  g2 g4 c 
  c aes g f 
  g2. bes,4 
  ees g aes g 
  g2 g4 c 
  c aes g f 
  g2. g8 aes 
  bes4 c c a 
  bes8 a bes4 f bes 
  bes bes bes a 
  f2. f4 
  ees8 f g4 aes g 
  g f ees ees 
  ees ees ees d 
  bes1 
}


tenor = \relative c {
  \partial 4 g'4 
  bes ees ees d 
  c2 c4 ees 
  c c bes bes 
  bes2. g4 
  bes ees ees d 
  c2 c4 ees 
  c c bes bes 
  bes2. bes4 
  ees ees f f 
  f8 ees f4 d f 
  ees f g f8 ees 
  d2. bes4 
  bes ees ees cis 
  c2 c4 g 
  aes bes c bes8 aes 
  g1 
}


baixo = \relative c {
  \partial 4 ees4 
  g ees aes b, 
  c2 c4 c' 
  aes f bes bes, 
  ees2. ees4 
  g ees aes b, 
  c2 c4 c' 
  aes f bes bes, 
  ees2. ees4 
  ees'8 d c bes a4 f 
  bes2 bes,4 aes' 
  g f ees f 
  bes,2. d4 
  ees cis c8 d e4 
  f2 c4 cis 
  c bes a bes 
  ees,1 
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