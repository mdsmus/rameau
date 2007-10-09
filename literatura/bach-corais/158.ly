
\version "2.10.33"

\header {
  title = "158 - Der Tag der ist so freudenreich"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g g a b 
  c8 b a4 g2 
  a4 a e fis 
  g a g g 
  g g a b 
  c8 b a4 g2 
  a4 a e fis 
  g a g g 
  d' d e d8 c 
  b4 cis d d 
  d d e d8 c 
  b4 a g2 
  e4 fis g e 
  d cis d2 
  g4 g a b 
  c8 b a4 g2 
  a4 a e fis 
  g8 fis e4 d f 
  e c e fis 
  g a g2 
}


alto = \relative c {
  \partial 4 d'4 
  e e4. fis8 g4 
  g4. fis8 d2 
  fis4 e8 d e4. d16 c 
  b8 g d'4 d d 
  e e4. fis8 g4 
  g4. fis8 d2 
  fis4 e8 d e4. d16 c 
  b8 g d'4 d d 
  d g8 a b c b a 
  g4 g a a 
  g g g a4. g4 fis8 d2 
  c4 c d8 b4 a8 
  a b a4 a2 
  e'4 e e8 fis g4 
  g4. fis8 d2 
  d4 d cis d 
  d cis a d 
  c g c d 
  d4. c8 b2 
}


tenor = \relative c {
  \partial 4 b'4 
  b c c d8 f 
  e4 a,8 d16 c b2 
  d4 c8 b4 a b16 a 
  g4. fis8 b4 b 
  b c c d8 f 
  e4 a,8 d16 c b2 
  d4 c8 b4 a b16 a 
  g4. fis8 b4 b 
  a8 c b a g4 d' 
  d e fis d8 c 
  b c d b c b a d 
  d4 d8. c16 b2 
  g4 a d,8 g4 fis16 e 
  fis4 e8 fis16 g fis2 
  b4 c c d8 f 
  e4 a,8 d16 c b2 
  fis8 g a4 a a 
  b e,8 a16 g fis4 g 
  g e a a 
  g fis g2 
}


baixo = \relative c {
  \partial 4 g'8 fis 
  e d c b a4 g 
  c d g,2 
  d'4 a8 b c4 d 
  e d g, g'8 fis 
  e d c b a4 g 
  c d g,2 
  d'4 a8 b c4 d 
  e d g, g' 
  fis g8 fis e4 fis 
  g8 fis e4 d fis 
  g8 a b g c4 fis, 
  g d g,2 
  c8 b a4 b cis 
  d a d,2 
  e'8 d c b a4 g 
  c d g,2 
  d8 e fis g a g fis4 
  e a d b 
  c4. b8 a4 d8 c 
  b g d'4 g,2 
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