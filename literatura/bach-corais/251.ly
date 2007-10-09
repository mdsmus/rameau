
\version "2.10.33"

\header {
  title = "251 - Ich bin ja, Herr, in deiner Macht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  a a8 bes16 c bes8 g d'4. c16 bes a8 g fis4 a 
  bes c8 d16 ees d8 bes f'4. e16 d c8 bes a4 d 
  cis d e8 f16 g f8 e 
  e2 d4 g, 
  a a8 bes16 c bes8 g d'4. c16 bes a8 g fis4 a 
  bes c8 d16 ees d8 bes f'4. e16 d c8 bes a4 d 
  cis d e8 f16 g f8 e 
  e2 d4 d 
  bes8 a b d g ees c4 
  d8 f ees d ees4 a 
  d g, c8 d16 ees d8 c 
  bes4 a8 g g2 
}


alto = \relative c {
  \partial 4 d'4 
  ees d d4. d8 
  g4 fis8 g d4 fis 
  g f f4. f8 
  bes4 c8 e, f4 f 
  g f e d 
  e8 f g4 fis d 
  ees d d4. d8 
  g4 fis8 g d4 fis 
  g f f4. f8 
  bes4 c8 e, f4 f 
  g f e d 
  e8 f g4 fis a 
  g g g4. ees8 
  gis4 g g fis 
  g8 f e4 fis8 g a4 
  a8 g fis4 d2 
}


tenor = \relative c {
  \partial 4 bes'4 
  c8 bes a4 g4. a8 
  bes4 c8 bes a4 d 
  d c bes4. c8 
  d4 g,8 c c4 bes 
  bes a a a8 d 
  d cis16 b cis4 a bes 
  c8 bes a4 g4. a8 
  bes4 c8 bes a4 d 
  d c bes4. c8 
  d4 g,8 c c4 bes 
  bes a a a8 d 
  d cis16 b cis4 a d 
  d d c4. c8 
  c4 b c d 
  d c c8 bes a d 
  d4 c8 bes bes2 
}


baixo = \relative c {
  \partial 4 g'4 
  g fis g4. f8 
  ees d ees c d4 d 
  g a bes4. a8 
  g f e c f4 bes 
  e f cis d 
  a' a, d g 
  g fis g4. f8 
  ees d ees c d4 d 
  g a bes4. a8 
  g f e c f4 bes 
  e f cis d 
  a' a, d fis 
  g f ees4. gis8 
  f d g4 c, c' 
  bes8 a bes c a g fis4 
  g d g,2 
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