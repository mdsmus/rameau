
\version "2.10.33"

\header {
  title = "71 - Ich ruf' zu dir, Herr Jesu Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  g fis8 g16 a g8 fis e fis 
  g8. a16 a4 b b8 c 
  d c b a g4 a8 b 
  c2 b4 b 
  g fis8 g16 a g8 fis e fis 
  g8. a16 a4 b b8 c 
  d c b a g4 a8 b 
  c2 b4 d 
  e d8 c b a g a 
  b c a4 g b 
  b b a g8 fis 
  fis2 e 
  g4 fis e2 
  d4 d g g 
  a a b c 
  b a g8 fis e fis 
  g4 fis e2 
}


alto = \relative c {
  \partial 4 fis'4 
  e dis e8 dis e dis 
  e4. fis8 dis4 e 
  d d e d 
  c8 e4 dis8 e4 fis 
  e dis e8 dis e dis 
  e4. fis8 dis4 e 
  d d e d 
  c8 e4 dis8 e4 d8 g16 f 
  e4 fis fis g 
  g8 a fis4 d d8 e 
  fis a g fis e dis e4 
  e dis e2 
  e4. d4 cis16 b cis4 
  a a d c8 d 
  e c e d e4 e 
  e8 dis e fis e dis e4 
  e dis b2 
}


tenor = \relative c {
  \partial 4 b'4 
  b8 c4 b16 a b8*5 b8 a16 g fis e fis4 g 
  a g8 f e4 fis8 gis 
  a g fis4 g b 
  b8 c4 b16 a b8*5 b8 a16 g fis e fis4 g 
  a g8 f e4 fis8 gis 
  a g fis4 g g 
  g8 c b a b4. c8 
  d e d c b4 g 
  fis e a8 b c4 
  b8 a4 g8 g2 
  a4 a b a8 g 
  fis4 fis g8 f e g 
  c e a,4 gis a8 g 
  fis4 e8 b' b4. c8 
  b4. a8 gis2 
}


baixo = \relative c {
  \partial 4 dis4 
  e8*5 fis8 g fis 
  e d c4 b e 
  fis g c,8 d c b 
  a2 e4 dis' 
  e8*5 fis8 g fis 
  e d c4 b e 
  fis g c,8 d c b 
  a2 e4 b' 
  c d dis e 
  d8 c d4 g, g' 
  dis e8 d c4 b8 a 
  b2 c 
  cis4 d g, a 
  d d8 c b4 c8 b 
  a g f4 e a 
  b cis8 dis e fis g a 
  b4 b, e2 
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