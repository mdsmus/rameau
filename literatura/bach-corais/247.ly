
\version "2.10.33"

\header {
  title = "247 - Wenn wir in höchsten Nöten sein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g a b a8 b 
  c b a4 g b 
  c b a g 
  fis8 g g8. fis32 g a4 d 
  c b a g8 fis 
  e8. fis32 g e4 d b' 
  c b a g8 a 
  b4 a g2 
}


alto = \relative c {
  \partial 4 d'4 
  e4. d8 d e fis4 
  e8 g16 fis e8 fis d4 g 
  g8 a4 g8 fis e16 dis e4 
  d d d fis 
  e d8 cis16 d e8 fis16 e d4 
  d cis d fis 
  e d e8 fis g4 
  g fis d2 
}


tenor = \relative c {
  \partial 4 b'4 
  b a8 fis g4 a 
  a8 d c b16 a b4 d 
  e8 dis4 e8 c4 b 
  a b fis b8 a 
  g a b4 cis b 
  b8 g a4 fis fis 
  g8 a b4 e,8 b'4 c8 
  d4 c16 b c8 b2 
}


baixo = \relative c {
  \partial 4 g'8 fis 
  e d c d g,4 d' 
  a8 b c d g,4 g'8 fis 
  e4 e e4. d8 
  c b a g d'4 b 
  e8 fis g4. fis8 b a 
  g e a4 d, dis 
  e8 fis g4 cis,8 dis e d16 c 
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