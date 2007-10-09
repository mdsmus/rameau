
\version "2.10.33"

\header {
  title = "324 - Jesu, meine Freude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  b''4 b a g 
  fis2 e 
  b'4 cis d b 
  e2 dis 
  e4 g fis fis 
  e1 
  b4 b a g 
  fis2 e 
  b'4 cis d b 
  e2 dis 
  e4 g fis fis 
  e1 
  b4 b c b 
  a a g2 
  b4 cis d b 
  e d8 cis cis2 
  b b4 b 
  a g fis2 
  e1 
}


alto = \relative c {
  g''4 fis e8 dis e4 
  e dis b2 
  g'8 fis e4 fis d 
  g a b2 
  b4 b c b8 a 
  g1 
  g4 fis e8 dis e4 
  e dis b2 
  g'8 fis e4 fis d 
  g a b2 
  b4 b c b8 a 
  g1 
  g4 fis e d8 g 
  g4 fis d2 
  d4 g fis fis 
  g fis fis4. e8 
  dis2 e4 e8 dis 
  e fis g e e4 dis 
  b1 
}


tenor = \relative c {
  e'4 b c c8 b 
  c4 b8 a g2 
  e'8 d cis b a4 g8 a 
  b4 e fis2 
  b,4 e e dis 
  b1 
  e4 b c c8 b 
  c4 b8 a g2 
  e'8 d cis b a4 g8 a 
  b4 e fis2 
  b,4 e e dis 
  b1 
  e4 b8 a g a b4 
  e d8 c b2 
  b4 b ais b 
  ais b b ais 
  fis2 g8 a b4 
  c b cis b8 a 
  gis1 
}


baixo = \relative c {
  e4 d c8 b a g 
  a4 b e,2 
  e'4 a8 g fis4 g8 fis 
  e g c4 b2 
  g8 fis e4 a b 
  e,1 
  e4 d c8 b a g 
  a4 b e,2 
  e'4 a8 g fis4 g8 fis 
  e g c4 b2 
  g8 fis e4 a b 
  e,1 
  e4 dis e8 fis g4 
  cis, d g,2 
  g'4 fis8 e fis4 e8 d 
  cis4 d8 e fis2 
  b, e8 fis g e 
  c d e c ais4 b 
  e,1 
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