
\version "2.10.33"

\header {
  title = "166 - Es stehn vor Gottes Throne"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 g''4 
  bes g fis g 
  a2 bes4 bes 
  a bes c a 
  bes2 a4 bes 
  a g g fis 
  g2. g4 
  bes g fis g 
  a2 bes4 bes 
  a bes c a 
  bes2 a4 bes 
  a g g fis 
  g2. bes4 
  bes bes a bes 
  g2 fis4 bes 
  bes bes a bes 
  g2 fis4 g 
  a8 b c4 c b 
  c a bes a 
  g fis g2 
}


alto = \relative c {
  \partial 4 d'4 
  g d d8 c bes4 
  dis d d g4. fis8 g4. e8 d fis 
  d4 e fis g 
  g8 fis e4 d2 
  d2. d4 
  g d d8 c bes4 
  dis d d g4. fis8 g4. e8 d fis 
  d4 e fis g 
  g8 fis e4 d2 
  d2. g4 
  g g4. f8 f4. dis16 d c4 d d 
  e8 f g4 g f4. dis16 d dis4 d g 
  f g8 gis g4 g 
  g g fis8 g a4 
  d,8 dis d4 d2 
}


tenor = \relative c {
  \partial 4 bes'4 
  d bes a g 
  g4. fis8 g4 d' 
  d d e8 c d c 
  bes a g4 d' d 
  dis8 a bes4. a16 g a4 
  bes2. bes4 
  d bes a g 
  g4. fis8 g4 d' 
  d d e8 c d c 
  bes a g4 d' d 
  dis8 a bes4. a16 g a4 
  bes2. d4 
  d d d d4. c16 bes a8 g a4 g8 a 
  bes d c4 c d 
  bes a a c 
  c8 d dis4 d8 c d4 
  dis e d4. c8 
  bes4 a8 c b2 
}


baixo = \relative c {
  \partial 4 g4 
  g8 a bes c d4 dis8 d 
  c4 d g, g' 
  d g8 f e a fis d 
  g4 cis, d g, 
  c cis d d, 
  g2. g4 
  g8 a bes c d4 dis8 d 
  c4 d g, g' 
  d g8 f e a fis d 
  g4 cis, d g, 
  c cis d d, 
  g2. g4 
  g8 a bes c d4 bes 
  dis2 d4 g4. f8 e c f dis d bes 
  dis d c a d4 e 
  f dis8 f g4 g, 
  c cis d8 e fis4 
  g8 c, d4 g,2 
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