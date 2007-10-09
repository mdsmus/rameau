
\version "2.10.33"

\header {
  title = "168 - Heut ist, o Mensch, ein großer Trauertag"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 d'4 
  f g a bes 
  a g c bes 
  a2 s4 d 
  c bes a g 
  f g f dis 
  d2 s4 a' 
  bes c d d 
  c g8 a bes4 a 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  a8 f'4 e8 f4 d8 e 
  fis4 g4. a4 g8 
  fis2 s4 bes4. a4 g f dis d8 dis d c bes c a 
  bes2 s4 c 
  d8 f g a bes4 g8 f 
  dis f g4 g4. fis8 
  d1 
}


tenor = \relative c {
  \partial 4 g'4 
  f8 a d c c4 g 
  a16 bes c4 bes16 a g8 d' d4 
  d2 s4 f16*7 dis16 d16*7 c16 bes2 bes4 f2 
  f s4 f 
  f' dis f d 
  g, c d4. c8 
  b1 
}


baixo = \relative c {
  \partial 4 g4 
  d' bes8 c f4 g 
  d e4. fis8 g4 
  d2 s4 bes 
  f' g d dis 
  bes8 a g4 a8 g a f 
  bes2 s4 f'8 dis 
  d4 c bes b 
  c8 d dis4 bes8 c d4 
  g,1 
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