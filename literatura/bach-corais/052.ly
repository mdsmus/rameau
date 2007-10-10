
\version "2.10.33"

\header {
  title = "52 - Wenn mein Stündlein vorhanden ist 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  e fis gis a 
  b cis8 b a4 cis8 d 
  e4 e8 d cis d e4 
  d2 cis4 cis 
  d cis b a8 b 
  cis4 cis a cis8 d 
  e4 e cis8 d e4 
  d2 cis4 cis 
  d cis b a8 b 
  cis4 cis a b 
  cis cis fis, gis 
  a8 gis fis4 e e 
  a b cis b8 cis 
  d4 cis b2 
  a1 
}


alto = \relative c {
  \partial 4 e'4 
  e4. dis8 e4 e8 fis 
  gis fis gis4 fis a 
  b8 a gis fis e4 e 
  fis e e e 
  b' e, e8 d cis b 
  a a' g fis16 g fis4 a 
  gis8 a b4 a8 b cis4. b16 ais b4 ais gis 
  fis4. e8 d4 cis 
  cis cis cis e 
  e fis fis8 dis e2 dis4 b cis 
  cis8 d4 e8 e fis gis a 
  a2. gis4 
  e1 
}


tenor = \relative c {
  \partial 4 cis'4 
  b a b cis 
  d cis cis fis 
  e b b a 
  a gis a a 
  a8 gis a4 gis8 gis' fis e 
  e4 e d e 
  e e e8 d cis fis 
  fis4. f8 fis4 cis8 b 
  a b cis4 fis,8 gis a4 
  gis gis fis gis 
  a a b4. b8 
  a16 b cis4 b16 a gis4 gis 
  fis8 fis'4 e16 d cis8 b16 cis d8 e 
  a, fis'4 fis8 b, cis16 d e8 d 
  cis1 
}


baixo = \relative c {
  \partial 4 a'4 
  gis fis e8 d cis4 
  b f fis fis' 
  gis8 fis e4 a cis, 
  b e a, a 
  b cis8 d e4 fis8 gis 
  a4 a, d a'8 b 
  cis4 gis a ais 
  b b, fis' f 
  fis8 gis a4 d,8 e fis4. f16 dis f8 cis fis4 e 
  a8 gis fis e dis b e dis 
  cis a b4 e cis 
  fis gis a4. gis8 
  fis4 e8 d e4 e, 
  a1 
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