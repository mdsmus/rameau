
\version "2.10.33"

\header {
  title = "164 - Ihr Knecht des Herren allzugleich"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 bes2 a4 g2 
  f4 bes c2 
  d d4 d2 d4 c2 
  d4 ees d2 
  c bes4 c2 d4 c2 
  bes4 g a2 
  bes f'4 d2 bes4 c2 
  ees4 d c2 
  bes2. 
}


alto = \relative c {
  \partial 4 f'4 g2 f4 ees2 
  d4 d g f 
  f2 a4 g2 g4 g f 
  f f f2 
  f g4 f2 f8 bes g4 f8 ees 
  d4 g g fis 
  g2 f4 f2 g4 f2 
  f4 f g f8 ees 
  d2. 
}


tenor = \relative c {
  \partial 4 d'4 d2 d4 bes2 
  bes4 bes2 a4 
  bes2 a4 bes2 bes4 bes a 
  bes c bes2 
  a d4 c2 bes4 bes a 
  bes bes8 d ees4 d 
  d2 c4 d2 d4 a2 
  a4 bes2 a4 
  f2. 
}


baixo = \relative c {
  \partial 4 bes8 a g a 
  bes c d bes ees f g a 
  bes a g f ees d ees f 
  bes,2 fis4 g8 d' 
  g f ees d ees c f ees 
  d c bes a bes c d ees 
  f2 g4 a8 f 
  g a bes g ees d ees f 
  g d ees bes c a d d, 
  g2 a'4 bes8 c 
  bes a g f ees g f ees 
  d c bes d ees c f f, 
  bes2. 
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