
\version "2.10.33"

\header {
  title = "167 - Du großer Schmerzensmann, vom Vater so fischlagen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g g g a 
  b2 s4 b 
  b d g,8 a b4 
  a2 g4 b 
  a b g a 
  fis2 s4 g 
  g g a g 
  fis2 e4 fis 
  fis fis fis g 
  a2 s4 a 
  a b c c 
  b2 s4 b 
  b d c b 
  a2 s4 a 
  b a g fis 
  e1 
}


alto = \relative c {
  \partial 4 e'4 
  d e d e8 fis 
  g2 s4 g 
  g g8 fis e fis g4 
  g fis d g 
  fis fis4. e4 fis8 
  dis2 s4 e 
  e d e8 dis e2 dis4 b d 
  d e d cis 
  d2 s4 fis 
  fis g g fis 
  g2 s4 g 
  g g4. fis8 g4 
  fis2 s4 fis4. e8 fis4. e4 dis8 
  b1 
}


tenor = \relative c {
  \partial 4 b'4 
  b8 a g a b4 c 
  d2 s4 d 
  e d c d4. a8 d c b4 d 
  d dis b c 
  b2 s4 b 
  c g c cis 
  fis,8 b4 a8 g4 b 
  b cis4. b8 a g 
  fis2 s4 d' 
  d d e d 
  d2 s4 d 
  e d e8 d d4 
  d2 s4 d8 c 
  b2. b8. a16 
  g1 
}


baixo = \relative c {
  \partial 4 e4 
  b c b a 
  g2 s4 g'8 fis 
  e4 b c b8 c 
  d2 g,4 g' 
  d8 c b4 e a, 
  b2 s4 e8 d 
  c d c b a4 ais 
  b2 e4 b8 cis 
  d4 ais b e 
  d2 s4 d 
  d'8 c b4 a d, 
  g2 s4 g8 fis 
  e d c b a4 g 
  d'2 s4 d 
  dis8 cis dis b e4 b 
  e,1 
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