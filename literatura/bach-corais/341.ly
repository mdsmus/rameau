
\version "2.10.33"

\header {
  title = "341 - Ich dank dir, lieber Herre"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  a a a b 
  g fis e b' 
  cis b a gis8 fis 
  gis4 fis e e 
  a a a b 
  gis fis e b' 
  cis b a gis8 fis 
  gis4 fis e e' 
  d cis b a 
  a8 b cis4 b cis 
  d cis b ais 
  b2. e,4 
  a b cis d 
  e d8 cis b4 d 
  cis b e4. d8 
  cis b a b cis4 b 
  a2. 
}


alto = \relative c {
  \partial 4 cis'8 d 
  e4 e fis fis 
  e dis b gis' 
  a gis cis,8 dis e2 dis4 b b 
  cis8 d e4 dis8 e fis4 
  b,8 e4 dis8 e4 e 
  e e e4. dis8 
  cis4 dis b gis' 
  fis e8 fis gis4 a8 g 
  fis gis a4 gis ais 
  b ais b fis 
  fis2. e4 
  cis e e fis 
  e fis gis fis 
  e e8 fis gis4 a 
  e8*5 d8 d cis 
  cis2. 
}


tenor = \relative c {
  \partial 4 a'4 
  a8 b cis4 d8 cis b4 
  b a16 gis a8 gis4 e' 
  e e8 dis cis b16 a b8 cis 
  b4 a16 gis a8 gis4 gis 
  a8 g fis e fis4 fis 
  gis8. a16 b8 a gis4 b 
  a b cis b8 dis 
  e4 b gis cis 
  a8 b cis d e4 e 
  d cis8 d e4 e 
  fis e fis8 e16 d cis4 
  d2. gis,4 
  fis gis a a8 b 
  cis4 b8 a e'4 a,8 b 
  cis d e4 b a2 a gis4 
  e2. 
}


baixo = \relative c {
  \partial 4 fis4 
  cis a d dis 
  e b e e 
  a, e' fis gis8 a 
  b4 b, e d 
  cis c b8 cis dis4 
  e b e gis 
  a gis cis,8 dis e4 
  a, b e cis 
  fis8 gis a4 e8 d cis4 
  d a e' cis 
  b cis d8 e fis4 
  b,2. cis4 
  fis e a fis 
  cis d e fis8 gis 
  a4 gis8 fis e d cis b 
  a b cis d e4 e 
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