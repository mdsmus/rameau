
\version "2.10.33"

\header {
  title = "249 - Allein Gott in der Höh sei Ehr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''8 a 
  b4 c d c 
  b a b b 
  b a8 b c b a4 
  g8 e fis4 g g8 a 
  b4 c d c 
  b a b b 
  b a8 b c b a4 
  g8 e fis4 g g 
  a b c b 
  a8. b16 b4 a a 
  b c d c 
  b a b g 
  a b c8 b a4 
  g8 e fis4 g2 
}


alto = \relative c {
  \partial 4 d'4 
  g g fis e8 fis 
  g fis e4 dis e 
  d8 e fis4 g4. fis8 
  g4 d d d 
  g g fis e8 fis 
  g fis e4 dis e 
  d8 e fis4 g4. fis8 
  g4 d d d8 e 
  fis4 gis a8 a, d e 
  a, a'4 gis8 e4 d 
  d g fis8 gis a4 
  g8 fis e4 dis b8 cis 
  d e fis4 e4. d16 c 
  g'4 d d2 
}


tenor = \relative c {
  \partial 4 b'8 c 
  d4 e8 g, a b c d 
  e b c4 fis, g8 a 
  b c d4 e4. d16 c 
  d8 c16 b a4 b b8 c 
  d4 e8 g, a b c d 
  e b c4 fis, g8 a 
  b c d4 e4. d16 c 
  d8 c16 b a4 b b 
  a d e8 f4 e8 
  e16 d e8 f e16 d c4 a 
  g g8 a b4 e, 
  e'8 b c4 fis, g 
  fis b8 a g4. fis8 
  d' c16 b a4 b2 
}


baixo = \relative c {
  \partial 4 g4 
  g'8 fis e4 d a 
  e'8 d c4 b e8 fis 
  g4 fis e8 d c a 
  b c d4 g, g 
  g'8 fis e4 d a 
  e'8 d c4 b e8 fis 
  g4 fis e8 d c a 
  b c d4 g, g' 
  d8 d' c b a4 g 
  f8 c d e a,4 fis' 
  g8 fis e4 b c8 d 
  e d c4 b e 
  d dis e8 d c a 
  b c d4 g,2 
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