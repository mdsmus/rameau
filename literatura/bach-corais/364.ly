
\version "2.10.33"

\header {
  title = "364 - Von Gott will ich nicht lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 fis'4 
  b cis d e 
  cis4. b8 a4 a 
  b b cis8 b cis4 
  fis,2. fis4 
  b cis d e 
  cis4. b8 a4 a 
  b b cis8 b cis4 
  fis,2. fis'4 
  e d d cis 
  d2. cis4 
  d e fis fis 
  e4. d8 cis4 cis8 d16 e 
  d4 cis8. b16 b4 b8 cis16 d 
  cis4. b8 a4 g 
  fis b b8 cis ais4 
  b1 
}


alto = \relative c {
  \partial 4 cis'4 
  fis e d8 fis b gis 
  gis fis f16 dis f8 fis4 fis 
  fis e8 d e4 e8 fis16 e 
  d2. cis4 
  fis e d8 fis b gis 
  gis fis f16 dis f8 fis4 fis 
  fis e8 d e4 e8 fis16 e 
  d2. b'4 
  b b a a 
  a2. a4 
  a a a4. gis8 
  a fis gis4 e fis 
  fis fis g8 fis g4 
  gis8 fis f4 fis fis8 e 
  d e fis g fis g16 fis e8 fis16 e 
  dis1 
}


tenor = \relative c {
  \partial 4 ais'4 
  b4. ais8 b4. b8 
  b a gis cis cis4 cis 
  b8 a g2 fis4 
  fis2. ais4 
  b4. ais8 b4. b8 
  b a gis cis cis4 cis 
  b8 a g2 fis4 
  fis2. d'4 
  e8 fis g4 fis8 e16 d e8 fis16 g 
  fis2. e4 
  fis e d8 a d4 
  cis b16 a b8 a4 cis 
  cis8 b cis dis e d e b 
  gis a16 b cis4 cis d8 a 
  a4 d8 cis d e16 d cis8 fis, 
  fis1 
}


baixo = \relative c {
  \partial 4 fis8 e 
  d4 cis b8 a gis e' 
  a, b cis4 fis, fis'8 e 
  d fis g4 ais, ais 
  b2. fis'8 e 
  d4 cis b8 a gis e' 
  a, b cis4 fis, fis'8 e 
  d fis g4 ais, ais 
  b2. b8 a 
  g g' fis e a4 a, 
  d2. a'8 g 
  fis e d cis d e16 fis b,4 
  cis8 d e4 a, ais 
  b8 b'4 a8 g a16 b e,4 
  f8 fis16 gis cis,4 fis b,8 cis 
  d cis d e fis e fis4 
  b,1 
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