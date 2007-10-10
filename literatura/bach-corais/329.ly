
\version "2.10.33"

\header {
  title = "329 - Es ist das Heil uns kommen Her"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d''4 
  d d d8 e f4 
  e d c d8 c 
  b a g a b4 cis 
  d e d d 
  d d d8 e f4 
  e d c d8 c 
  b a g a b4 cis 
  d e d d 
  g fis e fis 
  g8 fis e4 d d 
  g d e b8 c 
  d4 c b b 
  a8 b c4 b a 
  e16 fis g4 fis8 g2 
}


alto = \relative c {
  \partial 4 b''4 
  a8 g fis4 g c,8 d 
  e f g4 c, a' 
  d, e8 fis g fis e4 
  fis g fis b 
  a8 g fis4 g c,8 d 
  e f g4 c, a' 
  d, e8 fis g fis e4 
  fis g fis b8 a 
  g4 d' cis8 b a4 
  b8 d a4 a g8 a 
  b c b a g4 g 
  fis8 e e fis gis4 g 
  a8 d, g a d, g4 fis8 
  g b, e d d2 
}


tenor = \relative c {
  \partial 4 g''4 
  d a g8 b a g 
  c4 d8 e16 f e4 d 
  d8 c b4 e a, 
  a8 d4 cis8 d4 g 
  d a g8 b a g 
  c4 d8 e16 f e4 d 
  d8 c b4 e a, 
  a8 d4 cis8 d4 d 
  d8 e fis g a4 d, 
  d8 b e4 fis b,8 a 
  g4 g'8 fis e4 e 
  d8 b a4 b b8 g 
  d'4 c8 a b4 c8 a 
  e'4 a, b2 
}


baixo = \relative c {
  \partial 4 g'4 
  fis8 e d c g' g, a b 
  c4 g' a fis 
  g4. fis8 e fis g a 
  fis b g a d,4 g 
  fis8 e d c g' g, a b 
  c4 g' a fis 
  g4. fis8 e fis g a 
  fis b g a d,4 g8 a 
  b cis d4 a8 b c4 
  b8 g a4 d, g8 fis 
  e4 b c8 d e4 
  fis8 gis a4 e g 
  fis8 g e fis g e c d 
  e4 c8 d g,2 
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