
\version "2.10.33"

\header {
  title = "325 - Mit Fried und Freud ich fahr dahin"
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
  a c b8 a b4 
  a2. b4 
  c b c a 
  g f g e 
  d2 a'4. g8 
  f e d4 c2 
  a'4 f c' a 
  g8 f g4 a g 
  f e8 d cis4 f 
  e8 f e4 d2 
}


alto = \relative c {
  \partial 4 a'4 
  e' f e d8 e 
  e fis gis4 e g 
  f f b,8 c d4 
  cis2. d4 
  e f g f 
  e f8 e d4 c 
  b2 e4. cis8 
  d c ais4 a2 
  e'4 f g f 
  e8 d cis d cis4 cis 
  d8 c ais4 a d 
  e8 f cis4 a2 
}


tenor = \relative c {
  \partial 4 f4 
  a d b a8 b 
  c d e d c4 c4. b8 a4 gis8 a4 gis8 
  a2. f4 
  g d' c c 
  ais c g g 
  g2 a4 a 
  a8 g f4 f2 
  a4 a g c 
  ais8 a g4 e a 
  a g8 f e4 a 
  a4. g8 fis2 
}


baixo = \relative c {
  \partial 4 d4 
  cis d e fis8 gis 
  a4 e a, e' 
  f e8 d e2 
  a,2. d4 
  c d e f 
  g a b c 
  g2 cis,4. a8 
  d4. e8 f2 
  cis4 d e f 
  g8 a ais4 a a, 
  d g, g'8 f e d 
  cis d a4 d2 
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