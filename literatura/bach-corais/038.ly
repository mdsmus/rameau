
\version "2.10.33"

\header {
  title = "38 - Straf' mich nicht in deinem Zorn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  g''4 aes bes bes 
  ees, f g2 
  c4 d ees g, 
  f2 ees 
  g4 aes bes bes 
  ees, f g2 
  c4 d ees g, 
  f2 ees 
  bes'4 f g2 
  c4. bes8 a2 
  bes4 f g8 a bes4 
  bes a bes2 
  c4 d ees g, 
  f2 ees 
}


alto = \relative c {
  ees'4 ees f8 ees d4 
  ees ees8 d ees2 
  ees4 f ees8 d ees4 
  ees d bes2 
  ees4 ees f8 ees d4 
  ees ees8 d ees2 
  ees4 f ees8 d ees4 
  ees d bes2 
  f'8 ees d f ees2 
  c4 c c2 
  f4 f4. ees8 d4 
  c2 d 
  f4 f ees ees 
  ees d bes2 
}


tenor = \relative c {
  bes'4 c f, g 
  g c8 bes bes2 
  aes4 aes bes bes 
  c bes8 aes g2 
  bes4 c f, g 
  g c8 bes bes2 
  aes4 aes bes bes 
  c bes8 aes g2 
  bes4 bes bes2 
  g8 f e g f2 
  bes8 c d4 d8 c bes a 
  g4 f f2 
  aes4 bes bes bes 
  c8 bes16 aes bes8 f g2 
}


baixo = \relative c {
  ees8 d c ees d c bes d 
  c bes aes bes ees,2 
  aes8 g f aes g f ees g 
  aes f bes4 ees,2 
  ees'8 d c ees d c bes d 
  c bes aes bes ees,2 
  aes8 g f aes g f ees g 
  aes f bes4 ees,2 
  d'8 c bes d ees2 
  e8 d c e f2 
  d8 c bes d ees f g f 
  ees c f4 bes,2 
  f8 g aes f g aes bes g 
  aes f bes4 ees,2 
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