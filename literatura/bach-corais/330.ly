
\version "2.10.33"

\header {
  title = "330 - Nun danket alle Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d''4 
  d d e e 
  d2. b4 
  c b a b8 c 
  a2 g4 d' 
  d d e e 
  d2. b4 
  c b a b8 c 
  a2 g4 a 
  a a b b 
  a2. a4 
  b8 cis d4 d cis 
  d2. d4 
  e d c b 
  c2. b4 
  a b8 c a4. g8 
  g2. 
}


alto = \relative c {
  \partial 4 g''4 
  a g g g8 a 
  b2. g4 
  a d, d d 
  e16 fis g4 fis8 d4 g 
  a g g g8 a 
  b2. g4 
  a d, d d 
  e16 fis g4 fis8 d4 fis8 g 
  a g a fis d4 g 
  fis2. fis4 
  d8 e fis4 b a8 g 
  fis2. g4 
  g8 a b4. a4 gis8 
  a2. d,4 
  d4. e8 d g fis4 
  d2. 
}


tenor = \relative c {
  \partial 4 b'4 
  a8 d b4 c c 
  d2. d4 
  d4. g8 fis4 g8 g, 
  e'4 a, b b 
  a8 d b4 c c 
  d2. d4 
  d4. g8 fis4 g8 g, 
  e'4 a, b a 
  d c b8 c d4 
  d2. d8 c 
  b a a d d g e16 d e8 
  d2. b4 
  c d8 e16 f g8 c, f e 
  e2. g4 
  fis8 d b a a b c a 
  b2. 
}


baixo = \relative c {
  \partial 4 g'4 
  fis g c,8 d e c 
  g'2. g4 
  g8 fis g4 d8 c b e 
  c b16 c d4 g, g' 
  fis g c,8 d e c 
  g'2. g4 
  g8 fis g4 d8 c b e 
  c b16 c d4 g, d'8 e 
  fis e fis d g, a b c 
  d2. d4 
  g fis8 b g e a a, 
  d2. g4 
  c, g'8 f e f d e 
  a,2. b8 g 
  d' fis g c, d4 d, 
  g2. 
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