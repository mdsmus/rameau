
\version "2.10.33"

\header {
  title = "371 - Christ lag in Todesbanden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  ais b8 cis d4 e 
  d cis b b8 a 
  g4 a b8 a g4 
  fis8 e fis4 e b' 
  ais b8 cis d4 e 
  d cis b b8 a 
  g4 a b8 a g4 
  fis8 e fis4 e s4 
  e8 fis g4 a e8 fis 
  g4 a b b 
  e d e fis8 e 
  d4 cis b cis 
  d8 c b c d4 a 
  g fis e2 
  b'4 a g fis 
  e1 
}


alto = \relative c {
  \partial 4 g''4 
  fis4. ais8 b ais16 b cis4. b4 ais8 fis4 fis 
  fis8 e4 dis16 cis b8 dis e4 
  e8 dis16 cis dis4 b g' 
  fis4. ais8 b ais16 b cis4. b4 ais8 fis4 fis 
  fis8 e4 dis16 cis b8 dis e4 
  e8 dis16 cis dis4 b s4 
  b e e4. b8 
  b c16 d e4 dis fis 
  b a b8 gis cis4 
  c8 b4 ais8 fis4 g 
  fis d d2 
  e4. d8 cis2 
  dis8 e e fis b, e4 dis8 
  b1 
}


tenor = \relative c {
  \partial 4 e'8 d 
  cis4 d8 e fis g4 fis8 
  fis b, cis16 d e8 e dis b4 
  b8 c4 b16 a b4 b 
  b4. a8 g4 e'8 d 
  cis4 d8 e fis g4 fis8 
  fis b, cis16 d e8 e dis b4 
  b8 c4 b16 a b4 b 
  b4. a8 g4 s4 
  g8 a b4 e, a 
  g8 a16 b c4 fis, dis' 
  e8 fis16 g a8 fis b, e cis b16 ais 
  b8 d g fis d4 e 
  a, b8 a g4. fis8 
  b4 a a2 
  b4 cis8 dis e g, c b16 a 
  gis1 
}


baixo = \relative c {
  \partial 4 e4 
  e d8 cis b b'4 ais8 
  b g e fis b,4 dis 
  e fis g8 fis g a 
  b4 b, e e 
  e d8 cis b b'4 ais8 
  b g e fis b,4 dis 
  e fis g8 fis g a 
  b4 b, e s4 
  e4. d8 c b cis dis 
  e d c4 b b'8 a 
  g fis16 e fis8 a gis cis ais fis 
  b g e fis b,4 e 
  d g,8 a b c d4. cis8 d fis a2 
  a8 g4 fis8 e c a b 
  e1 
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