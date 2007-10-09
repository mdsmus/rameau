
\version "2.10.33"

\header {
  title = "358 - Meine Seel erhebt den Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  d''2 f 
  d4 d d d 
  ees2 d 
  c c 
  bes1 
  d2 f 
  c4 c c g 
  bes2 a 
  g1 
  d'2 f 
  d4 d d d 
  ees2 d 
  c c 
  bes1 
  d2 f 
  c4 c c c 
  c2 g4 a 
  bes2 a 
  g1*3 g1 
}


alto = \relative c {
  g''2 f 
  f4 fis g a 
  g f2 g4 
  g2 f 
  f1 
  f 
  f4 f ees g 
  g2 fis 
  d1 
  g2 a 
  f2. fis4 
  g a bes2. bes4 bes a 
  f1 
  s1 
  f4 g a bes 
  c2 c, 
  d d4 c 
  b d g f 
  ees1. d4 c 
  d1 
}


tenor = \relative c {
  bes'2 c 
  d4 c bes a 
  bes c2 bes4 
  bes2 a 
  d1 
  bes 
  a4 c g c 
  d2. c4 
  bes1 
  bes2 c 
  d4 c bes a 
  bes c f, f' 
  g2 f4 c 
  d1 
  s2 f,4 g 
  a bes c2. d4 e fis 
  g2 f4 ees 
  d b c d2 g,4 c1 b4 a 
  b1 
}


baixo = \relative c {
  g'2 a 
  bes4 a g fis 
  g a bes g 
  ees c f2 
  bes,1 
  bes'2 bes, 
  f'4 a c ees, 
  d c d2 
  g,1 
  g'2 f 
  bes4 c d2. c4 bes d, 
  ees c f2 
  bes,1 
  bes4 c d ees 
  f2. g4 
  a bes c2 
  bes,4 c d ees 
  f2 ees4 d 
  c d ees f 
  g1 
  g, 
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