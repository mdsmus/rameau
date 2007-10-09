
\version "2.10.33"

\header {
  title = "143 - In dulci jubilo"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 f2 f4 a2 
  bes4 c2 d4 
  c2. f,2 f4 a2 
  bes4 c2 d4 
  c2. c2 d4 c2 
  bes4 a4. bes8 a g 
  f2 f4 g2 g4 a2 
  g4 f2 g4 
  a2. c2 d4 c2 
  bes4 a4. bes8 a g 
  f2 f4 g2 g4 a2 
  g4 f2 g4 
  a2. d,2 d4 e2 
  e4 f8 e f g a bes 
  c2. a2 a4 g2 
  g4 f1. 
}


alto = \relative c {
  \partial 4 c'4 d2 d4 e2 
  e4 f2. 
  f f4 
  e d c2 
  d4 c e g 
  e2. f2 f4 e f 
  g cis, d e 
  d2 f4 f 
  e8 d e4 f2 
  e4 f4. g8 f e 
  f2. f2 f4 g f 
  g g f e 
  d2 f 
  e8 d e4 f2 
  e a,4 d 
  cis2. d2 d c8 d 
  e2 d 
  c2. c4 
  f8 e f4 f2 
  e4 f8 dis d c d bes 
  c2. 
}


tenor = \relative c {
  \partial 4 a'4 a2 bes4 c2 
  bes4 a2 bes4 
  a2. a2 bes4 a g 
  f g c b 
  g2. a2 bes4 c d 
  e a, bes cis 
  a2 c4 d 
  bes c c2 
  c4 c a c 
  c2. a2 bes4 g2 
  e'4 e d cis 
  a2 c4 d 
  bes c c2 
  c4 a2 bes4 
  e2. s8 f 
  g a bes a g4 a8 bes 
  c bes a4. g8 f4 
  g2. a4 
  bes c d bes 
  c2 bes8 a bes g 
  a2. 
}


baixo = \relative c {
  \partial 4 f4 d 
  c bes a bes8 a 
  g a f f' dis d c bes 
  f'2. d4 
  c bes f' e 
  d e c g 
  c2. f2 bes a4 
  g2 f4 e 
  d2 a4 bes 
  g c f,8 g a bes 
  c bes a4 f c 
  f2. f'4 
  e d e d 
  c f8 g a4 a, 
  d2 a4 bes 
  g c f,8 g a bes 
  c a d4 c bes 
  a2. bes4 
  a g c bes 
  a d8 c d e f d 
  e2. f,4 
  g a bes g 
  c a bes2 
  f2. 
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