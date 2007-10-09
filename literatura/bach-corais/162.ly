
\version "2.10.33"

\header {
  title = "162 - Das alte Jahr vergangen ist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a g8 f e4 a 
  g e f a 
  a g8 f e4 a 
  g e f a 
  b cis d a8 b 
  c4 b a b 
  c b a a 
  g8 f e4 f g 
  g a g8 f e4 
  f f e b' 
  c b a e 
  a a gis2 
}


alto = \relative c {
  \partial 4 e'4 
  f e8 d cis4 d 
  d8 e d cis d4 d 
  d8*5 c8 c f4 e16 d e8 cis d4 f 
  f8 e e d d4 c8 d 
  e4. d8 cis4 d 
  e d c8 d dis4 
  d e d d8 e16 f 
  e4 d8 c d4 e4. cis8 d4 cis fis 
  e8 fis gis a16 b e,4. e8 
  e4 dis e2 
}


tenor = \relative c {
  \partial 4 cis'4 
  d8 c ais g a4 a8 f 
  d ais' a4 a f 
  f8 d g4. e8 f a 
  c ais ais a a4 d 
  d a a8 gis a4 
  a gis e f 
  g8 e f g a ais c4 
  ais8 a ais a a4 g 
  c8 e, fis g16 a d,4 a' 
  a a a a 
  gis8 a b4 c8 d c b 
  c a fis b b2 
}


baixo = \relative c {
  \partial 4 a'8 g 
  f d g4. e8 f d 
  ais g a4 d d8 c 
  ais4 b c8*5 e8 cis a d4 d' 
  gis, g fis f 
  e8 d e4 a, d 
  c d8 e f4 fis 
  g cis, d b 
  c4. a8 b4 cis 
  d8 e f g a4 dis, 
  e4. d8 c b a g 
  fis4 b e2 
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