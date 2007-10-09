
\version "2.10.33"

\header {
  title = "35 - Gott cis Himmels und der Erden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  a''4 b cis8 d e4 
  a, gis fis e 
  fis gis a b 
  cis8 d b4 a2 
  a4 b cis8 d e4 
  a, gis fis e 
  fis gis a b 
  cis8 d b4 a2 
  cis4 cis b cis 
  d cis8 b b a b4 
  fis gis a b 
  cis8 d b4 a8 gis a4 
}


alto = \relative c {
  e'4 e a4. gis4 fis e dis8 b4 
  d8 cis b4 e e 
  e8 fis e4 e2 
  e4 e a4. gis4 fis e dis8 b4 
  d8 cis b4 e e 
  e8 fis e4 e2 
  a4 a e8 fis gis4 
  fis e8 fis gis fis gis4 
  cis,8 d e4. d16 cis fis4 
  e e e8 d e4 
}


tenor = \relative c {
  cis'4 b a8 b cis d 
  e b b4 b8. a16 gis4 
  b8 cis d e a,4 e 
  a4. gis8 cis2 
  cis4 b a8 b cis d 
  e b b4 b8. a16 gis4 
  b8 cis d e a,4 e 
  a4. gis8 cis2 
  e4. dis8 e d cis b 
  a b cis dis e4 e 
  ais,8 b4. a4 a4. b8 gis d' cis b cis4 
}


baixo = \relative c {
  a'4 gis fis cis8 b 
  cis dis e4 b e 
  b b'8 cis16 d cis8 b a gis 
  a d, e4 a,2 
  a'4 gis fis cis8 b 
  cis dis e4 b e 
  b b'8 cis16 d cis8 b a gis 
  a d, e4 a,2 
  a'8 gis fis4 gis8 fis e4 
  fis8 gis a4 e e 
  e8 d cis b cis fis e d 
  e4 e, a a 
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