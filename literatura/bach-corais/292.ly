
\version "2.10.33"

\header {
  title = "292 - Vater unser im Himmelreich"
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
  c d8 e f4 e 
  d cis d d 
  e d c b 
  a b a d 
  c b c a 
  a g f a 
  bes a8 g f4 g 
  f e d2 
}


alto = \relative c {
  \partial 4 f'4 
  e d d d 
  d cis a f' 
  f g8 f e4 f 
  d d cis d 
  e g a g 
  f8 g a4 a g 
  g fis8 gis a4 e 
  e8 a a gis e4 d 
  e f g f 
  f e c d 
  d cis d e 
  cis8 d4 cis8 a2 
}


tenor = \relative c {
  \partial 4 d'4 
  a a bes a 
  bes e f d' 
  c c c c 
  bes d, e f 
  a bes c bes8 c 
  d4 e f b, 
  c8 b a4 d d 
  c d c g 
  g d' c c 
  d g, a a 
  g8 f e4 bes8*5 a8 g a fis2 
}


baixo = \relative c {
  \partial 4 d4 
  cis d bes' f 
  g a d, d8 e 
  f4 e a f 
  bes bes, a d 
  a' g f g8 a 
  bes4 a d, g 
  c, d8 e fis4 gis 
  a e a, b 
  c d e f 
  bes, c f, fis 
  g a bes a8 g 
  a4 a d2 
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