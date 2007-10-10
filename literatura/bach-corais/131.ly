
\version "2.10.33"

\header {
  title = "131 - Liebster Jesu, wir sind hier"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  b''4 a8 g a4 d 
  b g a2 
  g4 g g g 
  a b a2 
  g1 
  b4 a8 g a4 d 
  b g a2 
  g4 g g g 
  a b a2 
  g1 
  d4 d e fis 
  g a fis d 
  g g g g 
  a b a2 
  g1 
}


alto = \relative c {
  d'4 d d fis 
  d d8 e fis2 
  e4 f e d 
  e8 fis g4 g fis 
  d1 
  d4 d d fis 
  d d8 e fis2 
  e4 f e d 
  e8 fis g4 g fis 
  d1 
  b4 a b8 cis d4 
  e e d a 
  d8 b c d e4 e 
  e8 fis g4. e8 fis4 
  d1 
}


tenor = \relative c {
  g'8 a b4 a a 
  b8 c d4 d2 
  b4 b c g 
  c d e8 c a d16 c 
  b1 
  g8 a b4 a a 
  b8 c d4 d2 
  b4 b c g 
  c d e8 c a d16 c 
  b1 
  g4 a g a 
  b a a8 g fis4 
  g4. f8 e fis g a16 b 
  c4 d d4. c8 
  b1 
}


baixo = \relative c {
  g4 g'4. fis8 e d 
  g a b g d2 
  e,8 e'4 d8 c, c'4 b8 
  a4 g8 b c a d4 
  g,1 
  g4 g'4. fis8 e d 
  g a b g d2 
  e,8 e'4 d8 c, c'4 b8 
  a4 g8 b c a d4 
  g,1 
  g8 g'4 fis8 e4 d2 cis4 d d 
  b8 g a b c d c b 
  a4 g d'2 
  g,1 
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