
\version "2.10.33"

\header {
  title = "208 - Am Sabbat früh Marien drei 1"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key e \minor
}

soprano = \relative c {
  e'4 e e b'2 b4 a b 
  g8 a b4 a a 
  b2 g4 fis 
  g a b a 
  g g2 fis4 
  g2 a4 b2 b4 a2 
  a4 g2 g4 
  fis2. e4 
  fis dis e2 
  e4 a2 a4 
  b2 b4 g2 g4 fis2. e8 fis g a b4 
  b2 a4 b2. 
}


alto = \relative c {
  b'4 b b fis'2 g fis4 
  e fis e8 g fis e 
  fis2 b,8 cis d2 e8 fis g4. fis4 e8 e d c4 d 
  d2 fis4 g2 g4 fis8 e fis4 
  dis e8 dis e2. dis2 e4 
  c b b2 
  b4 e d c 
  d e fis2 
  e8 dis e4 e dis2 b4 e fis 
  e4. g8 fis e dis2. 
}


tenor = \relative c {
  g'4 g g fis 
  dis' e e b 
  b b c8 e dis e 
  dis2 e4 a, 
  b c d4. c8 
  b4 c4. b8 a4 
  b2 d4 d2 e8 d c4 b 
  b b2 b4 
  b2. g4 
  a fis g2 
  g fis4 fis 
  g b2 b b4 b2. g4 b b8 a 
  g fis e dis e4 fis2. 
}


baixo = \relative c {
  e4 g e dis 
  b e cis dis 
  e d c8 b c4 
  b2 e4 d8 c 
  b4 a g d' 
  e c a d 
  g,2 d'4 g 
  fis e2 dis4 
  b e g e 
  b2. c4 
  a b e2 
  e4 cis d8 c b a 
  g4 g'8 fis e dis e4 
  e,8 fis g a b2. e,4 e' dis 
  e8 d c b c4 b2. 
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