
\version "2.10.33"

\header {
  title = "114 - Von Gott will ich nicht lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a b c d 
  b4. a8 g4 g 
  a a b b 
  e,2. a4 
  a b c d 
  b4. a8 g4 g 
  a a b b 
  e,2. e'4 
  d c b a 
  b2. b4 
  c d e e 
  d2 b4 d 
  c b a a 
  b4. a8 g4 f 
  e a8 b c4 b 
  a1 
}


alto = \relative c {
  \partial 4 e'4 
  f f g a 
  g fis e e 
  e d8 e f4 e8 d4 c16 b c2 e4 
  f f g a 
  g fis e e 
  e d8 e f4 e8 d4 c16 b c2 e8 fis 
  gis4 a8 g f4 e8 fis 
  gis2. gis4 
  a b c8 b a g 
  a g fis4 g f 
  e8 a4 g8 g f16 e f4 
  fis8 dis e fis b,4 b 
  c c8 d e4 e8 d 
  c1 
}


tenor = \relative c {
  \partial 4 c'4 
  c d g, d' 
  d8 e fis4 b, b 
  a a a gis 
  a2. c4 
  c d g, d' 
  d8 e fis4 b, b 
  a a a gis 
  a2. g8 a 
  b4 e8 c d b c4 
  b2. e4 
  e f g c,8 b 
  a4 d d b 
  a8 e' e4 e8 d16 cis d8 c 
  b a g fis e4 f 
  g a a gis 
  a1 
}


baixo = \relative c {
  \partial 4 a'8 g 
  f4 e8 d e4 fis 
  g dis e e8 d 
  c4 f8 e d4 e 
  a2. a8 g 
  f4 e8 d e4 fis 
  g dis e e8 d 
  c4 f8 e d4 e 
  a2. c,4 
  b8 b' a4 gis a 
  e2. e4 
  a g8 f c'4 e, 
  fis e8 d g4 gis 
  a e f4. e8 
  dis b cis dis e4 d 
  c f e8 d e4 
  a,1 
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