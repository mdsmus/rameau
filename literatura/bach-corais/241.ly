
\version "2.10.33"

\header {
  title = "241 - Was willst du dich, o meine Seele, kränken"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  d,4. e8 f4 g 
  a8 b c4 b a 
  a gis a a 
  g g c a 
  ais8 a g f g4. f8 
  f2 s4 a 
  d, e f g 
  a8 b c4 b4. a8 
  a2 s4 a 
  g g c a 
  ais8 a g f e4. d8 
  d2 s4 a' 
  g8 a f g e4. d8 
  d2 s4 a' 
  a b c c 
  b2 a4 a 
  g g c a 
  ais8 a g f g4. f8 
  f2 s4 a 
  d, e f8 g a4 
  d,2 s4 e 
  f e f g 
  a b c8 b a4 
  d c ais8 a g f 
  e4. d8 d2 
}


alto = \relative c {
  \partial 4 a'4 
  a b8 cis d f4 e8 
  f g g a g f e4 
  f e e e8 f4 e16 d e8 f g e f4 
  f e8 f4 e16 d e4 
  c2 s4 d4. a8 ais a4 d cis8 
  d4 g8 f4 d8 b e16 d 
  c2 s4 f4. e16 d e8 f g e f a 
  g f e d d cis16 b cis4 
  a2 s4 f' 
  e d4. cis16 b cis4 
  d2 s4 c 
  c8 d16 e f8 e16 d g8 f16 g a4. gis16 fis gis4 e f 
  f f8 e16 d e4 f 
  f16 e f8 e f4 e16 d e4 
  c2 s4 c 
  b cis d cis 
  d2 s4 cis 
  d cis d8 c ais c 
  c d16 e f8 e16 d e8 f16 g a8 g 
  fis g a fis d4 e8 d4 cis16 b cis4 a2 
}


tenor = \relative c {
  \partial 4 f8 g 
  a4 g a c 
  c8 d e4 d4. c8 
  b4. d8 c4 c 
  d8 g, c4 c c 
  d8 a c4 d8 ais g c16 ais 
  a2 s4 f8 g 
  a4 g f8 ais4. 
  a8 g g a4 gis16 fis g4 
  e2 s4 c' 
  d8 g, c4 c c8 f 
  d cis4 d8 ais g4 a16 g 
  f2 s4 d'8 c 
  ais a a g16 a ais8 g e a16 g 
  f2 s4 f8 g 
  a b16 c d8 b g c16 b a8 c 
  f d b e16 d cis4 d4. c16 b c4 c4. d16 c 
  ais8 c c16 ais a8 g16 a ais4 c16 ais 
  a2 s4 f 
  g4. f16 g a4. g8 
  f2 s4 a 
  a a a d8 c16 ais 
  a8 b16 c d8 b g d' c4. ais8 a d4 c8 ais b 
  e,16*5 f16 g8 fis2 
}


baixo = \relative c {
  \partial 4 d8 e 
  f g f e d4 c 
  f e8 fis g gis a c, 
  d b e4 a, a 
  b c8 d e c f dis 
  d c ais a ais g c4 
  f,2 s4 d'8 e 
  f4 cis d e 
  f8 g16 f e8 f16 e d8 b e4 
  a,2 s4 a 
  b c8 d e c f d 
  g a ais a g e a a, 
  d2 s4 d4. cis8 d ais g e a4 
  ais2 s4 f' 
  f8 e d g e a16 g f8 e 
  d b e4 a, d8 c 
  b g c ais a g f4 
  g8 a16 ais c8 d ais g c c, 
  f2 s4 f'2 e4 d a 
  ais2 s4 a 
  d8 f a g f4. e8 
  f e d g c, d16 e f8 e 
  d e fis d g4. gis8 
  a4 a, d2 
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