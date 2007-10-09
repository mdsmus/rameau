
\version "2.10.33"

\header {
  title = "352 - Es woll uns Gott genädig sein 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 b''4 
  c b a b8 c 
  d4 e d c 
  b2 s4 d 
  c b c8 b a4 
  g f e b' 
  c b a b8 c 
  d4 e d c 
  b2 s4 d 
  c b c8 b a4 
  g f e g 
  f e d e8 d 
  c d d4 e b' 
  c b8 a g4 a8 b 
  c4 d b e 
  d8 c b c d4 a 
  g f e d 
  g a b8 c d4 
  c b a c 
  b a g8 f e f 
  g4 f e1. 
}


alto = \relative c {
  \partial 4 gis''4 
  a8 e f e4 d8 g4. f8 g e f4 e8 dis 
  e2 s4 f 
  e8 fis g4 g f 
  e4. d16 c b4 gis' 
  a8 e f e4 d8 g4. f8 g e f4 e8 dis 
  e2 s4 f 
  e8 fis g4 g f 
  e4. d16 c b4 e8 d 
  c d4 c8 a g4 gis8 
  a4. b8 c b e4 
  e8 a g f e4 d 
  c8 e a4 a8 gis g fis 
  g4 g g4. f8 
  e4. d8 d cis a b 
  c4 c b8 e d e 
  e a4 gis8 a4 g8 a 
  b g e f b, d g f 
  f e e d d e16 d c4 
  b1 
}


tenor = \relative c {
  \partial 4 e'4 
  e8 c d e a,4 g 
  a ais a8 gis a4 
  a gis s4 a8 b 
  c4 d e8 d c4 
  ais8 a4 b8 gis4 e' 
  e8 c d e a,4 g 
  a ais a8 gis a4 
  a gis s4 a8 b 
  c4 d e8 d c4 
  ais8 a4 b8 gis4 b 
  a8 g4 a8 f4 e 
  e a a8 gis gis4 
  a16 b c4 d8 e e, fis gis 
  a4. f'8 e4 g,8 a 
  b c d4 d d 
  e8 a, a4 a f 
  e4. fis8 g4 a8 b 
  c e f e c4 e 
  d cis8 d e b c4 
  d8 a a b4 e,8 a4 
  a gis8 fis gis2 
}


baixo = \relative c {
  \partial 4 e4 
  a4. g8 f4. e8 
  d4. cis8 d4 a 
  e'2 s4 d 
  a' g8 f e4 f8 e 
  d cis d4 e e 
  a4. g8 f4. e8 
  d4. cis8 d4 a 
  e'2 s4 d 
  a' g8 f e4 f8 e 
  d cis d4 e e 
  a,8 b c4. b8 c b 
  a g f4 e e' 
  a,4. b8 c4. b8 
  a a' f d e4 c 
  g' g,8 a b c d4. cis8 d4 a d 
  c8 b a4 e' fis8 gis 
  a c, d e f4 e8 fis 
  g4. f8 e d c a 
  b cis d gis, a b c d 
  e1 
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