
\version "2.10.33"

\header {
  title = "123 - Helft mir Gotts Güte preisen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a b c d 
  b8 c4 b16 c d4 e 
  d8 c b a c4 b8 a 
  a2. a4 
  a b c d 
  b8 c4 b16 c d4 e 
  d8 c b a c4 b8 a 
  a2. e'4 
  d c b a 
  b2. b4 
  c d e e 
  d8 c b c b4 b 
  c d e e 
  d8 c b c b4 e 
  d8 c b a c4 b8 a 
  a1 
}


alto = \relative c {
  \partial 4 e'8 d 
  e f e d c e a fis 
  d g e a gis4 b8 gis 
  e4. a8 a b gis4 
  e2. e8 d 
  e f e d c e a fis 
  d g e a gis4 b8 gis 
  e4. a8 a b gis4 
  e2. a8 g 
  fis gis a4 a8 gis a d 
  gis,2. gis4 
  a g g c8 b 
  a g fis4 g b 
  a g g g 
  fis8 gis a4 gis c8 b 
  a4 gis8 a a fis gis4 
  e1 
}


tenor = \relative c {
  \partial 4 c'8 b 
  c d c b a c b a 
  b e c f e d b4 
  a8 b c d e f b, d 
  c2. c8 b 
  c d c b a c b a 
  b e c f e d b4 
  a8 b c d e f b, d 
  c2. c4 
  c8 b e f b, e e a, 
  e'2. e4 
  e d c8 d e4 
  a, d d e 
  e b c b 
  a8 e' d a e'4 a, 
  d8 e f d e4 d8 cis 
  cis1 
}


baixo = \relative c {
  \partial 4 a4 
  a' gis a fis 
  g8 a4 g16 a b4 gis 
  a f e8 d e4 
  a,2. a4 
  a' gis a fis 
  g8 a4 g16 a b4 gis 
  a f e8 d e4 
  a,2. a4 
  b c8 d e4 f 
  e2. e4 
  a8 b c b c b a g 
  fis e d4 g gis 
  a8 g f g f e d c 
  d e f d e4 c 
  f8 e d f e d e4 
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