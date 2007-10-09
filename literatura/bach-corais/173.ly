
\version "2.10.33"

\header {
  title = "173 - O Herzensangst, o Bangigkeit und Zagen"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key ees \major
}

soprano = \relative c {
  bes''4 g c bes2 ees,4 f2 
  g4 aes2 bes4 
  g ees2 f4 
  g a bes2 
  d4 c d ees 
  d c2 bes2. bes4 b 
  b c2 d4 
  ees4. ees8 f4 ees 
  d2 c 
  bes4 c4. d8 ees4 
  ees2 d4 ees2. 
}


alto = \relative c {
  ees'4 ees ees d2 ees4 d8 c bes2 f' f4 
  ees bes2 d4 
  ees ees d2 
  f4 f f ees 
  f g f8 ees d2. f4 g 
  g8 f ees2 g4 
  g g f g 
  aes g8 f ees2 
  ees4 ees f g2 f8 ees f aes g2. 
}


tenor = \relative c {
  g'4 bes aes8 g f2 bes4 aes2 
  g4 c bes bes 
  bes g2 bes4 
  bes c f,2 
  bes4 c bes bes 
  bes2 a4 f2. d'4 d 
  g, g2 d'4 
  c c c c2 b4 g2 
  cis4 c8 bes c4 bes 
  bes2 bes4 bes2. 
}


baixo = \relative c {
  ees4 ees aes, aes2 g'4 f8 ees d4 
  ees2 d8 c d4 
  ees ees,2 bes'4 
  ees8 d c4 bes2 
  bes'4 a aes g 
  f ees f f2. bes8 aes g f 
  ees d c2 b4 
  c4. bes8 aes4 g 
  f g c2 
  g4 aes2 g8 aes 
  bes2. ees, 
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