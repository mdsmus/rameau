
\version "2.10.33"

\header {
  title = "112 - Wer nur den lieben Gott läßt walten"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 fis'4 
  b cis d cis 
  b cis ais2 
  fis s4 a 
  a g fis b 
  b ais b fis 
  b cis d cis 
  b cis ais2 
  fis s4 a 
  a g fis b 
  b ais b cis 
  d e fis fis 
  e4. d8 d4 fis 
  e d cis b8 cis 
  d4 cis b2 
}


alto = \relative c {
  \partial 4 d'8 e 
  fis4 fis fis fis8 e 
  d4 g fis2 
  cis s4 fis 
  fis e d d 
  g fis fis d8 e 
  fis4 fis fis fis8 e 
  d4 g fis2 
  cis s4 fis 
  fis e d d 
  g fis fis ais 
  b a a b 
  b a a a 
  ais b b8 ais b4 
  b ais fis2 
}


tenor = \relative c {
  \partial 4 b'8 cis 
  d4 cis b ais 
  b e8 d cis2 
  ais s4 cis 
  d a a b 
  cis cis d b8 cis 
  d4 cis b ais 
  b e8 d cis2 
  ais s4 cis 
  d a a b 
  cis cis d fis 
  fis e d d 
  d cis fis d 
  e fis g8 fis fis e 
  fis4. e8 dis2 
}


baixo = \relative c {
  \partial 4 b4 
  b' ais b fis 
  g e fis2 
  fis, s4 fis' 
  b, cis d g8 fis 
  e4 fis b, b 
  b' ais b fis 
  g e fis2 
  fis, s4 fis' 
  b, cis d g8 fis 
  e4 fis b, fis' 
  b cis d8 cis b a 
  g4 a d, d' 
  cis b e,8 fis g4 
  fis8 e fis4 b,2 
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