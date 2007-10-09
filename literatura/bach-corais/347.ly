
\version "2.10.33"

\header {
  title = "347 - Was Gott tut das ist wohlgetan"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d'4 
  g a b c8 d16 e 
  d4 c8 b b4 e 
  d c b a16 b c8 
  b4 a8 g g4 d 
  g a b c8 d16 e 
  d4 c8 b b4 e 
  d c b a16 b c8 
  b4 a8 g g4 d' 
  e e a, a 
  d d g, b 
  a g fis g8 fis 
  e2 d4 d' 
  c b a b8 c 
  a2 g 
}


alto = \relative c {
  \partial 4 b'8 c 
  d4 d g g 
  g8 e fis4 d c8 b 
  a4 e' d e 
  d2 d4 b8 c 
  d4 d g g 
  g8 e fis4 d c8 b 
  a4 e' d e 
  d2 d4 g 
  g a8 g fis4 fis 
  g8 a g f e4 g 
  g8 fis e4 e8 d d4 
  d cis a b8 a 
  g a b c d4 d8 e 
  e4 d d2 
}


tenor = \relative c {
  \partial 4 g'8 a 
  b4 a e' e8 c 
  b g a4 g g 
  fis g8 a b a g4 
  g fis b g8 a 
  b4 a e' e8 c 
  b g a4 g g 
  fis g8 a b a g4 
  g fis b b 
  c8 b a4 d d 
  d8 c d4 c d 
  d8 a b a a4 g8 a 
  b4 a8 g fis4 fis' 
  e d8 e a,4 g 
  g fis b2 
}


baixo = \relative c {
  \partial 4 g4 
  g' fis e8 d c4 
  d2 g,4 c 
  d e8 fis g4 c, 
  d2 g,4 g 
  g' fis e8 d c4 
  d2 g,4 c 
  d e8 fis g4 c, 
  d2 g,4 g' 
  c, cis d d8 c 
  b a b4 c g 
  d'4. cis8 d fis g a 
  g e a4 d, b 
  e8 fis g4. fis8 g e 
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