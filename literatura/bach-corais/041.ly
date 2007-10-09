
\version "2.10.33"

\header {
  title = "41 - Was mein Gott will, das g'scheh allzeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  g a g c 
  c b c c 
  b a d4. c8 
  b4 c b2 
  a2. e4 
  g a g c 
  c b c c 
  b a d4. c8 
  b4 c b2 
  a2. a4 
  a a b4. a8 
  b4 g g fis 
  g g a b 
  c b a2 
  b4 e,8 fis g4 a 
  g c c b 
  c c b a 
  d4. c8 b4 c 
  b2 a 
}


alto = \relative c {
  \partial 4 c'4 
  e8 d c d e f g4 
  g g g g 
  g f8 g a2 
  gis4 a2 gis4 
  e2. c4 
  e8 d c d e f g4 
  g g g g 
  g f8 g a2 
  gis4 a2 gis4 
  e2. e4 
  d8 e fis4 g4. a8 
  g4 e e d 
  d e fis f 
  e8 fis gis4 a4. dis,8 
  e4 b e fis 
  e e a g 
  g a a8 g g f 
  f4. e8 d4 c8 d 
  e2 e 
}


tenor = \relative c {
  \partial 4 a'4 
  b a8 b c4 c8 d 
  e d16 c d4 e e 
  d d a e'2 e4 e4. d8 
  c2. a4 
  b a8 b c4 c8 d 
  e d16 c d4 e e 
  d d a e'2 e4 e4. d8 
  c2. c8 b 
  a4 d d4. dis8 
  e4 b a a 
  b c a d 
  c8 d e4 e8 d c fis, 
  gis4 g8 a b4 c 
  b c d d 
  e e f8 e e d 
  d c b a e'8*5 a,8 gis4 cis2 
}


baixo = \relative c {
  \partial 4 a4 
  e' f c8 d e f 
  g4 g, c c 
  g' d8 e f g a4 
  e8 d c a e'2 
  a,2. a4 
  e' f c8 d e f 
  g4 g, c c 
  g' d8 e f g a4 
  e8 d c a e'2 
  a,2. a'8 g 
  fis4 e8 d g d g fis 
  e b e d c a d4 
  g, c c'8 b a gis 
  a4 e8 d c b a4 
  e' e e dis 
  e a8 g fis4 g 
  c, a d8 e f4 
  b,8 c d4 gis,8 e' c a 
  e'2 a, 
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