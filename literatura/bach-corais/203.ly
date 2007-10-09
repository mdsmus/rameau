
\version "2.10.33"

\header {
  title = "203 - O Mensch, schau Jesum Christum an"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \minor
}

soprano = \relative c {
  g''4 g g g2 dis4 d2 
  d4 a'2 bes4 
  a2 g4 f2 e4 d2 
  d4 g2 g4 
  fis2 fis4 g2 g4 a2 
  a4 a2 a4 
  bes2 bes4 a2. d2 
  c4 bes2 a4 
  g a b c2 a4 bes2 
  a4 g2 fis4 
  g2. 
}


alto = \relative c {
  d'8 c d4 b c 
  b c8 a d c d4 
  d d2 d4 
  cis d e e8 cis 
  d4. cis8 a2 
  a4 d2 d4 
  d dis d d 
  c8 bes c4 fis,2 
  fis'4 fis2 fis4 
  g2 g4 g 
  fis8 e fis4 fis8 g a2. g4 d 
  g f2 g fis4 g f 
  dis dis4. dis8 d4 
  d2. 
}


tenor = \relative c {
  bes'8 a g4. f8 dis f 
  g4 fis g8 a bes4 
  bes a2 g4 
  a2 a4 a 
  bes8 a g a fis2 
  fis4 g8 a bes2 
  a8 bes c4 a g4. bes8 a g d'2 
  d4 d2 d4 
  d2 d4 d2. a4 d2 d d c4 d dis2 d4 d2 
  c4 c8 bes a4. c8 
  b2. 
}


baixo = \relative c {
  g8 a bes4 g c8 d 
  dis4 c bes8 a g4 
  g' fis2 g f8 e d cis d4 
  g, a d,2 
  d'8 c bes4 g8 a bes c 
  d4 a8 bes c a bes4 
  dis8 d dis4 d2 
  d,4 d'8 dis d c bes a 
  g fis g a bes c d2. d8 e fis e 
  fis d g fis g a g f 
  dis d dis f dis d c2 d4 g8 g, a bes 
  c d dis d c4 d 
  g,2. 
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