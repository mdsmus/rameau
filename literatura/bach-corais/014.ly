
\version "2.10.33"

\header {
  title = "14 - O Herre Gott, dein göttlich Wort"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g fis e d 
  g a b a 
  b8 c16 d c4 b a8 b 
  c4 b a2 
  g2. g4 
  g fis e d 
  g a b a 
  b8 c16 d c4 b a8 b 
  c4 b a2 
  g2. g4 
  a b g g 
  a b g e 
  a4. g8 fis4 g8 fis 
  e2 d4 d 
  g fis e d 
  g a b a 
  d4. c8 b4 a8 b 
  c4 b a2 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  e d c c 
  b d d d 
  d e d8 e fis4 
  g2. fis4 
  d2. d4 
  e d c c 
  b d d d 
  d e d8 e fis4 
  g2. fis4 
  d2. d4 
  d d e d 
  e fis e b 
  a8 b cis4 d d 
  d cis a b 
  b8 cis d4 c8 b a4 
  d d d d8 e 
  fis4 g8 a d, e fis4 
  g2. fis4 
  d1 
}


tenor = \relative c {
  \partial 4 b'4 
  b b8 a g4 fis 
  g fis g fis 
  fis g8 a b c d4 
  c8 d e4 a,8 b c4 
  b2. b4 
  b b8 a g4 fis 
  g fis g fis 
  fis g8 a b c d4 
  c8 d e4 a,8 b c4 
  b2. b4 
  fis g g b 
  a8 g fis4 b g8 fis 
  e4 a a g8 a 
  b4 a8 g fis4 fis 
  g a4. g8 fis4 
  g fis g fis 
  b4. a8 b c d4 
  c8 d e4 a,8 b c4 
  b1 
}


baixo = \relative c {
  \partial 4 g'4 
  e b c d 
  e d g, d' 
  b e,8 fis g4 fis 
  e8 e' d c d2 
  g,2. g'4 
  e b c d 
  e d g, d' 
  b e,8 fis g4 fis 
  e8 e' d c d2 
  g,2. g'4 
  d g, c b 
  cis dis e e8 d 
  cis4 a d8 cis b a 
  g4 a d b 
  e, fis8 g a b c4 
  b d g, d'8 c 
  b4 e8 fis g4 fis 
  e d8 c d2 
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