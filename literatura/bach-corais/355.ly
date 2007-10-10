
\version "2.10.33"

\header {
  title = "355 - O Welt, ich muß dich lassen"
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
  bes2 a4 f 
  bes c d d8 c 
  c2. d4 
  bes c d8 ees f4 
  ees2 d4 d 
  f f c d 
  bes2 a4 f 
  bes c d ees 
  d8 c c4 bes2 
}


alto = \relative c {
  \partial 4 f'4 
  ees ees d8 c bes4 
  bes' f f g 
  f8 ees f g a4 a 
  g2 c,4 c 
  f g8 a bes4 f 
  f2. a4 
  g f f g 
  g fis g g 
  f f f f 
  f e f a 
  g f f bes8 a 
  bes4 a f2 
}


tenor = \relative c {
  \partial 4 bes'4 
  g a bes8 c d4 
  d c bes bes 
  bes bes f' f 
  f e f a, 
  bes ees f8 a, bes4 
  a2. d4 
  d c bes8 c d4 
  c8 b a4 b bes 
  a8 g a bes c4 bes8 c 
  d4 c c d 
  d c bes bes8 c 
  d bes f' ees d2 
}


baixo = \relative c {
  \partial 4 bes4 
  ees8 d c4 bes bes'8 a 
  g4 a bes g 
  d8 c d ees f4 d 
  g2 f4 ees 
  d c bes8 c d ees 
  f2. fis4 
  g a bes b 
  c c, g' g 
  d' c8 bes a4 bes8 a 
  g4 c f, d 
  g a bes8 a g4 
  f8 ees f4 bes,2 
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