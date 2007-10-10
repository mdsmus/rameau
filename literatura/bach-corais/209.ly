
\version "2.10.33"

\header {
  title = "209 - Dir, dir, Jehova, will ich singen"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 f'4 bes 
  d8 c d bes g'4 ees2 f4 bes, ees 
  c2 bes4 c 
  ees d c d8 c 
  d bes a bes bes4. c8 
  c2 f,4 bes 
  d8 c d bes g'4 ees2 f4 bes, ees 
  c2 bes4 c 
  ees d c d8 c 
  d bes a bes bes4. c8 
  c2 a4 bes 
  c d g, g'8 ees 
  c b c d d4. ees8 
  ees2 c4 a 
  bes8 a g f f'4. bes,8 
  g'4. f8 ees d c bes 
  bes2. 
}


alto = \relative c {
  \partial 4 d'4 f 
  bes8 a bes4 bes g2 f4 g8 a bes4 
  bes a f f 
  f4. g8 a4 bes8 a 
  bes4 ees, f8 ees f e 
  f2 d4 f 
  bes8 a bes4 bes g2 f4 g8 a bes4 
  bes a f f 
  f4. g8 a4 bes8 a 
  bes4 ees, f8 ees f e 
  f2 f4 f2 f4 ees4. g8 
  ees d ees4 gis g 
  g2 g4 f 
  g a bes4. bes8 
  bes4 bes bes a 
  f2. 
}


tenor = \relative c {
  \partial 4 bes'4 bes 
  f'8 ees f4 ees bes8 a 
  bes c d2 g4 
  f4. ees8 d4 c8 bes 
  c a bes4 c f, 
  f c' bes f8 g 
  a2 bes4 bes 
  f'8 ees f4 ees bes8 a 
  bes c d2 g4 
  f4. ees8 d4 c8 bes 
  c a bes4 c f, 
  f c' bes f8 g 
  a2 c4 f, 
  a bes bes4. bes8 
  c4. c8 c4 b 
  c2 c4 c2 c4 d4. d8 
  ees4 bes f' ees8 d 
  d2. 
}


baixo = \relative c {
  \partial 4 bes'4 d, 
  c bes ees g8 f 
  g ees bes' a g4 ees 
  f2 bes,4 a'8 g 
  a f bes4 f ees 
  d c d8 c d bes 
  f2 bes'4 d, 
  c bes ees g8 f 
  g ees bes' a g4 ees 
  f2 bes,4 a'8 g 
  a f bes4 f ees 
  d c d8 c d bes 
  f2 f'8 ees d4 
  ees8 d c bes ees4. ees8 
  gis4. g8 f4 g 
  c,2 ees4 f2 ees4 d g8 f 
  ees d ees4 f f, 
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