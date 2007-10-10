
\version "2.10.33"

\header {
  title = "159 - Als der gütige Gott vollenden wollt sein Wort"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d'4 
  g a b a 
  g2 s4 a 
  b c b a 
  g2 s4 b 
  d d c b 
  a2 s4 b 
  g c b a 
  g2 a4 a 
  b c b a 
  g1 
}


alto = \relative c {
  \partial 4 b'4 
  e8 g4 fis8 g fis16 e fis4 
  d2 s4 fis 
  g g8 a4 g fis8 
  d2 s4 g 
  g g4. fis8 g2 fis4 s4 fis4. e8 g a4 g fis8 
  g4. fis16 e fis4 fis 
  g g g4. fis8 
  d1 
}


tenor = \relative c {
  \partial 4 g'4 
  b d d d8 c 
  b2 s4 d 
  d e d4. d16 c 
  b2 s4 d 
  d b c d 
  d2 s4 b 
  b e8 d d4. d16 c 
  b8 a b cis d4 d 
  d c8 e d4 d8. c16 
  b1 
}


baixo = \relative c {
  \partial 4 g'4 
  e d g d 
  g,2 s4 d' 
  g c, d d, 
  g2 s4 g 
  b g a b8 c 
  d2 s4 dis 
  e4. fis8 g4 d 
  e2 d4 d 
  g e8 c d4 d, 
  g1 
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