
\version "2.10.33"

\header {
  title = "171 - Schaut, ihr Sünder! Ihr macht mir große Pein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  g''4 a bes g 
  s4 d' c bes 
  a g a2 
  bes4 c d bes 
  s4 d dis d 
  c c bes2 
  d4 c bes g 
  s4 c c bes 
  a g f2 
  bes4 c d bes 
  s4 d c g8 a 
  bes4 a g2 
}


alto = \relative c {
  d'4 d d d 
  s4 g4. fis8 g4. fis8 g g, d'2 
  f4 f f f 
  s4 bes4. a8 bes4 
  bes a f2 
  f4. fis8 g4 d 
  s4 g4. f16 e f2 e4 c2 
  g'4 a bes8 gis g4 
  s4 g g g2 fis4 d2 
}


tenor = \relative c {
  bes'4 a g bes 
  s4 bes c d 
  d4. c8 fis,2 
  d'4 c bes d 
  s4 f dis f 
  g f8 dis d2 
  bes4 c d bes 
  s4 c8 bes a4. g8 
  a bes c bes a2 
  d4 f f dis 
  s4 f dis bes8 c 
  d4. c8 b2 
}


baixo = \relative c {
  g'4. fis8 g4 g, 
  s4 g a bes8 c 
  d4 dis d2 
  d8 bes4 a8 bes4 bes' 
  s4 bes8 gis g4 f 
  dis f bes,2 
  bes8 bes'4 a8 g4 g, 
  s4 e' f d 
  c c f,2 
  g'4 f8 dis d bes dis4 
  s4 b c8 d dis4 
  d d, g2 
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