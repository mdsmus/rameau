
\version "2.10.33"

\header {
  title = "264 - Jesu, meines Herzens Freud'"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  d''4 d8 ees f ees d4 
  c4. c8 c2 
  d4 ees8 d c4. bes8 
  bes2 a8 g a bes 
  c bes a4 g4. g8 
  g2 a4 bes8 a 
  g4. f8 f2 
  d'4 d8 ees f4 ees8 d 
  c4. c8 c2 
  d4 ees8 d c4. bes8 
  bes2 ees8 d ees f 
  d c d ees c4. bes8 
  bes1 
}


alto = \relative c {
  f'4 g f bes8 a 
  g4 f8 e f2 
  f4 ees8 f g4 f16 ees d ees 
  d2 c4 f 
  f f f8 e d4 
  e2 e4 d 
  d c c2 
  c4 bes c f 
  g8 f g4 f2 
  f4 ees8 f g4 a 
  g2 g4 f 
  f bes bes a 
  f1 
}


tenor = \relative c {
  bes'4 bes8 c d c bes4 
  bes a8 g a2 
  bes4 bes bes a 
  f2 f4 c' 
  c c c c8 b 
  c2 a8 g f4 
  f e a2 
  a'4 g f bes, 
  ees4. ees8 ees2 
  d8 c bes4 bes a8 d 
  d2 c4 c 
  c bes g' f8 ees 
  d1 
}


baixo = \relative c {
  bes'8 a g4 d g8 f 
  e d c4 f2 
  bes8 a g f ees4 f 
  bes,2 f'8 e f g 
  a g a bes c4 g 
  c,2 cis4 d8 c 
  bes4 c f2 
  fis4 g a bes 
  bes8 a bes g a2 
  bes8 a g f e4 fis 
  g2 c8 bes a f 
  bes a g f ees4 f 
  bes,1 
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