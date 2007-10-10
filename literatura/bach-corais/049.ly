
\version "2.10.33"

\header {
  title = "49 - Mit Fried und Freud ich fahr dahin"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 d'4 
  a' a g d' 
  c b a c 
  b a b2 
  a2. b4 
  c b c a 
  g8 f e4 d a' 
  a g f8 e d4 
  c2 a'4 f 
  c' a g8 f g4 
  a g f8 e d4 
  c f e8 d4 cis8 
  d1 
}


alto = \relative c {
  \partial 4 a'4 
  d f e fis8 gis 
  a4. gis8 e4 a4. gis8 a4 f e8 d 
  c2. g'4 
  g g g f 
  e8 d cis4 a e'8 d 
  e dis e f a,4 ais 
  a2 e'4 d 
  c8 g'4 f8 e d cis d 
  e4 e d8 c b4 
  a8 b cis d e f g2 fis8 e fis2 
}


tenor = \relative c {
  \partial 4 f8 g 
  a4 d8 c b4 a8 b 
  c d16 e f8 e c4 e 
  f8 e16 d c b a4 d16 b gis4 
  a2. d4 
  e d c4. d8 
  cis d a g f4 a 
  g8 f4 e8 f2 
  f a4 a 
  g c8 d e f e d 
  cis4 a a8 g f4 
  e a2. 
  ais4 a8 g a2 
}


baixo = \relative c {
  \partial 4 d8 e 
  f e f d e d c b 
  a c d e a,4 a' 
  d,8 e f e d b e4 
  a,2. g'8 f 
  e f g f e c f d 
  ais' g a4 d, cis8 b 
  cis a b cis d c d e 
  f2 cis4 d 
  e f g8 a ais4 
  a cis, d gis, 
  a4. b8 cis d a4 
  d,1 
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