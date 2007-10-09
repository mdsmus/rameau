
\version "2.10.33"

\header {
  title = "220 - Lasset uns den Herren preisen"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \minor
}

soprano = \relative c {
  d'4. e8 f g a2 d4 d e 
  cis d2 d4 
  f2 e4 d2 c4 d8 c bes2 a2. 
  d,4. e8 f g a2 d4 d e 
  cis d2 d4 
  f2 e4 d2 c4 d8 c bes2 a2. 
  a2 a8 bes c2 f,4 bes2 
  a4 g2 g4 
  g2 a4 bes2 c4 bes a 
  bes g2. 
  a2 a8 bes c2 a4 bes a2 g2. 
  f2 f4 f 
  e f g f 
  g a2 a4 
  a2 g4 a2 g4 a b2 c2. 
  d2 e4 f4. e8 d4 d e 
  cis d2. 
}


alto = \relative c {
  a'4 d8 cis d e f e 
  f g a2 bes4 
  a a2 a4 
  a2 a4 f2 f4 f f8 g 
  f e f2. 
  a,4 d8 cis d e f e 
  f g a2 bes4 
  a a2 a4 
  a2 a4 f2 f4 f f8 g 
  f e f2. 
  f2 f4. g8 
  f e f4 f2 
  f e8 d e4 
  e d d d 
  g8 fis g4 g g 
  fis d2. 
  f8 e f g d f g e 
  f g a g f2 
  f e 
  f4 c2 d4 
  e d8 c d4 c8 d 
  e4 f2 f4 
  f2 g4 g 
  f e f2 
  g4 g2. 
  g4 a2 a4. g8 f2 e4 
  e8 g fis2. 
}


tenor = \relative c {
  f4. g8 a2 
  d4. e8 f4 g 
  e8 g4. f8 e f4 
  d2 c 
  bes4. a8 bes c d4 
  c c2. 
  f,4. g8 a2 
  d4. e8 f4 g 
  e8 g4. f8 e f4 
  d2 c 
  bes4. a8 bes c d4 
  c c2. 
  d2 d4 c2 a4 d c2 c c4 
  c d a2 
  g4 c8 d dis d dis c 
  a d bes2. 
  d4 d d c2 c4 d c2 c2. 
  c4. bes8 a g a2 a4 g a 
  bes c2 c4 
  c2 c4 c2 c4 c d2 e2. 
  bes,4 f' e2 
  d8 cis d c bes4 bes 
  a a2. 
}


baixo = \relative c {
  d4 d, d' d8 cis 
  d e f g a4 g 
  a d,2 d,4 
  d'8 e f g a a, bes c 
  d e f f, bes a g4 
  c f,2. 
  d'4 d, d' d8 cis 
  d e f g a4 g 
  a d,2 d,4 
  d'8 e f g a a, bes c 
  d e f f, bes a g4 
  c f,2. 
  d'4 d' c8 bes a a, 
  bes c d c d e f g 
  a bes c2 c,4 
  c' bes8 a g fis g f 
  dis d dis d c bes c4 
  d g,2. 
  d'8 cis d e f d e c 
  d e f e d e f g 
  a bes c2. 
  a8 bes a g f e d e 
  d c bes a g a f bes 
  a g f2 f4 
  f8 a c f4 e8 f g 
  a bes c c, f e d g 
  f g c,2. 
  g8 g' f e d cis d f 
  g a bes a g f g e 
  a a, d2. 
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