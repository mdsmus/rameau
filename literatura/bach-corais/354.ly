
\version "2.10.33"

\header {
  title = "354 - Es ist das Heil uns kommen her"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d''4 
  d d d8 e f4 
  e d c d 
  b8 a g a b4 cis 
  d e d d 
  d d d8 e f4 
  e d c d 
  b8 a g a b4 cis 
  d e d d 
  g fis e fis 
  g8 fis e4 d d 
  g d e b8 c 
  d4 c b b 
  a8 b c4 b a 
  e fis g2 
}


alto = \relative c {
  \partial 4 g''4 
  a g8 fis g4 c,8 d 
  e f g4 g a 
  g d g8 fis e4 
  a8 fis g4 fis g 
  a g8 fis g4 c,8 d 
  e f g4 g a 
  g d g8 fis e4 
  a8 fis g4 fis b 
  b a8 b cis4 cis 
  d a8 g fis4 g 
  g g g g 
  a8 b e, a gis4 g 
  a g8 a b g e4 
  e d d2 
}


tenor = \relative c {
  \partial 4 b'4 
  a b8 c b4 a 
  g8 c c b e4 d 
  d8 c b a g4 a 
  a8 d4 cis8 d4 b 
  a b8 c b4 a 
  g8 c c b e4 d 
  d8 c b a g4 a 
  a8 d4 cis8 d4 d 
  d8 e fis g a g fis e 
  d4 cis a b 
  b8 c d4 c g8 e' 
  d b c e16 dis e4 d 
  d e d c8 b 
  a2 b 
}


baixo = \relative c {
  \partial 4 g'4 
  fis d g, a8 b 
  c4 g c fis 
  g4. fis8 e fis g a 
  fis d a'4 d, g 
  fis d g, a8 b 
  c4 g c fis 
  g4. fis8 e fis g a 
  fis d a'4 d, g8 a 
  b cis d4 a ais 
  b8 g a4 d, g8 fis 
  e d c b c d e4 
  fis8 gis a4 e g 
  fis e8 fis g4 c, 
  cis d g,2 
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