
\version "2.10.33"

\header {
  title = "54 - Kommt her, ihr lieben Schwesterlein"
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
  b8 cis d4 e e 
  d2 s4 d 
  d d d b8 c 
  d4 c8 b a4 d 
  c b a a 
  g8 a b c d4 d 
  c b8 a b4 a 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  d8 e fis4 g g 
  g fis g a 
  g fis e8 fis g4 
  fis2 s4 a 
  g fis g g 
  g a8 g fis4 fis 
  g8 a4 g e8 fis4 
  g2 fis4 g 
  g g g fis 
  d1 
}


tenor = \relative c {
  \partial 4 b'4 
  a d8 c b c d4 
  c8 b a d d4 d 
  g, a b cis 
  a2 s4 d8 c 
  b4 c d e 
  d e a, b 
  b8 a b c d4 c 
  b e d b 
  c8 d e4 d d8 c 
  b1 
}


baixo = \relative c {
  \partial 4 g'4 
  fis d g8 a b4 
  c, d g fis 
  e d g a 
  d,2 s4 fis 
  g a b e, 
  b c d b 
  e8 fis g4 d dis 
  e8 fis g a b4 g 
  e d8 c d4 d 
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