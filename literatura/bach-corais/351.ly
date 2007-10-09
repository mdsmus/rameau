
\version "2.10.33"

\header {
  title = "351 - Wenn mein Stündlein vorhanden ist 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  e fis gis a 
  b cis a cis8 d 
  e4 e cis8 d e4 
  d2 cis4 cis 
  d cis b a8 b 
  cis4 cis a cis8 d 
  e4 e cis8 d e4 
  d2 cis4 cis 
  d cis b a8 b 
  cis4 cis a b 
  cis cis fis, gis 
  a8 gis fis4 e e 
  a b cis4. b16 cis 
  d4 cis b2 
  a1 
}


alto = \relative c {
  \partial 4 cis'8 d 
  e4 b b a 
  e' e d e 
  e e e fis 
  fis8 f fis gis a4 a 
  b a gis fis 
  fis4. f8 cis4 fis 
  e8 fis gis4 a4. a8 
  a gis16 fis gis4 a a 
  a8 gis a4 e4. fis16 gis 
  a4 g fis e 
  e8 gis fis e dis4 e 
  fis8 e4 dis8 e4 b 
  e e e8 d16 e fis4. gis8 a4. gis16 fis gis4 
  e1 
}


tenor = \relative c {
  \partial 4 e4 
  a gis8 fis cis'4 cis 
  b a8 g fis4 a 
  gis8 a b4 a8 b cis4 
  b8 cis d e fis4 e 
  fis8 e4 d cis8 cis b 
  a4 gis fis a 
  b8 a b e e4. e8 
  fis d b e e4 e 
  fis8 b, cis d e4. d8 
  e4 e d b 
  a8 gis a cis b4 b 
  b cis8 fis, gis4 gis8 a16 b 
  e,4 b' a4. gis16 a 
  b8 b cis d16 e fis8 d b e 
  cis1 
}


baixo = \relative c {
  \partial 4 a8 b 
  cis4 dis f fis 
  gis a d, a'8 b 
  cis b a gis a4 ais 
  b b, fis' a4. gis4 fis f8 fis d 
  a b cis4 fis, fis' 
  gis8 fis e4 a cis, 
  b e a, a'8*7 gis8 cis b 
  a a,4 b16 cis d4 gis, 
  a8 e' a4. gis8 fis e 
  dis e a b e,4 e8 d 
  cis b a gis a b16 cis d4. cis16 b fis'8 e d b e4 
  a,1 
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