
\version "2.10.33"

\header {
  title = "190 - Herr, nun laß in Frieden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  e'4 e fis gis 
  a2 gis 
  gis4 gis a b 
  c2 b 
  c4 c b b 
  a2 gis 
  a4 a g g 
  f2 e 
  e'4 e d d 
  c2 b 
  a4 a g g 
  f2 e 
}


alto = \relative c {
  b'4 c d d 
  e d e2 
  e4 e e8 fis gis4 
  a2 a4 gis 
  g8 fis g a g4 f 
  e fis e2 
  c4 f8 e d c d e 
  d2 c 
  g'4 g g g8 f 
  e2 e 
  c4 f f e2 d8 c b2 
}


tenor = \relative c {
  g'4 a8 gis a4 b 
  c b8 a b2 
  b4 b c d 
  e2 e 
  e4. d8 d4 d4. c4 b8 b2 
  a8 g f4 g d8 a' 
  a4 g g2 
  c4 c2 b a gis4 
  a8 b c4 c c8 ais 
  a c b a gis2 
}


baixo = \relative c {
  e8 d c4. d8 c b 
  a g f4 e2 
  d'8 f e d c d c b 
  a b c d e2 
  e8 d e fis g fis g gis 
  a4 dis, e2 
  f8 e d c b a b cis 
  d c b g c2 
  c8 d e f g a b g 
  a, b c d e2 
  f,8 g a b c d e c 
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