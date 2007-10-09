
\version "2.10.33"

\header {
  title = "24 - Valet will ich dir geben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d'4 
  a' a b cis 
  d2 d4 fis 
  e d d cis 
  d2. d,4 
  a' a b cis 
  d2 d4 fis 
  e d d cis 
  d2. d8 e 
  fis4 fis e4. d8 
  cis b cis4 a cis 
  d cis b b 
  a2. a4 
  fis8 g a4 b a 
  a g8 fis fis4 a 
  g fis e e 
  d2. 
}


alto = \relative c {
  \partial 4 a'4 
  d d d g2 fis8 e fis4 a8 b 
  cis4 b b a 
  a2. a,4 
  d d d g2 fis8 e fis4 a8 b 
  cis4 b b a 
  a2. a4 
  d d8 cis b gis a b 
  e, fis gis4 fis a4. gis8 a2 gis4 
  e2. e4 
  d d d8 e fis4 
  fis e dis d 
  d d2 cis4 
  a2. 
}


tenor = \relative c {
  \partial 4 fis8 e 
  fis g a fis g4 g8 a 
  b4 a8 g a4 a' 
  g fis f e 
  fis2. fis,8 e 
  fis g a fis g4 g8 a 
  b4 a8 g a4 a' 
  g fis f e 
  fis2. fis8 g 
  a4 d, e8 d cis b 
  a4 gis cis fis8 e 
  d4 e e8 fis e d 
  cis2. a4 
  a d8 c b cis d c 
  b2 b4 c 
  b b b a8 g 
  fis2. 
}


baixo = \relative c {
  \partial 4 d8 cis 
  d e fis d g fis e4 
  b8 cis d4 d, d'' 
  ais b8 a gis4 a 
  d,2. d8 cis 
  d e fis d g fis e4 
  b8 cis d4 d, d'' 
  ais b8 a gis4 a 
  d,2. d4 
  d'8 cis b a gis e fis gis 
  a gis fis f fis4 fis 
  b8 b, cis d e d e e, 
  a2. cis4 
  d8 e fis d g4 fis8 e 
  dis4 e b fis 
  g8 a b a g e a4 
  d,2. 
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