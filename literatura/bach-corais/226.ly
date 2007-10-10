
\version "2.10.33"

\header {
  title = "226 - Herr Jesu Christ, du hast bereit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g8 a bes4 a8 g f4 
  bes a bes bes 
  a g c bes 
  a2 g4 g 
  g8 a bes4 a8 g f4 
  bes a bes bes 
  a g c bes 
  a2 g4 d' 
  bes c d c 
  bes bes a bes 
  bes a bes a 
  g g fis bes 
  a g c bes 
  a2 g 
}


alto = \relative c {
  \partial 4 d'4 
  ees f8 g f4 c 
  f f f g4. fis8 g4. a4 g8 
  g fis16 e fis4 d d 
  ees f8 g f4 c 
  f f f g4. fis8 g4. a4 g8 
  g fis16 e fis4 d a'4. g4 f8 f4 f8. ees16 
  d8 e16 fis g4 fis g 
  f4. ees8 d g4 fis8 
  g fis g g, d'4 g,8 g'4 fis8 g f ees4 d 
  ees8 c a d16 c b2 
}


tenor = \relative c {
  \partial 4 bes'4 
  bes8 c d4 c8 bes a4 
  bes8 d c16 d ees4 d8 d4 
  ees8 d16 c bes8 b c ees d4 
  ees8 c a d16 c bes4 bes 
  bes8 c d4 c8 bes a4 
  bes8 d c16 d ees4 d8 d4 
  ees8 d16 c bes8 b c ees d4 
  ees8 c a d16 c bes4 d 
  d c4. bes4 a8 
  bes8. c16 d4 d d 
  d c bes8 d ees d2 c8 a4 d 
  d8. c16 bes8 a g a4 g fis16 e fis4 d2 
}


baixo = \relative c {
  \partial 4 g'8 f 
  ees4 d8 ees f4. ees8 
  d bes f'4 bes, g 
  c8 d ees d ees c g bes 
  c a d4 g, g'8 f 
  ees4 d8 ees f4. ees8 
  d bes f'4 bes, g 
  c8 d ees d ees c g bes 
  c a d4 g, fis' 
  g a bes f 
  g8. a16 bes8 g d4 g 
  d8 ees f fis g bes, c d 
  ees2 d4 g, 
  d' ees4. fis,8 g bes 
  c a d4 g,2 
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