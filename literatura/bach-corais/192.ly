
\version "2.10.33"

\header {
  title = "192 - Gottlob, es geht nunmehr zu Ende"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key bes \major
}

soprano = \relative c {
  d''4 bes d ees2 d4 c2 
  bes4 c2 c4 
  d d d g,2 a4 bes2 
  bes4 a2. 
  d4 bes d ees2 d4 c2 
  bes4 c2 c4 
  d d d g,2 a4 bes2 
  bes4 a2. 
  f4 c' c c2 d4 ees2 
  ees4 d2. 
  f4 f f ees2. d4 d 
  c bes2. 
}


alto = \relative c {
  f'4 f bes2 
  a4 f g f4. e8 a2 a4 
  bes f8 a g f e2 f e8 d 
  e4 f2. 
  f4 f bes2 
  a4 f g f4. e8 a2 a4 
  bes f8 a g f e2 f e8 d 
  e4 f2. 
  c4 c e f2 bes a8 g 
  a4 bes2. 
  f4 bes8 a bes4 g 
  c a bes bes4. a8 f2. 
}


tenor = \relative c {
  bes'4 bes f' ees 
  c bes2 a4 
  bes f'2 f4 
  f bes,8 c d4 c2 c4 d bes 
  c c2. 
  bes4 bes f' ees 
  c bes2 a4 
  bes f'2 f4 
  f bes,8 c d4 c2 c4 d bes 
  c c2. 
  a4 g g a2 f'4 g ees 
  f f2. 
  d4 bes8 c d4 c2 f4 f2 
  f8. ees16 d2. 
}


baixo = \relative c {
  bes4 d bes c 
  f bes e f 
  g f2 f4 
  bes, d bes c 
  bes a g2 
  c4 f,2. 
  bes4 d bes c 
  f bes e f 
  g f2 f4 
  bes, d bes c 
  bes a g2 
  c4 f,2. 
  f'4 e c f 
  ees d c2 
  f4 bes,2. 
  bes4 d bes c 
  a f bes d 
  f bes,2. 
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