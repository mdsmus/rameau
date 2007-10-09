
\version "2.10.33"

\header {
  title = "99 - Helft mir Gotts Güte preisen"
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
  c d e e 
  d2 b4 b 
  c d e e 
  d4. c8 b4 e 
  d8 c b a b4 b 
  a2. 
}


alto = \relative c {
  \partial 4 e'4 
  f f g a 
  g2 a4 e 
  e a a gis 
  e2. e4 
  f f g a 
  g2 a4 e 
  e a a gis 
  e2. e8 fis 
  gis4 a8 g f4 e8 fis 
  gis2. gis4 
  a b c8 b a g 
  a g fis4 g g 
  g g8 f e f g4 
  f8 g a4 gis b 
  a e f e8 d 
  cis2. 
}


tenor = \relative c {
  \partial 4 c'4 
  c d g, d' 
  d e d b 
  c8 d e4 f e8 d 
  c2. c4 
  c d g, d' 
  d e d b 
  c8 d e4 f e8 d 
  c2. g8 a 
  b4 e8 c d b c4 
  b2. e4 
  e f g c,8 b 
  a4 d d d 
  g, a ais a8 g 
  a2 e'4 e 
  e, a a gis 
  e2. 
}


baixo = \relative c {
  \partial 4 a'8 g 
  f4 e8 d e4 fis 
  g fis8 e fis4 gis 
  a8 b c a d,4 e 
  a,2. a'8 g 
  f4 e8 d e4 fis 
  g fis8 e fis4 gis 
  a8 b c a d,4 e 
  a,2. c'4 
  b a gis a 
  e2. e4 
  a g8 f c'4 e, 
  fis e8 d g4 g8 f 
  e4 d cis d8 e 
  f4 e8 d e4 gis 
  a c, d e 
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