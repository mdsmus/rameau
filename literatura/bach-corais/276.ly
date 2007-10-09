
\version "2.10.33"

\header {
  title = "276 - Kommt her, ihr lieben Schwesterlein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  d' d d d 
  e d8 c b4 a 
  b8 cis d4 d cis 
  d2. d4 
  d d d8 c b c 
  d c b4 a d 
  c b a a 
  g8 a b c d4 d 
  c b a a 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  d8 e fis4 g g8 f 
  e g fis4 g a 
  g fis e e 
  d2. fis4 
  g fis g8 a b a 
  g4 g8 fis16 e fis4 fis 
  g g8 fis e4 fis 
  g fis f e 
  e8 fis g fis e4 fis 
  d1 
}


tenor = \relative c {
  \partial 4 b'4 
  a a8 b16 c b8 a g4 
  g d' d d 
  g, d'8 cis b e a g 
  fis2. d8 c 
  b c d c b c d4 
  d e a, b8 a 
  g a b d e4 d 
  d c b b 
  c8 d e4 e8 c a b16 c 
  b1 
}


baixo = \relative c {
  \partial 4 g'4 
  fis d g8 a b g 
  c4 d g, fis 
  e b'8 a g4 a 
  d,2. d4 
  g8 a b a g4. a8 
  b4 c d b 
  e,4. d8 c a d c' 
  b4 a gis gis, 
  a e'8 d c a d4 
  g,1 
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