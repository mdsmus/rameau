
\version "2.10.33"

\header {
  title = "3 - Ach Gott, vom Himmel sieh' darein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  c b a e' 
  e8 d c4 b d 
  c b a b8 c16 d 
  c4 b a b 
  c b a e' 
  e8 d c4 b d 
  c b a b8 c16 d 
  c4 b a a 
  b8 a g4 fis e8 fis 
  g4 a b g 
  a8 b c4 b c8 b 
  a4 gis a a 
  e' c d e 
  d c b 
}


alto = \relative c {
  \partial 4 gis''4 
  a gis a gis8 a 
  b4 e,8 fis gis4 gis 
  a gis a8 g f4 
  e2 e4 gis 
  a gis a gis8 a 
  b4 e,8 fis gis4 gis 
  a gis a8 g f4 
  e2 e4 d 
  d8 dis e4 dis e8 dis 
  e g fis e dis4 b 
  a a' gis a 
  e e e e 
  e e f g 
  fis8 gis a4 e 
}


tenor = \relative c {
  \partial 4 e'4 
  e d e d8 c 
  b4 c8 d e4 f 
  e e8 d c4 d 
  gis,8 a4 gis8 c4 e 
  e d e d8 c 
  b4 c8 d e4 f 
  e e8 d c4 d 
  gis,8 a4 gis8 c4 a 
  g8 a b4 b b8 a 
  b4 c fis, e'8 d 
  c d e4 e e8 d 
  c4 b c c 
  b a a ais 
  a8 e fis4 gis 
}


baixo = \relative c {
  \partial 4 e4 
  a b c b8 a 
  gis4 a e b 
  c8 d e4 f e8 d 
  e2 a,4 e' 
  a b c b8 a 
  gis4 a e b 
  c8 d e4 f e8 d 
  e2 a,4 fis' 
  g8 fis e4 b'8 a g fis 
  e d c4 b e 
  f c8 d e4 a,8 b 
  c d e4 a, a' 
  gis a8 g f e d cis 
  d4 dis e 
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