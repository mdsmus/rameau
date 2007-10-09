
\version "2.10.33"

\header {
  title = "246 - Singt dem Herrn ein neues Lied"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  g''4 g g d 
  g a b2 
  g8 a b cis d4 fis 
  e2 d 
  g,4 g g d 
  g a b2 
  g8 a b cis d4 fis 
  e2 d 
  e4 d c e 
  d c b2 
  a a4 gis 
  a b c c 
  b2 g4 a 
  b c c b 
  c2 d4. c8 
  b4 a g8 a b4 
  a2 g 
}


alto = \relative c {
  d'8 c b c d4 d 
  e16 fis g4 fis8 g2 
  d4 d8 g fis4 a 
  b8 g e a16 g fis2 
  d8 c b c d4 d 
  e16 fis g4 fis8 g2 
  d4 d8 g fis4 a 
  b8 g e a16 g fis2 
  g8 e fis gis a4 e 
  a8 gis a4 a8 gis16 fis gis4 
  e2 e4 e 
  e e e e 
  e2 e4. d16 c 
  d8 g4 f16 e a4 g 
  g2 g4 fis 
  d d e8 fis g4. fis16 e fis4 d2 
}


tenor = \relative c {
  b'8 c d c b c b a 
  b4 e8 d d2 
  b8 a g4 a d4. cis16 b cis4 a2 
  b8 c d c b c b a 
  b4 e8 d d2 
  b8 a g4 a d4. cis16 b cis4 a2 
  c4 d e8 d c b 
  a b c d16 e f8 d b e16 d 
  c2 c4 b 
  c b4. a16 gis a2 gis4 b8 c16 b a4 
  g8 b a16 b c8 d4. f8 
  e2 d4 a 
  g a b8 c d4 
  e8 c a d16 c b2 
}


baixo = \relative c {
  g'8 a b a g a g fis 
  e d c d g,2 
  g'8 fis g e fis e d e16 fis 
  g8 e a4 d,2 
  g8 a b a g a g fis 
  e d c d g,2 
  g'8 fis g e fis e d e16 fis 
  g8 e a4 d,2 
  c'4. b8 a4. g8 
  f4. e8 d b e4 
  a,2 a8 c e d 
  c b a gis a b c d 
  e2 e8 c f4. e8 a g f d g4 
  c,2 b8 c d4 
  g,8 g'4 fis8 e d c b 
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