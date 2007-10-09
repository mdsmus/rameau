
\version "2.10.33"

\header {
  title = "90 - Hast du denn, Liebster, dein Angesicht gänzlich verborgen"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key bes \major
}

soprano = \relative c {
  bes''4 bes f' d4. c8 bes4 a bes8 a 
  g f bes4 c d8 ees 
  c2 bes4 bes 
  bes f' d4. c8 
  bes4 a bes8 a g f 
  bes4 c d8 ees c2 bes4 f' ees8 d 
  c bes g'8*5 s8 
  d4 ees f f 
  g8 f ees d c8*5 s8 f,4 g a 
  bes c d8 ees c2 bes8*5 
}


alto = \relative c {
  f'4 f f f4. f8 g4 c, c 
  c f g8 a bes c 
  a2 f4 f 
  f f f4. f8 
  g4 c, c c 
  f g8 a bes c a2 f4 bes a 
  f bes8*5 s8 
  bes4 bes a8 g f4 
  bes g a8*5 s8 f4 c c 
  bes f' f f4. ees8 d8*5 
}


tenor = \relative c {
  d'4 d c bes4. c8 d e f4 f 
  a, bes ees, f 
  f' ees d d 
  d c bes4. c8 
  d e f4 f a, 
  bes ees, f f' 
  ees d d ees 
  f ees8*5 s8 
  f4 g c, c 
  bes bes f'8*5 s8 bes,4 a8 g ees'4 
  d c bes bes 
  a f8*5 
}


baixo = \relative c {
  bes'4 bes a bes4. a8 g4 f c 
  ees d c bes 
  f'2 bes,4 bes' 
  bes a bes4. a8 
  g4 f c ees 
  d c bes f'2 bes,4 bes c 
  d ees8*5 s8 
  bes'4 a8 g f ees d4 
  d ees f8*5 s8 d4 e fis 
  g a bes f2 bes,8*5 
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