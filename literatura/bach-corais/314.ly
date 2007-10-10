
\version "2.10.33"

\header {
  title = "314 - Das alte Jahr vergangen ist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b a8 g fis4 b 
  a8 g fis4 g b 
  b a8 g fis4 b 
  a8 g fis4 g b 
  cis dis e b8 cis 
  d4 cis b cis 
  d cis b b 
  a8 g fis4 g a 
  a b a8 g fis4 
  g g fis cis' 
  d cis b fis 
  b b ais2 
}


alto = \relative c {
  \partial 4 fis'4 
  g e d g 
  fis fis e gis 
  e8*5 d8 d4 
  c c8 b b4 g' 
  g fis e e 
  fis fis fis fis 
  fis fis4. d8 g fis 
  e4 d8 c b4 e 
  d d cis dis 
  e e4. d8 fis4 
  fis g fis fis 
  fis f fis2 
}


tenor = \relative c {
  \partial 4 dis'4 
  e a, a d 
  d c8 b b4 e 
  e a, a f 
  e fis e b' 
  a b b b 
  b ais8 e' d4 cis 
  c8 b4 a8 b4 b 
  c8 b a4 g g 
  fis g8 fis e4 b' 
  b b b cis 
  b ais b8 cis d cis 
  b4 cis cis2 
}


baixo = \relative c {
  \partial 4 b'8 a 
  g e cis4 d b8 g 
  d'4 dis e e8 d 
  c4 cis d gis, 
  a dis, e e' 
  a, a' gis g 
  fis8 e fis4 b, ais 
  b fis' g8 fis e d 
  c4 d g, cis 
  d g, a b 
  e,8 fis g a b4 ais 
  b e d8 cis b a 
  gis4 cis fis,2 
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