
\version "2.10.33"

\header {
  title = "225 - Gott, der du selber bist das Licht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 d''4 
  g, a8 bes c4 bes 
  a a g c 
  c c d c 
  d e f d 
  c bes a g 
  a2 g4 d' 
  g, a8 bes c4 bes 
  a a g c 
  c c d c 
  d e f d 
  c bes a g 
  a2 g4 a 
  bes c d ees 
  d c bes d 
  f ees d g,8 a 
  bes4 a g2 
}


alto = \relative c {
  \partial 4 g''4 
  g fis8 g a4. g4 fis16 e fis4 d g 
  f8 e f4 f f 
  bes8 d4 cis8 d4 bes 
  a d,8 e fis4 g 
  g fis d g 
  g fis8 g a4. g4 fis16 e fis4 d g 
  f8 e f4 f f 
  bes8 d4 cis8 d4 bes 
  a d,8 e fis4 g 
  g fis d f 
  f8 bes4 a8 bes4 c4. bes4 a8 f4 f 
  f8 a g f f4 ees 
  d8 g4 fis8 d2 
}


tenor = \relative c {
  \partial 4 bes'8 c 
  d4 c8 d ees d d4 
  ees8 c a d16 c bes4 c8 bes 
  a bes c a bes4 c 
  bes8 a g4 a g'4. fis8 g4 d8 c bes4 
  ees8 c a d16 c bes4 bes8 c 
  d4 c8 d ees d d4 
  ees8 c a d16 c bes4 c8 bes 
  a bes c a bes4 c 
  bes8 a g4 a g'4. fis8 g4 d8 c bes4 
  ees8 c a d16 c bes4 c 
  d ees f f 
  f g8 f16 ees d4 d 
  c8 d bes c d4 c8 fis, 
  g d' d8. c16 b2 
}


baixo = \relative c {
  \partial 4 g8 a 
  bes4 a8 g fis4 g 
  c8 a d4 g, e 
  f8 g a f bes bes'4 a8 
  g f e4 d g, 
  a bes8 c d4 ees8 d 
  c4 d g, g8 a 
  bes4 a8 g fis4 g 
  c8 a d4 g, e 
  f8 g a f bes bes'4 a8 
  g f e4 d g, 
  a bes8 c d4 ees8 d 
  c4 d g, f'8 ees 
  d4 c bes8 bes'4 a8 
  bes d, ees f bes,4 bes 
  a8 f g a bes4 c 
  bes8 g d'4 g,2 
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