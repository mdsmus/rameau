
\version "2.10.33"

\header {
  title = "222 - Nun preiset alle Gottes Barmherzigkeit"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \major
}

soprano = \relative c {
  g''4 g a b 
  g2 a4 a 
  b c2 b4 
  c2. b4 
  b cis d a2 b4 cis d 
  d2 cis4 d2. a4 a 
  b c d e 
  d2 c4 b2 a4 e'4. d8 
  c4 d4. c8 b4 
  c c b a2 g4 e'4. d8 
  c4 d4. c8 b4 
  c c b a2 g4 
}


alto = \relative c {
  d'4 e fis g8 f 
  e2 f 
  f4 g2 g4 
  g2. g4 
  g g fis fis2 g4 g fis8 g 
  a4 g8 fis g e fis2. fis4 fis 
  gis a4. gis8 a g 
  fis4 gis a a 
  gis e e8 fis g4 
  a a8 g fis4 g 
  g a g g 
  fis d e8 fis g4 
  a a8 g fis4 g 
  g a g g 
  fis d 
}


tenor = \relative c {
  b'4 b d d 
  c2 c 
  d4 e2 d8 f 
  e2. d4 
  d e a, d2 d4 a d4. c8 b4 a a2. d4 d 
  d e d c8 b 
  a4 b c8 e f4 
  e8 d c4 g' c,8 d 
  e4 d2 d4 
  e d d e 
  d8 c b4 g' c,8 d 
  e4 d2 d4 
  e d d e 
  d8 c b4 
}


baixo = \relative c {
  g'8 fis e4 d g, 
  c2 f4. e8 
  d4 c e g 
  c,2. g'4 
  g8 fis e4 d2 
  d4 g a b 
  fis g a d,2. d4 c 
  b a b c2 b4 a d 
  e a, c'4. b8 
  a g fis e d4 g8 fis 
  e4 fis g c, 
  d g, c'4. b8 
  a g fis e d4 g8 fis 
  e4 fis g c, 
  d g, 
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