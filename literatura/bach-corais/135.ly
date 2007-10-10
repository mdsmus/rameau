
\version "2.10.33"

\header {
  title = "135 - Gott der Vater wohn uns bei"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  a''4 a b cis 
  d d cis b 
  d a fis g 
  fis e d2 
  a'4 a b cis 
  d d cis b 
  d a fis g 
  fis e d2 
  d4 e fis4. e8 
  d4 e fis d' 
  cis d e4. d8 
  cis4 b a a 
  a d cis a 
  b8 a g4 fis e 
  fis g a4. g8 
  fis4 e d2 
  d4 e fis4. e8 
  d4 e fis d' 
  cis d e4. d8 
  cis4 b a a 
  a d cis a 
  b8 a g4 fis e 
  fis g a4. g8 
  fis4 e d2 
  d4 e fis4. e8 
  d4 e fis a 
  a a fis g 
  fis e d2 
}


alto = \relative c {
  fis'4 fis g g 
  a a8 gis a4 g 
  fis e e8 d4 cis8 
  d4. cis8 a2 
  fis'4 fis g g 
  a a8 gis a4 g 
  fis e e8 d4 cis8 
  d4. cis8 a2 
  a4 a8 e'4 d cis8 
  b4 b cis d8 e 
  fis4 fis8 b4 a16 gis a2 gis4 e e 
  fis fis e d8 e 
  fis4. e4 dis8 e4. d4 cis d e d cis8 a2 
  a4 a8 e'4 d cis8 
  b4 b cis d8 e 
  fis4 fis8 b4 a16 gis a2 gis4 e e 
  fis fis e d8 e 
  fis4. e4 dis8 e4. d4 cis d e d cis8 a2 
  a4 a8 e'4 d cis8 
  d4 b8 e d4 d4. e8 fis e d4. e4 d cis8 a2 
}


tenor = \relative c {
  d'4 d d e 
  fis8 e d4 e e 
  d e8 a, a4 g 
  a4. a16 g fis2 
  d'4 d d e 
  fis8 e d4 e e 
  d e8 a, a4 g 
  a4. a16 g fis2 
  fis4 a a a8 g 
  fis4 b ais b4. a8 fis'4 e cis8 d 
  e4. d8 cis4 cis 
  d a a8 g fis4 
  b b b b8 a 
  a4 g fis8 a b4 
  a4. g8 fis2 
  fis4 a a a8 g 
  fis4 b ais b4. a8 fis'4 e cis8 d 
  e4. d8 cis4 cis 
  d a a8 g fis4 
  b b b b8 a 
  a4 g fis8 a b4 
  a4. g8 fis2 
  a4 a a a 
  a8 fis g a a4 fis8 g 
  a b cis4 d8 cis b4 
  a4. g8 fis2 
}


baixo = \relative c {
  d4 d g8 fis e4 
  d8 cis b4 a e' 
  b cis d e 
  fis8 g a4 d,2 
  d4 d g8 fis e4 
  d8 cis b4 a e' 
  b cis d e 
  fis8 g a4 d,2 
  d4 cis d a 
  b8 a g4 fis b 
  fis' d cis fis 
  e e, a a'8 g 
  fis e d4 a d 
  dis e b cis 
  d e fis g 
  a a, d2 
  d4 cis d a 
  b8 a g4 fis b 
  fis' d cis fis 
  e e, a a'8 g 
  fis e d4 a d 
  dis e b cis 
  d e fis g 
  a a, d2 
  fis4 cis d a'8 g 
  fis d4 cis8 d4 d8 e 
  fis g a4 b8 a g4 
  a a, d2 
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