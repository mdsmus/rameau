
\version "2.10.33"

\header {
  title = "33 - Herr, ich habe mißgehandelt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  a''4 e8 fis gis4 a 
  b8 c16 d c8 b b4 a 
  c b a b 
  c d e2 
  a,4 e8 fis gis4 a 
  b8 c16 d c8 b b4 a 
  c b a b 
  c d e2 
  e4 f g c, 
  f e d c 
  d d e a, 
  d c8 b b2 
  a2. 
}


alto = \relative c {
  e'8 d c4 b a 
  e' e8 f e4 e 
  a8 g f e e a4 gis8 
  a e a b16 a gis2 
  e8 d c4 b a 
  e' e8 f e4 e 
  a8 g f e e a4 gis8 
  a e a b16 a gis2 
  a4 a g a8 g 
  a d g,4. g16 f e4 
  g8 a b4. gis8 a g 
  f e e f e4. d8 
  cis2. 
}


tenor = \relative c {
  c'8 b a4 e8 e' d c 
  b gis a4. gis8 c4 
  e d c f,8 e 
  e a4 gis16 a b2 
  c8 b a4 e8 e' d c 
  b gis a4. gis8 c4 
  e d c f,8 e 
  e a4 gis16 a b2 
  c4 d4. c8 c4 
  c8 b c4. b8 g4 
  b8 d g f e4. d8 
  c b a4 a gis 
  e2. 
}


baixo = \relative c {
  a8 b c d e4 fis 
  gis8 e a d, e e, a4 
  a8 a'4 gis8 a f d e 
  a, g f4 e2 
  a8 b c d e4 fis 
  gis8 e a d, e e, a4 
  a8 a'4 gis8 a f d e 
  a, g f4 e2 
  a8 a' g f e4 f8 e 
  d4 e8 f g g, c4 
  g'8 f e d c d c b 
  a gis a d e4 e, 
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