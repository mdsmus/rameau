
\version "2.10.33"

\header {
  title = "62 - Wer nur den lieben Gott läßt walten"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 fis'4 
  b cis d cis 
  b cis8 b ais4 fis 
  s4 a a g 
  fis b b ais 
  b2. fis4 
  b cis d cis 
  b cis8 b ais4 fis 
  s4 a a g 
  fis b b ais 
  b2. cis4 
  d e fis fis 
  e4. d8 d4 fis 
  e d cis b8 cis 
  d4 cis b2. 
}


alto = \relative c {
  \partial 4 d'8 e 
  fis4 fis fis fis8 e 
  d4 g fis cis 
  s4 fis fis e 
  e8 d d4 g fis 
  fis2. d8 e 
  fis4 fis fis fis8 e 
  d4 g fis cis 
  s4 fis fis e 
  e8 d d4 g fis 
  fis2. fis4 
  fis a a a 
  b a a a8 b 
  cis4 fis, g8 fis fis e 
  fis4 fis8 e dis2. 
}


tenor = \relative c {
  \partial 4 b'8 cis 
  d4 cis b ais 
  b e8 d cis4 ais 
  s4 cis d a 
  a b cis8 d e4 
  d2. b8 cis 
  d4 cis b ais 
  b e8 d cis4 ais 
  s4 cis d a 
  a b cis8 d e4 
  d2. ais4 
  b cis d d 
  d cis fis d 
  ais b b8 ais b4 
  b ais fis2. 
}


baixo = \relative c {
  \partial 4 b4 
  b' ais b fis 
  g8 fis e4 fis fis, 
  s4 fis' b, cis 
  d g8 fis e4 fis 
  b,2. b4 
  b' ais b fis 
  g8 fis e4 fis fis, 
  s4 fis' b, cis 
  d g8 fis e4 fis 
  b,2. fis'4 
  b a8 g fis e d4 
  g a d, d 
  cis b e8 fis g4 
  fis8 e fis4 b,2. 
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