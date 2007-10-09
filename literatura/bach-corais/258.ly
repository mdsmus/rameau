
\version "2.10.33"

\header {
  title = "258 - Meine Augen schließ ich jetzt in Gottes Namen zu"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g d g a 
  b2 s4 d 
  e d c4. d8 
  b2 s4 d 
  c b a g 
  a2 s4 b 
  g c b a 
  g2 s4 b8 c 
  d4 d c b 
  a2 s4 b 
  g g a b 
  c2 b4 d 
  c a b c 
  d2 s4 g, 
  a b c b 
  a2 g 
}


alto = \relative c {
  \partial 4 d'4 
  d a d e8 fis 
  g2 s4 g4. fis8 g4. fis16 e fis4 
  g2 s4 g4. fis8 g4. fis8 g g, 
  d'2 s4 fis 
  fis8 e16 fis g8 a4 g8 g fis 
  d2 s4 g 
  g g g8 fis g4 
  g fis s4 fis 
  e d e e 
  e2 e4 d8 f 
  e g4 fis8 g4 g 
  g2 s4 e4. fis8 g4. fis8 g4 
  g8 fis16 e fis4 d2 
}


tenor = \relative c {
  \partial 4 b'8 a 
  g4 fis g c 
  d2 s4 d 
  c d e8 d16 c d4 
  d2 s4 b 
  c d d4. cis8 
  fis2 s4 b, 
  b e8 d d4 d8. c16 
  b2 s4 d 
  d8 c b4 c d 
  d2 s4 b 
  b8 c d4 c b4. a16 gis a4 a8 gis g4 
  g d' d e 
  d2 s4 b 
  c8 d d e16 d c4 d 
  e d8. c16 b2 
}


baixo = \relative c {
  \partial 4 g8 a 
  b c d c b4 a 
  g2 s4 b 
  c4. b8 a4 d, 
  g2 s4 g 
  a b8 c d4 e 
  d2 s4 dis 
  e4. fis8 g4 d 
  g,2 s4 g8 a 
  b4. e8 a,4 b8 c 
  d2 s4 dis 
  e8 d c b c b a gis 
  a b c d e4 b 
  c d g8 fis e4 
  b2 s4 e8 d 
  c4 b8 e a,4 b8 g 
  c4 d g,2 
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