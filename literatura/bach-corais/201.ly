
\version "2.10.33"

\header {
  title = "201 - Es sind doch selig alle, die im rechten Glauben wandeln"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  \partial 4 ees'4 
  ees f g8 f ees4 
  g a bes bes 
  aes g f ees8 f 
  g4 a bes c 
  bes aes g aes 
  f2 ees4 ees 
  ees f g8 f ees4 
  g a bes bes 
  aes g f ees8 f 
  g4 a bes c 
  bes aes g aes 
  f2 ees4 ees' 
  ees ees d bes 
  c c g ees' 
  ees ees d bes 
  c c bes g8 aes 
  bes4 c bes g 
  aes2 g4 f 
  g aes bes bes 
  aes g f bes 
  c d ees d 
  c c bes ees, 
  f g aes g 
  f2 ees 
}


alto = \relative c {
  \partial 4 bes'4 
  c4. b16 c d4. c16 d 
  ees4. d8 d4 g4. f4 ees d8 c d 
  ees4 ees d f2 ees16 d ees8 bes ees16 d ees4. d16 c d4 bes bes 
  c4. b16 c d4. c16 d 
  ees4. d8 d4 g4. f4 ees d8 c d 
  ees4 ees d f2 ees16 d ees8 bes ees16 d ees4. d16 c d4 bes bes'8 
  aes 
  g4 f f ees 
  ees8 cis ees4 ees g 
  f f f f 
  g f8 ees d4 ees8 f 
  g4 aes g g4. f16 ees f8 d ees4 f 
  ees ees f g 
  c,8 d ees4. d8 f4 
  f f g8 a bes2 a4 g ees 
  d ees f8 d bes ees4 d16 c d4 bes2 
}


tenor = \relative c {
  \partial 4 g'4 
  aes aes g g 
  c8 bes a4 g d' 
  ees8 bes bes4 c8 g g4 
  c8 bes c4 bes aes4. g4 f8 ees4. bes'8 
  c aes f bes g4 g 
  aes aes g g 
  c8 bes a4 g d' 
  ees8 bes bes4 c8 g g4 
  c8 bes c4 bes aes4. g4 f8 ees4. bes'8 
  c aes f bes g4 g8 aes 
  bes4 c4. bes16 aes g4 
  aes aes bes c 
  c8 bes a4 bes8 a bes4. a16 g a4 bes bes 
  ees ees ees8 ees4 c8 
  c4 d8 f c4 aes 
  bes c d d,8 e 
  f4 bes bes d 
  c bes4. c8 d4 
  g, d' d c 
  bes bes4. f8 g bes 
  c aes f bes16 aes g2 
}


baixo = \relative c {
  \partial 4 ees4 
  aes8 g f4 b, c2 fis,4 g g' 
  c,8 d ees4 a8 b c2 f,4 bes f'8 ees 
  d bes c d ees d c bes 
  aes f bes4 ees, ees' 
  aes8 g f4 b, c2 fis,4 g g' 
  c,8 d ees4 a8 b c2 f,4 bes f'8 ees 
  d bes c d ees d c bes 
  aes f bes4 ees, ees8 f 
  g4 a bes8 c cis4 
  c8 bes aes4 ees' c8 bes 
  a g f4 bes8 c d4 
  c f bes, ees4. cis8 c d ees4 e 
  f b, c cis2 c4 bes8 aes g4 
  f g8 aes bes4 bes' 
  a aes g4. f8 
  e4 fis g aes4. g8 f ees d bes ees g, 
  aes4 bes ees,2 
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