
\version "2.10.33"

\header {
  title = "103 - O Welt, ich muß dich lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 d''4 
  bes c d8 ees f4 
  ees2 d4 d8 ees 
  f4 f c d 
  bes2 c4 f, 
  bes c d d8 ees 
  c2. d4 
  bes c d8 ees f4 
  ees2 d4 d8 ees 
  f4 f c d 
  bes2 a4 f 
  bes c d ees 
  d c bes 
}


alto = \relative c {
  \partial 4 bes''4 
  g a bes f 
  g f f f8 ees 
  d ees f g a4 a 
  g2 c,4 d 
  d f f f 
  f2. a4 
  g f f g 
  g2 g4 f 
  f8 g a bes c bes a g 
  f4 g f c 
  f g8 a bes4 a8 g 
  f4 f8 ees d4 
}


tenor = \relative c {
  \partial 4 f'4 
  ees ees f c 
  bes c bes bes 
  bes bes f' f 
  f e a, a 
  bes a bes bes 
  a2. d4 
  d c bes8 c d4 
  d c b bes 
  c8 bes a g f g a4 
  d c c a 
  bes ees, f8 g a4 
  bes a f 
}


baixo = \relative c {
  \partial 4 bes'4 
  ees8 d c4 bes a 
  g a bes bes,8 c 
  d c d ees f4 d 
  g2 f4 d 
  g f8 ees d c bes4 
  f'2. fis4 
  g a bes b 
  c c, g' bes 
  a8 g f g a4 f 
  d e f ees 
  d c bes c 
  d8 ees f4 bes, 
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