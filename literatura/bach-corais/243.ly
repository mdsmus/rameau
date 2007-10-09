
\version "2.10.33"

\header {
  title = "243 - Jesu, du mein liebstes Leben"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \minor
}

soprano = \relative c {
  g''2 a4 bes 
  c d c2 
  bes4 a2 g4 
  d' ees f bes, 
  c d c2 
  c4 bes2. 
  g2 a4 bes 
  c d c2 
  bes4 a2 g4 
  d' ees f bes, 
  c d c2 
  c4 bes2. 
  a2 g4 a 
  bes c bes2 
  a4 g2 f4 
  bes2 a4 bes 
  c d d2 
  c4 d2. 
  a2 d4 g, 
  a bes a2 
  a4 g2. 
}


alto = \relative c {
  d'2 a'4. g8 
  f ees d4 g a4. g8 g4 fis d 
  bes' a8 g f4 g 
  f8 ees d4 g ees8 g 
  f ees d2. 
  d2 a'4. g8 
  f ees d4 g a4. g8 g4 fis d 
  bes' a8 g f4 g 
  f8 ees d4 g ees8 g 
  f ees d2. 
  f2 g4. f8 
  e d c4 f g4. f e4 c 
  f g d4. g8 
  f ees d4 g8 fis g bes 
  a g fis2. 
  fis2 fis4 g 
  d d ees c 
  d8 c b2. 
}


tenor = \relative c {
  bes'2 d4 d 
  c bes2 a4 
  bes8 d ees a d c bes4 
  f' ees d2 
  c4 bes2 a8 g 
  a4 bes2. 
  bes2 d4 d 
  c bes2 a4 
  bes8 d ees a d c bes4 
  f' ees d2 
  c4 bes2 a8 g 
  a4 bes2. 
  c2 c4 c 
  bes a2 g4 
  a8 c d g, c bes a4 
  d c2 bes8 ees 
  d c bes4. a8 bes4 
  ees a2. 
  d2 d4 d 
  a g g2 
  fis4 d2. 
}


baixo = \relative c {
  g4 g' fis g 
  a bes e fis 
  g c, d g, 
  bes c d g, 
  a bes ees c 
  f bes,2. 
  g4 g' fis g 
  a bes e fis 
  g c, d g, 
  bes c d g, 
  a bes ees c 
  f bes,2. 
  f4 f' e f 
  g a d, e 
  f bes, c f, 
  d' e fis g 
  a bes ees,2. d 
  d8 d, d' c bes a bes a 
  g fis g4 c a 
  d g,2. 
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