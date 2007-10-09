
\version "2.10.33"

\header {
  title = "34 - Erbarm dich mein, o Herre Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  g g a b 
  c b a g 
  c b c a 
  g f e e 
  g g a b 
  c b a g 
  c b c a 
  g f e e 
  a a g c 
  b a g g 
  c g a e 
  a8 g f4 e2 
  a4 a g8 f e4 
  f d c c 
  g'2 a4 b 
  c g a g 
  f4. f8 e2 
}


alto = \relative c {
  \partial 4 b'4 
  e e e f8 e 
  e a4 gis8 e4 e8 f 
  g a4 g16 f g4. f4 e d16 c b4 b 
  e e e f8 e 
  e a4 gis8 e4 e8 f 
  g a4 g16 f g4. f4 e d16 c b4 c 
  f f4. e16 d e8 fis 
  g16 d g4 fis8 d4 e 
  e4. d8 c b cis d 
  e4. d4 cis8 c4 
  c8 dis4 d8 d4 c 
  c4. b8 g4 g 
  d' e8 d c4 d 
  e8 f g e f4. e4 d8 d c b2 
}


tenor = \relative c {
  \partial 4 g'4 
  b b c d 
  c8 e f e16 d c4 b 
  e f8 e16 d c4 c 
  c8. ais16 a8 b16 a gis4 g 
  b b c d 
  c8 e f e16 d c4 b 
  e f8 e16 d c4 c 
  c8. ais16 a8 b16 a gis4 a 
  c d4. c8 g a 
  d, d' e d16 c b4 c 
  c c8 ais a4 a 
  a a a a 
  a8 c4 b16 a b4 c8 b 
  a4 g8. f16 e4 e 
  g c8 d e f g4 
  g, c c c8. ais16 
  a8 b16 c b8 a gis2 
}


baixo = \relative c {
  \partial 4 e4. f8 e d c a'4 gis8 
  a c, d e a,4 e'8 d 
  c4 d8 g e c f4 
  c d e e4. f8 e d c a'4 gis8 
  a c, d e a,4 e'8 d 
  c4 d8 g e c f4 
  c d e a8 g 
  f e d c b c b a 
  g b c d g,4 c8 b 
  a b c e, f g a b 
  cis a d d, a'4 a'8 g 
  f4 fis g a8 g 
  f d g g, c4 c 
  b c8 b a4 g8 f 
  e d e c f a c4 
  d2 e 
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