
\version "2.10.33"

\header {
  title = "156 - Herr Jesu Christ, meins Lebens Licht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  a a fis8 gis a4 
  b8 a gis4 fis fis 
  gis a b e,8 fis 
  gis a fis4 e b' 
  cis cis a8 b cis4 
  d cis b a 
  b cis b a 
  a gis a 
}


alto = \relative c {
  \partial 4 cis'8 d 
  e4 a, d cis 
  b e dis dis 
  e fis fis8 dis e4 
  e8 fis dis4 b gis' 
  a cis, fis8 gis ais4 
  b e,8 fis gis4 fis 
  e8 d cis dis e d cis4 
  fis e e 
}


tenor = \relative c {
  \partial 4 a'8 b 
  cis d e4 a, a8 gis 
  fis4 gis8 a b4 b 
  b dis gis,8 a b cis 
  b4 b8 a gis4 e' 
  e8 fis gis4 cis,8 d e4 
  fis8 gis a4 e cis 
  b e,8 fis gis4 a 
  b8 cis d4 cis 
}


baixo = \relative c {
  \partial 4 a'4 
  a,8 b cis4 d8 e fis e 
  dis4 e b b'8 a 
  gis a gis fis e fis gis a 
  b4 b, e e 
  a8 gis fis f fis e d cis 
  b4 cis8 d e4 fis 
  gis a e fis8 e 
  dis4 e a, 
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