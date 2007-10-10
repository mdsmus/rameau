
\version "2.10.33"

\header {
  title = "93 - Nun laßt uns Gott dem Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 bes2 a4 g a 
  bes c2. 
  bes2 bes4 bes2 c4 a g 
  f bes2. 
  a2 a4 bes2 bes4 c2 
  d4 c2. 
  c2 d4 ees2 d4 c d8 c 
  bes4. c8 c4. bes8 
  bes2. 
}


alto = \relative c {
  \partial 4 f'4 g2 f4 ees f 
  f g f2 
  f f4 f2 g4 f2 
  f4 f e8 d e4 
  f2 fis4 g2 g4 ees2 
  d4 e f8 e g f 
  f2 a4 bes 
  c f, g a 
  d,8 ees f4 g f 
  f2. 
}


tenor = \relative c {
  \partial 4 d'4 d2 d8 c bes4 c 
  bes bes2 a4 
  d2 d4 d2 c4 c2 
  c4 d c bes 
  c2 d4 d2 ees4 a2 
  bes4 bes a8 g bes a 
  a2 d4 d 
  c bes bes a 
  bes bes2 a4 
  d2. 
}


baixo = \relative c {
  \partial 4 bes'4 g2 d4 ees2 
  d4 ees f2 
  bes, bes'4 d,2 e4 f g 
  a g2. 
  f2 d4 g2 ees4 c2 
  bes4 c2. 
  f2 fis4 g 
  a bes e fis 
  g d ees f 
  bes,2. 
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