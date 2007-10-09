
\version "2.10.33"

\header {
  title = "161 - Ihr Gestirn, ihr hohen Lüfte"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \minor
}

soprano = \relative c {
  d'2 e4 f2 g4 a2 
  d4 cis2 cis4 
  d2 e4 f2. f,4 g4. g8 f2. 
  d2 e4 f2 g4 a2 
  d4 cis2 cis4 
  d2 e4 f2. f,4 g4. g8 f2. 
  g2 g4 a2 c4 bes2 
  g4 a2 a4 
  c2 c4 d2 f4 e d 
  cis d2 d2. 
}


alto = \relative c {
  a'2 cis4 d2 e4 f4. g8 
  a4 a2 a4 
  a2 a4 a4. g8 f e f2 
  e4 c2. 
  a2 cis4 d2 e4 f4. g8 
  a4 a2 a4 
  a2 a4 a4. g8 f e f2 
  e4 c2. 
  e4 f g g8 f4 e8 f4 f e8 d 
  e4 f2 f4 
  a2 a8 g f e 
  f g a4 bes8 g f e 
  e g fis2 fis4 
  f2 
}


tenor = \relative c {
  f8 g a4 g a2 bes4 c d8 e 
  f4 e2 e4 
  f2 e4 d8 cis 
  d e d c bes a d4 
  c8. bes16 a2. 
  f8 g a4 g a2 bes4 c d8 e 
  f4 e2 e4 
  f2 e4 d8 cis 
  d e d c bes a d4 
  c8. bes16 a2. 
  c2 c4 c4. bes8 a4 d2 
  c4 c2 c4 
  f2 f8 dis d2 c4 bes b 
  a a2 a2. 
}


baixo = \relative c {
  d8 e f g f e d4 
  c8 bes a g f g f e 
  d4 a'2 a4 
  d8 e f e d cis d8*7 c8 bes4 
  c f,2. 
  d'8 e f g f e d4 
  c8 bes a g f g f e 
  d4 a'2 a4 
  d8 e f e d cis d8*7 c8 bes4 
  c f,2. 
  c'4 d e f 
  g a g g, 
  c f2 f4 
  f f,8 g a4 bes 
  bes' a g gis 
  a d,2 d2. 
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