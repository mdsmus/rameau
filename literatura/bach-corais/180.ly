
\version "2.10.33"

\header {
  title = "180 - Als Jesus Christus in der Nacht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  c a ais a 
  g g f a 
  b c d c 
  b2 a4 e 
  f f g g 
  a a f d 
  e f g f 
  e2 d 
}


alto = \relative c {
  \partial 4 f'4 
  g g8 f f e f4 
  f f8 e c4 a' 
  a8 gis a4 a8 gis a4 
  a gis e cis 
  d d d8 b cis d 
  e d e cis d4 a8 b 
  c4 c cis d 
  d cis a2 
}


tenor = \relative c {
  \partial 4 d'4 
  c c ais c 
  d c8. ais16 a4 c 
  f e d e 
  f e8 d cis4 a 
  a a g ais 
  a a a f 
  g a8 f ais g a4 
  a8 e a g fis2 
}


baixo = \relative c {
  \partial 4 d4 
  e f g a 
  ais c f, f8 e 
  d4 c b a 
  d e a, a 
  d,8 d'4 c8 b e4 d8 
  cis b cis a d4 d 
  c8 ais a4 e f8 g 
  a2 d 
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