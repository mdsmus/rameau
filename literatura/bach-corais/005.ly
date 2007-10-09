
\version "2.10.33"

\header {
  title = "5 - An Wasserflüssen Babylon"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d''4 
  e d8 c b c d4 
  c8 b c4 b a 
  b c d c8 b 
  a g a4 g d' 
  e d8 c b c d4 
  c8 b c4 b a 
  b c d c8 b 
  a g a4 g g 
  a b c8 b a4 
  b a g g8 a 
  b4 c d e 
  b cis d b8 c 
  d4 e d8 c b4 
  c2 b4 e 
  e e a, d 
  c b a c 
  b a g a8 g 
  f4 e d d 
  g a b4. c8 
  d4 c8 b a4 b8 c 
  a2 g4 
}


alto = \relative c {
  \partial 4 g''4 
  g fis g fis 
  e8 g4 fis8 g4 a 
  g g g g 
  g fis d g 
  g fis g fis 
  e8 g4 fis8 g4 a 
  g g g g 
  g fis d d 
  d8 e fis4 e e8 d 
  d4 c b e 
  d e f e8 fis 
  g fis g a fis4 d 
  g g a b 
  b8 gis a4 gis b 
  a e8 c d e f4 
  e d c a' 
  d,8 e f4 e8 d e4. d4 cis8 d4 d8 c 
  b a g f g4 g' 
  fis g g g2 fis4 d 
}


tenor = \relative c {
  \partial 4 b'4 
  c8 b a4 e' a,8 b 
  c e d4 d d 
  d g,8 a b g e'4 
  a,8 b c4 b b 
  c8 b a4 e' a,8 b 
  c e d4 d d 
  d g,8 a b g e'4 
  a,8 b c4 b b 
  a d g, a4. g4 fis8 g4 g 
  g g g g 
  g8 a16 a a4 a g 
  g8 d' c b a4 e' 
  e2 e4 e8 d 
  c b a4. gis8 a b 
  gis a4 gis8 a4 e8 fis 
  g4 d'8 c ais4 a 
  a g fis fis 
  g d' d e 
  d2 e8 d c4 
  d8 e d c b4 
}


baixo = \relative c {
  \partial 4 g'4 
  c, d e fis8 g 
  a4 d, g fis 
  g8 fis e4 b c 
  d2 g,4 g' 
  c, d e fis8 g 
  a4 d, g fis8 s8 
  g fis e4 b c 
  d2 g,4 g' 
  fis e8 d e4 fis 
  g d g, c 
  g'8 f e d c b c d 
  e4 a, d g8 a 
  b4 c fis, gis 
  a a, e' gis, 
  a8 b c a f'4 e8 d 
  e4 e, a a 
  b8 cis d2 cis4 
  d a d b 
  e d g8 fis e4 
  b8 a g4 c8 b a4 
  d8 c d4 g, 
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