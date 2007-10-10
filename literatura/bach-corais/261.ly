
\version "2.10.33"

\header {
  title = "261 - Christ lag in Todesbanden"
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
  fis2 e4 b' 
  ais b8 cis d4 e 
  d cis b b 
  g a b a8 g 
  fis2 e4 s4 
  e g a e 
  g a b b 
  e dis e fis 
  d cis b b8 c 
  d4 b d a 
  g fis e2 
  b'4 a g fis 
  e1 
}


alto = \relative c {
  \partial 4 g''4 
  fis fis8 ais b4 cis 
  b ais fis fis 
  e d d e 
  e dis b g' 
  fis fis8 ais b4 cis 
  b ais fis fis 
  e d d e 
  e dis b s4 
  b e8 d e4 c 
  b a g d' 
  g fis e b' 
  b ais fis g 
  a d, d c 
  b8 e4 d8 d4 c 
  b8 cis dis4 e8 c' dis,4 
  b1 
}


tenor = \relative c {
  \partial 4 e'8 d 
  cis4 d8 e fis4 fis 
  fis fis8 e dis4 b 
  b a g8 a b4 
  c b8 a g4 e'8 d 
  cis4 d8 e fis4 fis 
  fis fis8 e dis4 b 
  b a g8 a b4 
  c b8 a g4 s4 
  g g c a 
  g d' d b 
  b a b b 
  fis' fis8 e d4 b 
  a g g fis 
  g a a2 
  fis g8 e b' a 
  gis1 
}


baixo = \relative c {
  \partial 4 e4 
  fis8 e d cis b4 ais 
  b fis' b, dis 
  e fis g e 
  a, b e e 
  fis8 e d cis b4 ais 
  b fis b dis 
  e fis g e 
  a, b e, s4 
  e'8 d c b a b c d 
  e4 fis g g 
  e fis g d8 e 
  fis4 fis, b e 
  fis g b,8 c d4 
  e fis8. gis16 a2 
  dis,4 b e8 a, b4 
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