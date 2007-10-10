
\version "2.10.33"

\header {
  title = "234 - Gott lebet noch, Seele, was verzagst du doch?"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key f \major
}

soprano = \relative c {
  f'4 a b c2. c4 bes 
  c d c d 
  e d e f2. a,2 
  bes4 c bes a 
  g2 a4 bes 
  a g f2 
  g4 a2 g4 
  a2 b4 c2. e2 
  f4 d2 f4 
  e2 d4 cis2 a4 d2 
  a4 bes a g 
  f2 e8 f d2. fis2 
  fis4 g fis g 
  a bes c bes 
  a8 bes g4 c2 
  c4 c d e 
  f e d e2 c4 f c 
  a d2 c4 
  bes c a g2. c4 a 
  f d' e f 
  a,2 g8 f f2. 
}


alto = \relative c {
  c'4 f f g2. f4 g 
  f f2 f4 
  g8 a bes2 a2. f2 
  f4 f8 d e4 f 
  e2 fis4 g 
  f e f8 e d4 
  e f2 g4 
  f2 f4 g2. c2 
  c4 bes f bes 
  bes2 bes4 a2 e4 a4. g8 
  f e d4. cis8 d4 
  d2 cis4 a2. c4 a 
  d d c bes 
  d2 d4 d 
  c bes g' e 
  f g f e 
  d e8 f g4 g2 e4 f2 
  f4 f2 f4 
  g2 f4 f 
  e2 f 
  f4 f g a 
  f2 e4 c2. 
}


tenor = \relative c {
  a'4 c d e2. c4 d 
  c bes f bes 
  bes8 c d4 c c2. d2 
  d4 c2 c4 
  c2 c4 d 
  c c c bes8 a 
  bes4 c2 c4 
  c2 d4 e2. g2 
  f4 f8 e d cis d4 
  g2 f4 e2 cis4 d2 
  c4 bes f'8 e d e 
  f4 d a f2. a2 
  a4 bes c d 
  a g fis g 
  fis g g2 
  a4 c b c 
  c2 b4 c2 g4 c2 
  c4 bes2 c4 
  d c c c2. c2 
  c4 bes bes c 
  c d8 c bes c a2. 
}


baixo = \relative c {
  f,4 f' d c 
  c' bes a g 
  a bes a bes 
  g2 c,4 f2 f,4 d' c 
  bes a g f 
  c' bes a g 
  a bes a bes 
  g f f' e 
  f e d c2. c'4 bes 
  a bes bes, a' 
  g f g a 
  a, g' f e 
  d g a bes 
  a g a d,2. a4 d 
  c bes a g 
  fis' e d g 
  d g, e' c 
  f e d c 
  d g g, c2 c4 a2 
  f4 bes bes' a 
  g e f c 
  c' bes a f 
  a bes g f4. a,8 bes4 c f,2. 
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