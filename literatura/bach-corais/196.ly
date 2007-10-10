
\version "2.10.33"

\header {
  title = "196 - Da der Herr Christ zu Tische saß"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g g bes g 
  bes b c d 
  ees8 d c d ees4 d 
  c c b g 
  c8 d ees4 d c 
  b2 c4 g 
  g a bes aes 
  g f ees ees 
  bes' bes c d 
  ees d ees ees 
  f ees d c 
  c b c2 
}


alto = \relative c {
  \partial 4 ees'8 f 
  g f ees4 f4. ees8 
  g4 f ees g 
  g g g g 
  g g8 f g4 d 
  g g aes8 g g f 
  g aes g f ees4 ees8 f 
  g4 f f8 g4 f ees d8 ees4 c 
  ees8 f g4 ees f 
  g f g g8 aes4 g8 g4 f8 aes g f 
  ees d16 c d8 f4 e4. 
}


tenor = \relative c {
  \partial 4 c'4 
  d4. c8 bes4 bes 
  bes8 c d4 g, d' 
  c8 d ees d c4 b 
  c8 b c4 d b 
  c c4. b8 c4 
  d g, g c 
  c8 g c4 d8 c4 d16 c 
  bes8 c f, bes16 aes g4 g8 aes 
  bes aes bes des c bes aes4 
  bes bes bes c 
  d4. c4 b8 c aes 
  g2 g 
}


baixo = \relative c {
  \partial 4 c4 
  b c d ees2 d4 c b 
  c8*5 ees8 g f 
  ees4 aes g g8 f 
  ees d c4 f8 g aes4 
  g g, c c8 d 
  ees4. f16 ees d8 ees f4 
  g8 aes bes bes, c4 c 
  g8 f ees4 aes8 g f4 
  ees8 g bes4 ees c4. b8 c4 d ees8 f 
  g4 g, c2 
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