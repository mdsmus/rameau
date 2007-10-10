
\version "2.10.33"

\header {
  title = "207 - Spiritus sancti gratia"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \minor
}

soprano = \relative c {
  d'4 d d a'2 a4 bes2 
  bes4 a2. 
  f4 g a bes2. a4 g4. f8 f2 g4 
  a2 g4 g2 a4 f2 
  f4 e2. 
  d4 e f g2. f4 e4. d8 d2. 
}


alto = \relative c {
  a'4 a d e 
  d a'2 g8 fis 
  g2 f 
  f4. e8 dis d d4 
  e8 f g4. f8 f4 
  e c2 e4 
  f2 e8 d cis d 
  e4 e2 d8 cis 
  d4 d cis2 
  d4 a d e4. d8 e4. d8 d4 
  cis a2. 
}


tenor = \relative c {
  f8 g a g a4. g8 
  f e d4 d'2 
  d4 d2. 
  a8 d4 c8 c4 bes8 a 
  g4 c c d 
  c8. bes16 a2 c4 
  c2 c8 bes bes4 
  a8 b cis4 a a 
  b e, a2 
  a4 a a bes 
  a a a bes 
  a8. g16 fis2. 
}


baixo = \relative c {
  d8 e f e f d cis4 
  d fis, g8 a bes4 
  g d'2. 
  d4 e fis g 
  c,8 d e4 f bes, 
  c f,2 c'4 
  f,8 g a bes c d e d 
  cis4 a d8 e f4 
  gis, a2. 
  f'8 e d cis d2 
  cis8 b cis a d4 g, 
  a d,2. 
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