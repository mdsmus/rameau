
\version "2.10.33"

\header {
  title = "150 - Welt, ade! ich bin dein müde"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  r2. d''8 d 
  f4. f8 dis4 c 
  d2 c 
  s4 bes8 bes bes a bes c 
  d4 c bes2 
  d4 e f d 
  c bes a2 
  g4 d'8 d dis2. d4 c4. c8 
  bes1 
  a4 a bes c 
  d4. d8 cis2 
  f4 f e d 
  e4. e8 d2 
  bes1*2 c1 
  d1*2 f1 
  dis1*2 dis1 
  d1*3 f1*2 f1 
  f1*3 dis1 
  c1. c2 
  bes1*3 
}


alto = \relative c {
  f'4 f f2. f4 g f 
  f2 f4 f8 f 
  d2. bes4 
  bes c d2 
  f4 dis d d 
  f d d2 
  d g4 g 
  f4. f8 f4 f 
  f1 
  f4 d d e 
  d4. d8 e2 
  f4 f g f 
  e4. e8 fis2 
  g1*2 dis1 
  f1*2 f1 
  g 
  dis1*2 f1*3 f1*2 f1 
  f1*3 g1 
  f1. f2 
  f1*3 
}


tenor = \relative c {
  d'4 d d2. d4 c c 
  bes2 c4 a8 a 
  bes2. bes4 
  bes a bes2 
  bes4 g f bes 
  c g a2 
  bes2. bes8 bes 
  c4 bes c4. c8 
  d1 
  d4 d bes a 
  d d, a'2 
  a4 c c a 
  a4. a8 a2 
  g1*2 c1 
  f,1*2 f1 
  c'1*2 c1 
  d1*3 d1*2 f1 
  d1*2 d1 
  c1*2 c1 
  d1*3 
}


baixo = \relative c {
  bes'4 bes bes2. d,4 dis f 
  bes,2 f4 f'8 f 
  g2. g4 
  bes f bes,2 
  bes4 c d bes 
  f g d'2 
  g,2. g'8 g 
  a4 bes f4. f8 
  bes,1 
  d4 d d c 
  bes4. bes8 a2 
  f4 f c' d 
  a4. a8 d2 
  dis1*2 c1 
  bes1*2 d1 
  c1*2 c1 
  bes1*3 bes'1*2 a1 
  bes1*3 dis,1 
  f1. f2 
  bes,1*3 
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