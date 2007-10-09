
\version "2.10.33"

\header {
  title = "368 - Hilf, Herr Jesu, laß gelingen 2"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key f \major
}

soprano = \relative c {
  c''4 a2 g f4 bes c4. d16 dis d2. 
  c d4 
  bes2 c 
  f,4 bes a2 
  g2. c4 
  a2 g 
  f4 bes c4. d16 dis 
  d2. c d4 bes2 c f,4 
  bes a2 g2. e'4 c2 a d4 
  cis d4. e16 f e2. a, d4 e f 
  g c, bes a 
  d bes g2. f 
}


alto = \relative c {
  a''4 f2 f4 
  e f d g 
  f f2. 
  f a4 
  g2 g4 f 
  f f8 g g4 f 
  e2. a4 
  f2 f4 e 
  f d g f 
  f2. f a4 g2 g4 f f 
  f8 g g4 f e2. g8 f g4 
  g g f f 
  g a bes8 a g f 
  g4. e8 f2. f4 g a 
  g8 f g4 e c 
  bes f' f e8 d 
  e4 c2. 
}


tenor = \relative c {
  f'4 c2 c4. bes8 a4 bes2 
  a8 bes16 c c4 bes8 a bes4 
  a2. f'4 
  d2 c8 bes a4 
  a d8 c c2 
  c2. f4 
  c2 c4. bes8 
  a4 bes2 a8 bes16 c 
  c4 bes8 a bes4 a2. f'4 d2 c8 bes a4 a 
  d8 c c2 c2. c2 
  e4 c2 bes a4 d8 c bes4 
  a8 g a4 a2. bes4. g8 c4 
  c2 g4 f2 d'4 g, c 
  bes a2. 
}


baixo = \relative c {
  f8 g a4 f c2 d4 g8 f dis4 
  f bes,8 c d4 bes 
  f'2. d4 
  g f e f8 e 
  d c d e f4 f 
  c2. f8 g 
  a4 f c2 
  d4 g8 f dis4 f 
  bes,8 c d4 bes f'2. d4 g 
  f e f8 e d c 
  d e f4 f c2. c8 d e4 
  c f8 e f4 bes 
  e f d d 
  cis8 b cis4 d2. bes'8 a g4 f 
  e8 d e4 c f 
  bes,2 c8 bes c2 f,2. 
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