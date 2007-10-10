
\version "2.10.33"

\header {
  title = "185 - Ihr lieben Christen, freut euch nun"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 d'4 
  d c f g 
  a4. gis8 a4 b 
  c b c a 
  b8 d4 cis8 d4 d 
  c a f d 
  e d cis e 
  g8 f e4 f d 
  e4. e8 d2 
}


alto = \relative c {
  \partial 4 a'4 
  a8 b c4 d e 
  e e e g 
  g g g4. f16 e 
  d4 e fis g8 f 
  e4 c c ais 
  b8 a b4 a cis 
  d a a ais 
  b8 d4 cis8 a2 
}


tenor = \relative c {
  \partial 4 f4 
  f g a8 f c'4. b16 a b8 d c4 d 
  e f8 d c4 c8 d16 c 
  b8 a g a a4 d 
  g,4. f8 f4 f 
  g f8 e e4 a 
  g4. g8 f4 f 
  g8 ais a8. g16 fis2 
}


baixo = \relative c {
  \partial 4 d8 e 
  f4. e8 d4 c8 b 
  a4 e' a, g'8 f 
  e c d f e c f d 
  g f e a d,4 b 
  c8 e f4 a,8 f ais a 
  g4 gis a a 
  b cis d8 c ais a 
  g4 a d,2 
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