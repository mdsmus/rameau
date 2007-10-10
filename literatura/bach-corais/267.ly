
\version "2.10.33"

\header {
  title = "267 - Vater unser im Himmelreich"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a f g a 
  f e d a' 
  a g c a 
  f g a a 
  c d f e 
  d cis d d 
  e d c b 
  a b a d 
  c b c8 bes a4 
  a g f a 
  bes a a g 
  f e d2 
}


alto = \relative c {
  \partial 4 f'4 
  e d d8 cis d4 
  d cis a e' 
  d4. e8 f4 cis 
  d d cis e 
  f a g a8 g 
  f4 e fis g 
  g8 a b4 a gis 
  a4. gis8 e4 e 
  e8 f g4 g f 
  f4. e8 f4 fis 
  g8 f e4 d8 cis d e 
  a, d d cis a2 
}


tenor = \relative c {
  \partial 4 d'4 
  a a g f8 g 
  a4 a8 g f4 a 
  bes8 c d4 c8 d e4 
  a, bes e c'8 bes 
  a4 f'8 e d4 e 
  a, a a b 
  c f e d 
  c f8 e cis4 b 
  c d c c 
  d4. c8 gis4 dis' 
  d4. cis8 d2 
  d8 a bes a fis2 
}


baixo = \relative c {
  \partial 4 d4 
  cis d e d8 e 
  f g a a, d4 c 
  bes bes' a8 g f e 
  d c bes4 a a'8 g 
  f e d c b4 cis 
  d a d g 
  c8 b a gis a g f e 
  f e d e a,4 gis 
  a8 a' g f e4 f8 e 
  d c bes c cis4 c 
  g a bes8 a b cis 
  d f g a d,2 
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