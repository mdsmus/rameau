
\version "2.10.33"

\header {
  title = "102 - Ermuntre dich, mein schwacher Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \major
}

soprano = \relative c {
  g''4 g a b4. c8 d4 d d 
  cis d2 b4 
  c2 b4 a2. g4 fis2 g2. 
  g4 g a b4. c8 d4 d d 
  cis d2 b4 
  c2 b4 a2. g4 fis2 g2. 
  a4 a b c2 c4 b4. a8 
  b4 a2. 
  b4 b b c4. d8 e4 e dis 
  dis e2 fis4 
  g2 b,4 c2 b4 a a 
  d e4. d8 c4 
  b a2 g2. 
}


alto = \relative c {
  d'4 e fis g2. g4 e 
  e fis2 g4 
  e2 d4 d2. b4 d2 d2. 
  d4 e fis g2. g4 e 
  e fis2 g4 
  e2 d4 d2. b4 d2 d2. 
  d4 d d c2 e4 e2 
  e4 e2. 
  e4 gis gis a2. a4 fis 
  fis g2 a4 
  b2 g4 g2 g4 fis fis 
  g g4. fis8 e4 
  d d2 d2. 
}


tenor = \relative c {
  b'4 b d d4. c8 b4 b a 
  a a2 g4 
  g2 g4 fis2. e4 a2 b2. 
  b4 b d d4. c8 b4 b a 
  a a2 g4 
  g2 g4 fis2. e4 a2 b2. 
  fis4 fis gis a2 a4 gis4. a8 
  gis4 a2. 
  gis4 b e e4. d8 c4 c b 
  b b2 d4 
  d2 d4 e2 d4 d d 
  d c4. a8 g4 
  g g fis b2. 
}


baixo = \relative c {
  g'4 e d g4. a8 b4 g a 
  a, d2 g4 
  c,2 g4 d'2. e4 d2 g,2. 
  g'4 e d g4. a8 b4 g a 
  a, d2 g4 
  c,2 g4 d'2. e4 d2 g,2. 
  d'4 d b a2 c4 e2 
  e4 a,2. 
  e'4 e e a4. b8 c4 a b 
  b e,2 d4 
  g2 g4 c,2 g4 d' d 
  b c4. d8 e4 
  g d2 g,2. 
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