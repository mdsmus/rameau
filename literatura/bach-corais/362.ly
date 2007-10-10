
\version "2.10.33"

\header {
  title = "362 - Nun freut euch, lieben Christen, g'mein 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g8 a b4 a g 
  a a b g8 a 
  b4 c d c8 b 
  a g a4 g g 
  g8 a b4 a g 
  a a b g8 a 
  b4 c d c8 b 
  a g a4 g b 
  b a g fis 
  g8 a b4 a a 
  g fis g d 
  g a b g8 a 
  b4 c d c8 b 
  a g a4 g2 
}


alto = \relative c {
  \partial 4 d'4 
  e8 fis g4 g8 fis g4 
  g fis g e8 fis 
  g b4 a16 g fis4 g 
  g fis d d 
  e8 fis g4 g8 fis g4 
  g fis g e8 fis 
  g b4 a16 g fis4 g 
  g fis d g 
  g4. fis8 fis e e dis 
  e4 d d d 
  d8 c d4 d8 c b4 
  b e dis b 
  e e d8 e16 fis g4 
  g fis d2 
}


tenor = \relative c {
  \partial 4 b'4 
  b e e8 d d4 
  e8 c a d d4 e 
  d g,8 a b c d4 
  d c8 b b4 b 
  b e e8 d d4 
  e8 c a d d4 e 
  d g,8 a b c d4 
  d c8 b b4 d 
  d d8 c b c fis, b 
  b a a g fis4 fis 
  g8 a b c b a g4 
  g fis8 e fis4 e8 fis 
  g4. a8 b c d4 
  d c8 b b2 
}


baixo = \relative c {
  \partial 4 g'8 fis 
  e4. d8 c4. b8 
  c a d4 g, c 
  g'8 fis e4 b'8 a g4 
  d' d, g g8 fis 
  e4. d8 c4. b8 
  c a d4 g, c 
  g'8 fis e4 b'8 a g4 
  d' d, g g8 a 
  b c d4 g,8 a b4 
  e,8 fis g4 d d'8 c 
  b4. a8 g4. fis8 
  e d c4 b e 
  e8 d c4 b8 a g4 
  d'2 g, 
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