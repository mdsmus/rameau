
\version "2.10.33"

\header {
  title = "88 - Helft mir Gotts Güte preisen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a b c d 
  b4. c8 d4 e 
  c a b b 
  a2. a4 
  a b c d 
  b4. c8 d4 e 
  c a b b 
  a2. e'4 
  d c b a 
  b2. b4 
  c d e c 
  d4. c8 b4 b 
  c d e c 
  d4. c8 b4 e 
  c8 b a4 b b 
  a2. 
}


alto = \relative c {
  \partial 4 e'4 
  e e e d 
  d g8 fis g4 e 
  e a a gis 
  e2. e4 
  e e e d 
  d g8 fis g4 e 
  e a2 gis4 
  e2. a4 
  a8 gis a4 a8 gis a a, 
  e'2. gis4 
  a g g a 
  a g8 fis g4 g 
  g f e a 
  a8 g fis e d4 e 
  e a a gis 
  e2. 
}


tenor = \relative c {
  \partial 4 c'4 
  c b a a 
  g8 fis g a b4 b 
  a8 b c4 f e8 d 
  c2. c4 
  c b a a 
  g8 fis g a b4 b 
  a8 b c4 f e8 d 
  c2. c4 
  d e f8 e e d 
  gis,2. e'4 
  e d c8 d e4 
  a, d d d 
  g, a8 b c d e4 
  d a b b 
  a8 b c4 f e8 d 
  cis2. 
}


baixo = \relative c {
  \partial 4 a4 
  a' gis a fis 
  g2 g,4 gis' 
  a8 g f e d4 e 
  a2. a,4 
  a' gis a fis 
  g2 g,4 gis' 
  a8 g f e d4 e 
  a2. a,4 
  b c d8 e f4 
  e2. e4 
  a b c8 b a g 
  fis e d4 g f 
  e d c b8 a 
  b c d4 g, gis' 
  a8 g f e d4 e 
  a,2. 
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