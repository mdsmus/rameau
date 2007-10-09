
\version "2.10.33"

\header {
  title = "181 - Gott hat das Evangelium"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b b8 c d c b4 
  a b8 a g4 b 
  b b8 c d c b4 
  a b g b 
  c b a g8 a 
  b4 fis e b' 
  c b a g8 a 
  b4 fis e b' 
  b a g8 fis e fis 
  g4 g a a 
  b1 
}


alto = \relative c {
  \partial 4 g''4 
  fis g a4. g4 fis16 e fis4 d g 
  a g fis g2 fis4 e g4. a4 g fis8 e4. dis16 cis dis4 e gis 
  a d,8 e fis4 e 
  e dis e g 
  fis8 e fis dis b2 
  e4 e e8 g fis e 
  fis1 
}


tenor = \relative c {
  \partial 4 e'4 
  b e d d 
  e d8 c b4 d8 e 
  fis4 e d e 
  e b b e4. d8 d4 e8 b b4 
  b4. a8 g4 d' 
  e8 fis g4 d8 c b8*5 a8 g4 e' 
  b fis e8 fis g a 
  b4 b c8 e dis e 
  dis1 
}


baixo = \relative c {
  \partial 4 e4 
  dis e fis g 
  c, d g, g' 
  dis e b e8 d 
  cis4 dis e e4. fis8 g4 cis,8 dis e fis 
  g a b b, c4 b 
  a b8 c d4 e 
  g,8 a b4 e, e' 
  dis8 cis dis b e8*5 fis8 g e c b c4 
  b1 
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