
\version "2.10.33"

\header {
  title = "238 - Es wird schier der letzte Tag herkommen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  e'4 e b' b8 c 
  d4 b g a8 b 
  c2 b 
  a4 a g a 
  b a g fis 
  e2 d 
  g4 fis g8 a b4 
  a8 g fis4 e2 
  fis4 e8 fis g4 fis 
  e1 
}


alto = \relative c {
  b'4 b e8 fis g4 
  a8 fis g fis e4 fis8 g4 fis16 e fis4 g2 
  g4. fis8 fis e d a' 
  a g4 fis8 e4 a,8 d 
  d cis16 b cis4 a2 
  e'4 fis e e 
  e dis e2 
  dis4 e8 dis e4. d8 
  b1 
}


tenor = \relative c {
  g'4 g8 a b4 e 
  d d c4. d8 
  c d16 e d4 d2 
  e4 d8. c16 b4 d 
  d d4. cis8 d a 
  b g e a16 g fis2 
  b4 b b b 
  c c8 b16 a g2 
  b4. a8 b16*7 a16 
  gis1 
}


baixo = \relative c {
  e4. fis8 g4 e 
  fis8 d g4 c8 b a g 
  a4 d, g2 
  cis,4 d e fis 
  g d e fis 
  g8 e a a, d2 
  e4. dis8 e4 g, 
  a b c2 
  b8 a g fis e4 b' 
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