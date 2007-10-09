
\version "2.10.33"

\header {
  title = "340 - Lobet Gott, unsern Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 d'8 e 
  f4 e f g 
  a2 a4 c 
  b a a gis 
  a2. d,8 e 
  f4 e f g 
  a2 a4 c 
  b a a gis 
  a2. a4 
  b c d8 c b4 
  c4. bes8 a4 a 
  g f f e 
  f2. a8 g 
  f4 g a g 
  f2 e4 f 
  g f e2 
  d2. 
}


alto = \relative c {
  \partial 4 d'8 cis 
  d4 bes a d8 c 
  c2 c4 c 
  f fis e e 
  e2. d8 cis 
  d4 bes a d8 c 
  c2 c4 c 
  f fis e e 
  e2. e8 fis 
  gis4 a a g 
  g f8 g f4 f8 dis 
  d4 d c c 
  c2. e4 
  f4. e8 f4. e4 d8 d4 cis d4. cis8 d2 cis4 
  a2. 
}


tenor = \relative c {
  \partial 4 a'8 g 
  a4 g f f8 e 
  f2 f4 g 
  gis c b8 c d4 
  c2. a8 g 
  a4 g f f8 e 
  f2 f4 g 
  gis c b8 c d4 
  c2. c4 
  d e d d 
  c8 e d c c4 c 
  bes gis g4. a16 bes 
  a2. a4 
  a d8 c c4 d8 e 
  a, gis a b a4 a 
  g a a4. g8 
  f2. 
}


baixo = \relative c {
  \partial 4 f8 e 
  d4. cis8 d c bes c 
  f,2 f4 e' 
  d dis e e, 
  a2. f'8 e 
  d4. cis8 d c bes c 
  f,2 f4 e' 
  d dis e e, 
  a2. a'2 a8 g fis4 g8 f 
  e c d e f4 f, 
  bes b c c, 
  f2. cis'4 
  d8 c bes c f, a b cis 
  d bes a gis a4 d 
  e f8 g a4 a, 
  d2. 
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