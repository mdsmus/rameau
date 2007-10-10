
\version "2.10.33"

\header {
  title = "66 - Es woll uns Gott genädig sein 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 d'8 e 
  f4 g a g 
  c b8 a a4 g 
  c b a g 
  f e d d8 e 
  f4 g a g 
  c b8 a a4 g 
  c b a g 
  f e d d 
  g g e a 
  a gis a a 
  d d e8 d c4 
  d8 c b4 a b 
  c b a g 
  a8 g f4 e d8 e 
  f4 g a8 g f4 
  g8 f e4 d d' 
  d d e d 
  c b a2 
}


alto = \relative c {
  \partial 4 a'4 
  d e f e 
  e e e e 
  e e f8 e d4 
  a8 d4 cis8 a4 a 
  d e f e 
  e e e e 
  e e f8 e d4 
  a8 d4 cis8 a4 a 
  d c8 b c d e4 
  e e e e 
  a g g a8 g 
  f4 b,8 c16 d c4 e 
  e d c8 d e4 
  a, d cis a 
  d e e8 cis d4 
  e8 d cis4 a a' 
  g g g a8 d, 
  e4. d8 cis2 
}


tenor = \relative c {
  \partial 4 f8 g 
  a b c4 c c8 b 
  a4 gis c b 
  a b8 cis d4 d,8 e 
  f g a4 f f8 g 
  a b c4 c c8 b 
  a4 gis c b 
  a b8 cis d4 d,8 e 
  f g a4 f f8 e 
  d4 g g c 
  b8 a b4 c c 
  c b c8 b a4 
  b8 a gis4 e gis 
  a8 g f g a b cis d 
  e4 a, a f8 e 
  d f ais4 a ais2 e8 f16 g f4 d 
  b'8 c d b c b a4 
  a gis e2 
}


baixo = \relative c {
  \partial 4 d4 
  d c f c 
  c8 d e4 a, e' 
  a g f b,8 cis 
  d4 a d d 
  d c f c 
  c8 d e4 a, e' 
  a g f b,8 cis 
  d4 a d d8 c 
  b a g4 c b8 a 
  e'4 e, a a'8 g 
  fis4 g c, f8 e 
  d4 e a, e' 
  a d,8 e f4 e8 d 
  cis4 d a d8 c 
  ais a g4 f ais8 a 
  g4 a d, fis' 
  g8 a b g c,4 f 
  e8 d e4 a,2 
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