
\version "2.10.33"

\header {
  title = "155 - Hilf, Herr Jesu, laß gelingen 1"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \minor
}

soprano = \relative c {
  g''2 g4 d'2 d4 c2 
  bes4 a2 a4 
  d2 f4 dis2 d4 c2 
  c4 bes2. 
  a2 bes4 c2 c4 bes2 
  c4 a2 a4 
  d2 d4 c2 bes4 a2 
  a4 g2. 
  bes2 bes4 bes2 bes4 dis2 
  d4 c2 c4 
  c2 d4 bes2 c4 a2 
  a4 g2 g 
}


alto = \relative c {
  d'2 d4 d8 e 
  fis4 g a2 
  a8 g g4 fis8 e fis4 
  f2 c'4 bes 
  c4. bes8 bes2 
  a4 f2. 
  fis2 g 
  fis8 g a2 g8 fis 
  g2 fis8 e fis4 
  fis8 g a4 g2 
  fis4 g g2 
  fis4 d2. 
  g2 g4 g2 bes4 bes a 
  bes2 a8 g a4 
  a2 a4 g2 g4 g2 
  fis4 d2 d 
}


tenor = \relative c {
  bes'2 bes4 a 
  d8 c bes4 dis d 
  d d2 d4 
  f2 f4 g 
  f f g f4. dis8 d2. 
  d2 d4 dis2 e8 d d2 
  dis4 d2 d4 
  a d8 c bes4 c 
  d d dis8 d c dis 
  d c bes2. 
  d2 d4 dis2 f4 dis c 
  f f2 f4 
  f2 fis4 d2 c8 d dis d c dis 
  d c b2 b4 
  bes 
}


baixo = \relative c {
  g'8 a bes4 g fis8 e 
  d4 g2 fis4 
  g d2 d4 
  bes bes' a g 
  a bes dis, f 
  f, bes2. 
  d4 c bes a 
  g fis g g' 
  c, d2 d4 
  d8 e fis4 g a 
  d, g c, a 
  d g,2. 
  g4 g' f dis, 
  dis' d c, c' 
  bes f2 f'4 
  f dis d g 
  f dis8 d c4 a 
  d g,2 g 
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