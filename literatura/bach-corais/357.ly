
\version "2.10.33"

\header {
  title = "357 - Warum sollt ich mich denn grämen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  g''4 g a g 
  a8 b c4 c b 
  c2 d4 e 
  c2 b8 c d4 
  a2 d4 d 
  c b a a8. g16 
  g2 c4 c 
  b c a d 
  d cis d2 
  d4 e c2 
  b8 c d4 a2 
  d4 d c b8 a 
  a4 a8. g16 g2 
}


alto = \relative c {
  e'8 f g e4 d g8 
  f4 g g2 
  g g8 f e4 
  e2 e4 d 
  d2 d4 e 
  e8 d4 g8 g4 fis 
  d2 g8 fis g a 
  g4 g2 f4 
  e2 fis 
  g4 g f2 
  d8 e d e fis2 
  fis4 g8 fis e fis g4 
  g fis d2 
}


tenor = \relative c {
  c'4 c c b8 c 
  f4 e d8 e f g16 f 
  e2 b4 b 
  a2 g4 g 
  fis2 fis4 g4. a8 b d e4 a,16 b c8 
  b2 g4 e' 
  d c c a 
  ais a a2 
  b4 ais8 c16 ais a2 
  g4 g d'2 
  d8 c b4 c d 
  d a16 b c8 b2 
}


baixo = \relative c {
  c8 d e c f4. e8 
  d4 e8 f g2 
  c, g'4 gis 
  a2 e4 b8 c 
  d2 b4 e4. fis8 g b, c a d4 
  g,2 e'8 d e fis 
  g f e c f e f d 
  g e a a, d2 
  g4 c, f2 
  f8 e b c d2 
  b4 e a, b8 c 
  d2 g, 
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