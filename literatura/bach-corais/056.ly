
\version "2.10.33"

\header {
  title = "56 - Christum wir sollen loben schon"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 e'8 fis 
  g4 g a b2 e,4 a g 
  fis2. a4 
  b8 cis d2 cis4 
  b a b8 cis d4 
  d2. a4 
  b8 cis d2 cis4 
  b a b8 cis d2 a8 g fis g a4 
  b2. e,8 fis 
  g4 g8 a b c d2 b4 a8 g fis g 
  a4 g fis2*7 
}


alto = \relative c {
  \partial 4 b'4 
  e e e fis2 e4 dis e 
  dis2. d4 
  g fis8 g a4 e8 fis 
  g4 fis8 e d4 g 
  fis2. fis8 e 
  d e fis2 fis8 e 
  d e fis4 g d8 e 
  fis2. e4 
  fis2. e8 dis 
  e fis g4 fis8 e d c 
  b c d e fis4. e8 
  dis4 e2 d8 cis 
  d e fis2 gis8 ais 
  b4*5 ais8 gis ais2 
}


tenor = \relative c {
  \partial 4 g'8 a 
  b4 b a2 
  g8 a b4 a b 
  b2. a4 
  e' a,4. b8 cis d 
  e d cis4 b b 
  a2. d8 e 
  fis4 b,2 a4 
  b8 cis d4 g,8 a b4. cis8 d4 cis8 dis e4 
  dis2. b4 
  b b8 c d e fis4 
  g g, d'8 e fis2 e8 d cis4 fis, 
  b8 fis b4. ais8 b cis 
  d4*5 cis8 b cis2 
}


baixo = \relative c {
  \partial 4 e4 
  e e8 d cis4 dis 
  e8 fis g4 fis e 
  b2. fis'4 
  e d8 e fis g a4 
  e fis g8 a b cis 
  d2. d,8 cis 
  b4. cis8 d e fis4 
  g fis e b8 cis 
  d e fis g a b c4 
  b2. g8 fis 
  e4 e d8 c b a 
  g a b c d4. c8 
  b4 c8 b ais2 
  b8 cis d e fis4. e8 
  d cis b ais b d cis b 
  fis'1 
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