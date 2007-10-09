
\version "2.10.33"

\header {
  title = "346 - Meines Lebens letzte Zeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  b''4 b c b 
  b a b2 
  d4 d e e 
  a, d8 c b4 b 
  g4. a8 b4 a8 g 
  fis4. e8 e2 
  b'4. c8 d4 b 
  c b8 a a4 g 
  b b e e 
  a, a b c 
  d d c b 
  a a b4. c8 
  d4 b c b 
  a b b a8 g 
  fis2 e 
}


alto = \relative c {
  g''4 g fis g8 fis 
  e dis e4 dis2 
  g8 a b a b4 e, 
  d8 g fis4 g g 
  e e fis e 
  e dis b2 
  g'4 g a g4. fis8 g4. fis8 d4 
  g8 a b4 b a8 g4 fis16 e fis4 g g 
  a8 g a4 g8 a4 g8 
  g fis16 e fis4 g g 
  gis8 fis gis b4 a8 g4. fis8 fis4 e e2 dis4 b2 
}


tenor = \relative c {
  e'4 e a, g 
  g fis8 e fis2 
  b8 c d2 c4 
  d d d d 
  c c b b 
  c b8. a16 g2 
  e'4 d d d 
  c8 d e4 d8. c16 b4 
  d g8 fis e d e4 
  d d d e 
  a, d8 fis e d d4 
  d d d e 
  b e e d 
  d b8 a g4 a8 b 
  c4 b8 a gis2 
}


baixo = \relative c {
  e,4 e'4. dis8 e g 
  c,2 b 
  g4 g'4. fis8 g c 
  fis, e d4 g g, 
  c'8 b c4 dis, e 
  a, b e,2 
  e'8 fis g4. fis8 g b 
  e, d c4 d g, 
  g'8 fis e d c4 cis 
  d2 g4 fis8 e 
  fis e fis b e, fis g4 
  d2 g8 fis e4. d8 e gis a,4 b8 c 
  d4 dis e8 g c, b 
  a4 b e2 
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