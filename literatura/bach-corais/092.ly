
\version "2.10.33"

\header {
  title = "92 - Wenn mein Stündlein vorhanden ist 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b ais b cis 
  d cis b b 
  cis cis fis e 
  d2 cis4 b 
  b ais b cis 
  d cis b b 
  cis cis fis e 
  d2 cis4 fis 
  e d cis e 
  d cis b d 
  cis b a8 gis fis gis 
  a4 b cis cis 
  d e fis4. e8 
  d4 e8 d cis2 
  b1 
}


alto = \relative c {
  \partial 4 fis'4 
  e8 fis g4 fis g 
  fis fis8 e d4 e 
  e8 fis g4 fis cis' 
  cis8 ais b4 ais fis 
  e8 fis g4 fis g 
  fis fis8 e d4 e 
  e8 fis g4 fis cis' 
  cis8 ais b4 ais a 
  a8 gis a b a4 g8 fis 
  fis4 fis fis fis8 gis 
  a4 gis fis cis 
  fis gis a a8 g 
  fis b a g fis2. e8 fis g4 fis8 e 
  dis1 
}


tenor = \relative c {
  \partial 4 d'4 
  cis8 d e4 d8 cis b ais 
  b cis ais4 b gis 
  a e' d8 e fis4 
  fis4. f8 fis4 d 
  cis8 d e4 d8 cis b ais 
  b cis ais4 b gis 
  a e' d8 e fis4 
  fis4. f8 fis4 fis 
  b, fis'8 e e d cis4 
  cis8 b b ais d4 b 
  e d8 cis cis b a gis 
  fis a d4 e e 
  d8 g fis e d4 cis4. fis,8 b2 ais4 
  fis1 
}


baixo = \relative c {
  \partial 4 b'4 
  cis cis, d e 
  fis8 e fis4 b, e 
  a, a' d8 cis b ais 
  b4 b, fis' b 
  cis cis, d e 
  fis8 e fis4 b, e 
  a, a' d8 cis b ais 
  b4 b, fis' d 
  e fis8 gis a4 ais 
  b fis b, b' 
  a8 gis fis f fis4. e8 
  d cis b4 a a' 
  b cis d8 cis b ais 
  b a g fis e4 fis 
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