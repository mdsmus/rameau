
\version "2.10.33"

\header {
  title = "229 - Mein Hüter und mein Hirt ist Gott der Herre"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g g f8 ees d4 
  f g a g 
  g fis g bes 
  a g f d 
  f g a g 
  g fis g d' 
  d d g, c 
  c bes a g 
  f2 d4 g 
  g fis g fis 
  g fis g a 
  bes2 a4 bes 
  a g f d8 ees 
  f4 f g f 
  ees2 d4 d' 
  c bes a fis 
  g a8 bes c4 bes 
  a2 g 
}


alto = \relative c {
  \partial 4 d'4 
  g8 f ees d c4. bes8 
  d4 ees8 d ees4 d 
  ees d d g 
  g8 fis g ees c4 c8 bes16 c 
  d8 c bes4 ees8 d e4 
  d d d g 
  g4. fis8 g4 g 
  d d4. c8 bes d 
  c bes c4 bes d 
  d8 ees d c bes c d4 
  d c d d 
  d2 d4 d 
  d8 c bes4 c bes 
  a8 bes16 c d ees f4 ees d c16 b c4 b g'4. fis8 g4. fis16 e 
  d4. e8 fis g a4. g8 
  g fis16 e fis4 d2 
}


tenor = \relative c {
  \partial 4 bes'8 c 
  d4 bes a8 g f4 
  bes bes c4. bes8 
  a16*5 bes16 c4 bes8 d4 
  d8. c16 bes4 c8 a f4 
  bes8 a g4 c bes4. a16 g a bes c8 bes4 bes8 c 
  d c16 bes a8 bes16 c bes2 
  a4. g4 fis8 g bes 
  a g a4 f bes8 c 
  d c16 bes a4 g a 
  g a bes a2 g4 fis g4. fis8 g ees c f f4 
  f8 g16 a bes4 bes bes8. a16 
  g2 g4 bes 
  c d d a 
  bes c8 d ees d d4 
  ees8 c a d b2 
}


baixo = \relative c {
  \partial 4 g8 a 
  bes4 g a bes4. a8 g4. fis8 g4 
  c d g, g 
  d' ees a8 f bes2 ees8 d c4. cis8 
  d2 g,4 g8 a 
  bes c d4 ees e 
  fis g d ees 
  a f bes g8 a 
  bes c d4 ees d8 c 
  bes c bes a g a g fis 
  g a bes g d'4 g, 
  d' ees a bes8 c 
  d4 d ees bes 
  c8 d ees c g'4 g, 
  a bes8 c d4. c8 
  bes4 a8 g fis4 g 
  c d g,2 
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