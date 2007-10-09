
\version "2.10.33"

\header {
  title = "322 - Wenn mein Stündlein vorhanden ist 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  d e fis g 
  a b g b8 c 
  d4 d b8 c d4 
  c2 b4 b 
  c b a g8 a 
  b4 b8 a g4 b8 c 
  d4 d b d 
  c2 b4 b 
  c b a g8 a 
  b4 b g a 
  b b e, fis 
  g8 fis e4 d d 
  g a b a8 b 
  c4 b a2 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  d c c d 
  d d e d 
  d8 e fis4 g f 
  e fis d d 
  d4. e8 fis4 g8 fis 
  e4 dis e e 
  d a' g b2 a4 g g 
  g g fis8 e d4 
  d d e e8 fis4 e16 fis g8 fis e4. d8 
  d4 d8 cis a4 d 
  d d g g 
  fis8 a4 g8 g4 fis 
  d1 
}


tenor = \relative c {
  \partial 4 b'8 a 
  g4 g a b 
  c b c b 
  a a g8 a b2 a4 g b 
  a b b b 
  b b b g 
  a8 b c d d e f4 
  e fis d d 
  c d d d8 c 
  b a g4 c c 
  b b4. a8 a b16 c 
  b8 a g4 fis fis8 a 
  b4 a g e'8 d 
  c d d4 e d8 c 
  b1 
}


baixo = \relative c {
  \partial 4 g8 a 
  b4 ais a g 
  fis g c g' 
  fis8 e d4 e b 
  c d g, g' 
  fis g dis e8 fis 
  g a b4 e, e 
  f fis g gis 
  a d, g g8 fis 
  e4 d c b8 a 
  g a b4 c a' 
  g8 fis e d cis4 d 
  g, a d d8 c 
  b a g fis e d' c b 
  a fis g b c a d d, 
  g1 
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