
\version "2.10.33"

\header {
  title = "18 - Menschenkind, merk eben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  g''4 g8 a b4 c 
  d e d2 
  e4 fis g d 
  b cis d2 
  c4 a b c 
  b a g2 
  fis4 g a b 
  a4. g8 fis4 e 
  d1 
  g4 g8 a b4 c 
  d e d2 
  g,4 a b c 
  b a g2 
}


alto = \relative c {
  d'4 e8 fis g4 fis8 e 
  d fis b a fis2 
  a4 a g a 
  g8 fis e4 fis2 
  e4 d d c 
  d4. c8 b2 
  d4 cis8 b a4 d 
  e8*5 d4 cis8 
  a1 
  d4 e8 fis g4 g 
  f e8 fis g2 
  g8 e d c b a g fis' 
  g4. fis8 d2 
}


tenor = \relative c {
  b'4 c d c 
  b16 c d4 cis8 d2 
  c8 b c d b4 a 
  d a a2 
  g4 a g8 fis g4 
  g fis g2 
  a4 g d'8 cis b4 
  e, a2 g4 
  fis1 
  g4 c d c4. b8 c4 b2 
  b4 a d e8 a, 
  b c d4 b2 
}


baixo = \relative c {
  g'4 c, g8 g' a4 
  b8 a g a d,2 
  a'4 d, e fis 
  g a d,2 
  e4 fis g e 
  d8 c d4 g,2 
  d'4 e fis g 
  cis, a d a 
  d1 
  b4 c g' e 
  d c g'2 
  e4 fis g e 
  d2 g 
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