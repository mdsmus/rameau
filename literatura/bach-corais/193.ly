
\version "2.10.33"

\header {
  title = "193 - Was bist du doch, o Seele, so betrübet"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  r4 e'' c4. b8 
  a4 e' f e8 d 
  c4 d e e 
  r4 e c4. b8 
  a4 e' f e8 d 
  c4 d e e 
  r4 c d4. g,8 
  g2 r4 d' 
  e4. c8 c2 
  r4 e f e 
  d c b4. a8 
  gis e' d c b2 
  a2. 
}


alto = \relative c {
  r4 a'' a g 
  e a a gis 
  e a gis gis 
  r4 a a g 
  e a a gis 
  e a gis gis 
  r4 a g f2 e4 r4 g 
  g g f2 
  r4 g f8 a gis4 
  a8 d, e4 f e 
  d a'2 gis4 
  e2. 
}


tenor = \relative c {
  r4 c'8 d e4 e8. d16 
  c4 c b b 
  a8 c b a b4 b 
  r4 c8 d e4 e8. d16 
  c4 c b b 
  a8 c b a b4 b 
  r4 e d d 
  c2 r4 d 
  c c8 ais a2 
  r4 cis d4. c4 b a gis a8 
  b4 e e e8 d 
  cis2. 
}


baixo = \relative c {
  r4 a a' e 
  a, a' d, e 
  a f e e 
  r4 a, a' e 
  a, a' d, e 
  a f e e 
  r4 a, b2 
  c r4 b 
  c e f2 
  r4 e d e 
  f e d c 
  b a e' e, 
  a2. 
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