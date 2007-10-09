
\version "2.10.33"

\header {
  title = "237 - Was betrübst du dich, mein Herze"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  d''4 c bes a 
  bes a8 g fis4 d 
  d' d dis c 
  d c8 bes a2 
  d4 c bes a 
  bes a8 g fis4 d 
  d' d dis c 
  d c bes2 
  d4 dis f d 
  dis d d8 c c4 
  c d dis d 
  c4. bes8 a4 f 
  d' a bes a 
  bes c d2 
  d4 d c bes 
  a4. g8 g2 
}


alto = \relative c {
  g''8 a16 bes a4. g4 fis8 
  d g16 f f4 d a 
  bes8 c d4 g, g' 
  a4. g8 fis2 
  fis4 g8 a4 g fis8 
  g f e4 d a 
  bes8 d f4 g4. f8 
  f4 f8. dis16 d2 
  f4 g f g8 f 
  dis c f4 f f 
  f f g8 fis g4 
  g8 fis g4 f c 
  a'8 g a4. g4 fis8 
  g4 g fis2 
  g4 g4. fis8 g4. fis16 e fis4 d2 
}


tenor = \relative c {
  bes'8 c16 d dis8 d d16*7 c16 
  bes8 d c bes a4 fis 
  g g'8 f dis16 d c4 bes8 
  a d d4 d2 
  a4 g8 d' d4 d 
  d e8 a, a4 fis 
  f8 bes d c bes4 c4. bes4 a8 f2 
  d'8 c bes4. a8 bes4. a8 bes4. a8 a4 
  a bes4. a8 bes4 
  c c c a 
  a d d d 
  d dis a2 
  bes4 d dis8 d e4 
  a,8 d d8. c16 bes2 
}


baixo = \relative c {
  g'4. fis8 g4 d 
  g, c d d, 
  g8 a bes g c d dis4 
  fis, g d'2 
  d4 e8 fis g4 d 
  g cis, d d, 
  bes' bes'8 a g4 a 
  bes f bes,2 
  bes'8 a g4 d g 
  c, d8 dis f4 f, 
  f'8 dis d4 c g'8 f 
  dis4 e f f, 
  fis'8 e fis d g4 d 
  g8 f dis4 d2 
  g4 bes, c cis 
  d d, g2 
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