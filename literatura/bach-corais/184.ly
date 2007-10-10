
\version "2.10.33"

\header {
  title = "184 - Christ lag in Todesbanden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  ais b8 cis d4 e 
  d cis b b 
  g a b a8 g 
  fis e fis4 e b' 
  ais b8 cis d4 e 
  d cis b b 
  g a b a8 g 
  fis e fis4 e s4 
  e8 fis g4 a e8 fis 
  g4 a b b 
  e dis e fis8 e 
  d4 cis b cis 
  d b8 cis d4 a 
  g fis e2 
  b'4 a g2 
  fis e 
}


alto = \relative c {
  \partial 4 g''4 
  fis fis fis fis 
  fis fis8 e dis4 fis 
  e d d8 dis e4 
  e dis b g' 
  fis fis fis fis 
  fis fis8 e dis4 fis 
  e d d8 dis e4 
  e dis b s4 
  b e e4. dis8 
  e4 d d g8 a 
  b4 a b fis 
  fis fis8 e d4 e 
  fis d g fis 
  fis8 e e dis e2 
  d8 e fis4. dis8 e2 dis4 b2 
}


tenor = \relative c {
  \partial 4 e'8 d 
  cis4 d8 ais b4 cis 
  b ais fis b 
  b8 c b a g a b4 
  c fis,8 a g4 e'8 d 
  cis4 d8 ais b4 cis 
  b ais fis b 
  b8 c b a g a b4 
  c fis,8 a g4 s4 
  g8 a b4 a8 b c4 
  b a g d' 
  g fis e8 d cis4 
  b ais fis g 
  a g g d'8 c 
  b4 a g2 
  g4 fis8 b b4 c2 b8 a gis2 
}


baixo = \relative c {
  \partial 4 e4 
  fis8 e d cis b4 ais 
  b fis b dis 
  e fis g8 fis e4 
  a,8 b16 c b4 e, e' 
  fis8 e d cis b4 ais 
  b fis b dis 
  e fis g8 fis e4 
  a,8 b16 c b4 e, s4 
  e'4. d8 c b a4 
  e' fis g g8 fis 
  e4 fis gis ais 
  b fis b, e 
  d g b,8 c d4 
  e b c2 
  g'4 dis e c 
  a b e,2 
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