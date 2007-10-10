
\version "2.10.33"

\header {
  title = "242 - Wie bist du, Seele, in mir so gar betrübt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b a g2 
  fis4 g a g 
  fis fis e fis 
  g a b2 
  a4 c c b 
  a a g a 
  a a a fis 
  g a b2 
  a4 fis g a 
  b b a g8 fis 
  fis2 e 
}


alto = \relative c {
  \partial 4 e'8 dis 
  e b cis dis e dis e4 
  e8 dis e4. dis8 e4 
  e dis b dis 
  e d8 c b d g4 
  fis e d d 
  e d8 c b4 d 
  d8 cis d e fis4 d 
  d8 e fis4 g d 
  d fis b,8 e d c 
  b4 e4. dis8 e4 
  e dis b2 
}


tenor = \relative c {
  \partial 4 g'8 a 
  b e4 a,8 b2 
  b4 b a8 b16 c b4 
  cis8 fis, b a g4 b 
  b8 c b a g b d4 
  d c8 b a fis g2 fis4 g fis8 g 
  a4 a d a 
  b c d g,4. fis8 b a g4 d'4. f8 e d c4 cis 
  b4. a8 gis2 
}


baixo = \relative c {
  \partial 4 e8 fis 
  g4. fis8 e fis g e 
  b4 e fis g8 e 
  ais,4 b e, b' 
  e fis g g,8 b 
  d4 a'8 g fis d g b, 
  c a d4 g, d'8 e 
  fis g fis e d e d c 
  b c b a g a b c 
  d4 dis e fis 
  g gis a a 
  b b, e2 
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