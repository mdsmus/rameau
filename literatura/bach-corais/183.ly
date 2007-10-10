
\version "2.10.33"

\header {
  title = "183 - Nun freut euch, lieben Christen, g'mein 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g d g c 
  b a g g 
  a8 b c4 b a 
  e fis g g 
  g d g c 
  b a g g 
  a8 b c4 b a 
  e fis g g 
  c b a d 
  d cis d d 
  e c d4. c8 
  b4 a g b 
  a d, g c 
  b a g2 
}


alto = \relative c {
  \partial 4 d'4 
  d a d a' 
  d, d8. c16 b4 b8 cis 
  d f e fis g4 d8 a16 b 
  c4 c b d 
  d a d a' 
  d, d8. c16 b4 b8 cis 
  d f e fis g4 d8 a16 b 
  c4 c b d 
  g8 a4 g16 fis e4 a8 fis 
  e g4 fis16 e fis4 g 
  g g a8 fis g a4 g fis8 e4 e4. d16 c b4 e8 d e fis 
  g4. fis8 d2 
}


tenor = \relative c {
  \partial 4 b'8 a 
  g4 fis g4. fis8 
  g4. fis8 d4 g 
  fis8 gis a4 d,8 e fis4 
  g a d, b'8 a 
  g4 fis g4. fis8 
  g4. fis8 d4 g 
  fis8 gis a4 d,8 e fis4 
  g a d, g8 fis 
  e' d d4 cis d 
  b8 e, a4 a d4. c16 b c8 e d c b a 
  b16 c d4 c8 b4 g 
  a g8 a b4 a 
  d16*7 c16 b2 
}


baixo = \relative c {
  \partial 4 g8 a 
  b c d c b4 a 
  g8 b d4 g, e' 
  d a b8 c d4 
  c8 b a4 g g8 a 
  b c d c b4 a 
  g8 b d4 g, e' 
  d a b8 c d4 
  c8 b a4 g g'8 f 
  e fis g4. a16 g fis8 b 
  g4 a8 a, d4 b 
  c8 d e4 fis8 d e fis 
  g4 d e e 
  fis g8 fis e4 a, 
  b8 c d4 g,2 
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