
\version "2.10.33"

\header {
  title = "79 - Heut' triumphieret Gottes Sohn"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key a \minor
}

soprano = \relative c {
  c''4 c d e2 d4 c2 
  b4 c2. 
  c4 c c d 
  c b a2 
  gis4 a2 b4 
  c2 d4 e4. f8 g4 f e 
  d e2. 
  e4 e e d2 d4 e d 
  c b2. 
  b4 b cis d 
  c b a2 
  gis4 a2 b4 
  c2 d4 e2 e4 e dis2 e2. 
}


alto = \relative c {
  e'8 f g4 g g2 f4 e d2 e2. 
  f4 g f f 
  e d e f 
  e e2 e4 
  e2 g4 g2 g4 c b 
  a gis2. 
  a4 g8 f g a b4 
  g a b2 
  a4 gis2. 
  g8 a g f e4 d 
  e f e f 
  e e2 gis4 
  a2 g4 g2 fis4 fis gis 
  a gis2. 
}


tenor = \relative c {
  c'4 c b c 
  b a g a 
  g g2. 
  a4 g a gis 
  a b c b2 c gis4 
  a8 b c4 b c2 d4 c e 
  f b,2. 
  c4 c c d8 c 
  d e f4 e2 
  e4 e2. 
  e4 e a, a2 gis4 a d 
  b c2 e4 
  e f d c2 c4 b2 
  b4 b2. 
}


baixo = \relative c {
  a'4 e g c,2 d4 e f 
  g c,2. 
  f4 e f b, 
  c d c d 
  e a,2 e'4 
  a2 g4 c2 b4 a g 
  f e2. 
  a4 e c g' 
  b a gis2 
  a4 e2. 
  e8 d e f g4 f 
  e d c d 
  e a,2 e'4 
  a2 b4 c 
  b a b2 
  b,4 e2. 
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