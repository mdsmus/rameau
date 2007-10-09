
\version "2.10.33"

\header {
  title = "124 - Auf, auf, mein Herz, und du, mein ganzer Sinn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 b''4 
  b b b e 
  d d c c 
  b g a a 
  b c d8 c b4 
  a a g a 
  a a a b8 a 
  g4 g a g 
  fis2 fis4 fis 
  g g a a 
  b c d8 c b4 
  a2 g 
}


alto = \relative c {
  \partial 4 g''4 
  g8 e b' a g4 a8 g 
  fis e fis gis a4 e8 fis 
  g4 d d8 e fis e 
  d4 g8 e fis a g4. fis16 e fis4 d e 
  fis8 g fis e fis4 fis2 e4. fis8 b, e4 dis8 e cis dis4 b 
  b e8 d e fis16 g a8 fis 
  d e16 fis g8 fis16 e fis8 a4 g8 
  g4 fis d2 
}


tenor = \relative c {
  \partial 4 d'4 
  d8 e fis4 e e 
  a,8 g a b c b a4 
  d b a d8 c 
  b a g4 a8 fis g b 
  e c a d16 c b4 cis 
  d8 cis d e d4 b 
  b b a8 fis g4 
  c cis b b8 a 
  g fis g b c4. d16 c 
  b4. a16 g a8 fis' d e 
  e c a d16 c b2 
}


baixo = \relative c {
  \partial 4 g'8 fis 
  g4 dis e c 
  c4. b8 a gis a4 
  g g' fis8 e d4 
  g8 fis e4 d e8 d 
  c a d4 g, g' 
  fis8 e d cis d4 dis 
  e8 fis g e cis dis e c 
  a4 ais b dis 
  e8 d c b a g fis d 
  g g' e a fis d g e 
  c a d4 g,2 
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