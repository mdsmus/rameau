
\version "2.10.33"

\header {
  title = "70 - Gott sei gelobet und gebenedeiet"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 g''4 
  g g a2 
  g c4 d 
  c b a2 
  g a8 b c4 
  g8 f e4 f e 
  d2 c4 g' 
  g g a2 
  g c4 d 
  c b a2 
  g a8 b c4 
  g8 f e4 f e 
  d2 c4 g' 
  g g a4. g8 
  fis g a4 g2 
  g4 g a b 
  c b a2 
  g b4 c 
  d d d a 
  g e d2 
  e4 fis g8 f e4 
  fis2 g 
  d8 e f4 e d 
  e d c2 
  s4 g' g g 
  a4. g8 fis g a4 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  g8 f e2 d4 
  e2 g4 g4. fis8 g4 g8 fis16 e fis4 
  d2 f4. e8 
  d4 c4. b8 c4. b16 a b4 g d' 
  g8 f e2 d4 
  e2 g4 g4. fis8 g4 g8 fis16 e fis4 
  d2 f4. e8 
  d4 c4. b8 c4. b16 a b4 g e' 
  d8 c d f e d16 c b8 cis 
  d g4 fis8 d2 
  d4 e fis g4. fis8 g4 g8 fis16 e fis4 
  d2 g4 g 
  g g4. fis16 e fis8 f 
  e d d cis a2 
  c4 c d c4. e8 d c b2 
  b4 a g8 c b4 
  c4. b8 g2 
  s4 d' c g 
  c8 d e4 d2 
  d1 
}


tenor = \relative c {
  \partial 4 b'8 c 
  d4 c8 b c4 b8 a 
  b2 e4 f 
  e d d4. c8 
  b2 d4 c 
  d g, f g 
  a g8 f e4 b'8 c 
  d4 c8 b c4 b8 a 
  b2 e4 f 
  e d d4. c8 
  b2 d4 c 
  d g, f g 
  a g8 f e4 c' 
  g8 a b4 c8 fis, g a 
  b4 a16 b c8 b2 
  b4. cis8 d4 d 
  c d e8 c a d16 c 
  b2 d4 e 
  d8 c b4 c d8 c 
  ais4 a8. g16 f2 
  g4 a g g 
  a8 c b a g2 
  g4 c,8 d e g g4 
  g g8. f16 e2 
  s4 g8 f e4 d8 e 
  f4 c'8 b a g4 fis8 
  b1 
}


baixo = \relative c {
  \partial 4 g8 a 
  b4 e8 d c4 f 
  e2 e8 d c b 
  c4 g d' d, 
  g2 d'4 a 
  b c8 b a4 g 
  f g c, g'8 a 
  b4 e8 d c4 f 
  e2 e8 d c b 
  c4 g d' d, 
  g2 d'4 a 
  b c8 b a4 g 
  f g c, c' 
  b8 a g4 c8 d e4 
  d d, g2 
  g'8 fis e4 d8 c b4 
  a b8 g c a d4 
  g,2 g'8 f e4 
  b4. e8 a,4 d 
  g, a d2 
  c8 b a4 b c8 b 
  a4 d g,2 
  g4 a8 b c e g f 
  e c g' g, c2 
  s4 b c b 
  a8 b c4 d2 
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