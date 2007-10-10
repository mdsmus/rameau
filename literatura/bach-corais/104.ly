
\version "2.10.33"

\header {
  title = "104 - Wer nur den lieben Gott läßt walten"
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
  fis4 a a g 
  fis b b ais 
  b2. fis4 
  b cis d cis 
  b cis ais2 
  fis4 a a g 
  fis b b ais 
  b2. cis4 
  d e fis8 e fis g 
  e4 e d fis 
  e d cis b8 cis 
  d e cis4 b2 
}


alto = \relative c {
  \partial 4 d'8 e 
  fis4 fis fis8 g a4 
  g g fis2 
  cis4 cis8 d e4 e 
  fis8 e d4 cis8 d e4 
  d2. d8 e 
  fis4 fis fis8 g a4 
  g g fis2 
  cis4 cis8 d e4 e 
  fis8 e d4 cis8 d e4 
  d2. fis4 
  fis8 b a g fis4 b 
  b a8 g fis4 a 
  ais b e,8 dis e4 
  fis8 g fis e dis2 
}


tenor = \relative c {
  \partial 4 b'8 cis 
  d4 cis b cis8 d 
  e4 e8 d cis2 
  ais4 a a8 b cis4 
  cis b8 a g4 fis 
  fis2. b8 cis 
  d4 cis b cis8 d 
  e4 e8 d cis2 
  ais4 a a8 b cis4 
  cis b8 a g4 fis 
  fis2. ais4 
  b8 g' fis e d4 d 
  d8 b cis4 a a8 b 
  cis4 fis,8 g a fis b4 
  b ais fis2 
}


baixo = \relative c {
  \partial 4 b4 
  b' ais b fis 
  g8 fis e4 fis2 
  fis,4 fis' cis b8 a 
  d4 g8 fis e4 fis 
  b,2. b'4 
  b ais b fis 
  g8 fis e4 fis2 
  fis,4 fis' cis b8 a 
  d4 g8 fis e4 fis 
  b,2. fis'4 
  b cis d8 cis b a 
  g4 a d, d 
  cis b a g 
  fis'8 e fis4 b,2 
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