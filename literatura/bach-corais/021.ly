
\version "2.10.33"

\header {
  title = "21 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  a g f e 
  d2 e4 b' 
  c c b b 
  a2. e4 
  a g f e 
  d2 e4 b' 
  c c b b 
  a2. c4 
  b g a b 
  c2 c4 g 
  a g a f 
  e2. c'4 
  b8 c d4 c b 
  a2 b4 e, 
  f e d g 
  e1 
}


alto = \relative c {
  \partial 4 b'4 
  e e d cis 
  d2 cis4 e 
  dis e fis e8 d 
  c2. b4 
  e e d cis 
  d2 cis4 e 
  dis e fis e8 d 
  c2. e8 fis 
  g4 d e f 
  g f e g 
  f e8 d e4 d 
  cis2. d4 
  d g4. fis8 g4 
  g fis g g 
  d c c b8 c 
  d4 c b2 
}


tenor = \relative c {
  \partial 4 gis'4 
  a ais a g 
  a8 g16 f g8 d a'4 b 
  a a a gis 
  a2. gis4 
  a ais a g 
  a8 g16 f g8 d a'4 b 
  a a a gis 
  a2. a4 
  d b c d 
  c8 ais a4 g c 
  c cis8 d a4 a 
  a2. a4 
  g8 a b4 c d 
  e d d c8 b 
  a4 g a g8 a 
  b4 a gis2 
}


baixo = \relative c {
  \partial 4 d4 
  c cis d e 
  f ais, a g' 
  fis e dis e 
  a,2. d4 
  c cis d e 
  f ais, a g' 
  fis e dis e 
  a,2. a'4 
  g f e d 
  e f c e 
  f ais cis, d 
  a2. fis'4 
  g g, a b 
  c d g, c 
  d e fis g 
  gis a e2 
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