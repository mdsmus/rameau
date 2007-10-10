
\version "2.10.33"

\header {
  title = "109 - Da Christus geboren war"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \minor
}

soprano = \relative c {
  g''4 g8 a bes4 a2 g4 fis8 g g4. fis16 g a2. 
  a8 bes bes4. a16 bes c2 d4 bes a2 g2. 
  a4 a bes c2 bes4 a g2 f2. 
  c'4 d e f 
  e2 d 
  cis4 d2. 
  d2 d4 c8 bes 
  a bes c4 d c 
  bes a2. 
  d2 d4 c 
  d ees d c 
  bes a2. 
  a8 bes bes4. a16 bes c2 d4 bes a2 g2. 
}


alto = \relative c {
  d'4 g8 fis g4 g 
  fis g c, d 
  cis d2. 
  fis4 g2 g4 
  a fis d ees 
  d d2. 
  f4 f f e 
  f g f2 
  e4 c2. 
  a'4 g2 f4 
  bes a f bes 
  a a2. 
  bes2 bes4 a8 g 
  f g a4 a fis 
  g fis2. 
  g4 a bes a 
  g fis g fis 
  g fis2. 
  fis8 g g4. fis16 g a8 g 
  fis g a4 g2 
  fis4 d2. 
}


tenor = \relative c {
  bes'8 c d4 d ees 
  d8 c bes4 a g8 a 
  bes4 fis2. 
  d'2 d4 c8 bes 
  a g a4 g2 
  fis4 bes2. 
  d4 d d c8 bes 
  a4 g a d 
  c a2. 
  a4 b cis d2 cis4 d e2 fis2. 
  f2 f4 f2 ees4 d2 
  d4 d2. 
  d4 c bes c2 c4 bes a 
  g d'2. 
  d2 d4 c 
  ees d d ees 
  d8 c b2. 
}


baixo = \relative c {
  g'8 a bes a g4 c, 
  d ees a bes 
  g d'2. 
  d4 g f e 
  fis d g c, 
  d g,2. 
  d'8 e f e d4 a' 
  d, e f bes, 
  c f,2. 
  f'2 e4 d 
  g8 f g a bes4 g 
  a d,2. 
  bes8 c d c bes4 f'2 f4 fis d 
  g d2. 
  bes'4 fis g a2 a,4 bes2 
  c4 d2. 
  d'4 c bes a 
  g fis g c, 
  d g,2. 
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