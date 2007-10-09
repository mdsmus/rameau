
\version "2.10.33"

\header {
  title = "145 - Warum betrübst du dich, mein Herz"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a8 b c4 b e 
  d c b c8 b 
  a4 e' d e 
  a,8 b cis4 d c 
  b e e8 d c4 
  b2. a8 b 
  c4 c d d 
  e e8 d c4 e 
  d c b a8 b 
  c4 b a2 
}


alto = \relative c {
  \partial 4 e'4 
  e e e4. fis8 
  gis4 a gis a8 gis 
  a4 a a g4. f8 e4 f e 
  e e8 b' c b4 a8 
  gis2. e4 
  e f8 g a f g4 
  g g a g8 a 
  b4 a gis a 
  a8 fis gis4 e2 
}


tenor = \relative c {
  \partial 4 c'4 
  c8 b a4 gis a 
  b c8 d e4 e8 d 
  c b cis4 d8 c ais a 
  a4 a a a 
  gis a8 gis a b c d 
  e2. c8 b 
  a4 a a8 b16 c b4 
  c c c c 
  f8 e e4 d c8 f 
  e a, b d cis2 
}


baixo = \relative c {
  \partial 4 a4 
  a'8 gis a4 e8 d c4 
  b a e' a, 
  a'4. g8 f e d cis 
  d4 a d, a' 
  e'8 d c e fis gis a4 
  e2. a,4 
  a'8 g f e f d g f 
  e d c4 f c8 b 
  a gis a g f e f d 
  e2 a 
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