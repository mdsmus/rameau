
\version "2.10.33"

\header {
  title = "47 - Vater unser im Himmelreich"
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
  f g a a8 b 
  c4 d8 e f4 e 
  d cis d d 
  e d c b 
  a gis a d 
  c b c a 
  a g f a 
  bes a8 g f4 g 
  f e d2 
}


alto = \relative c {
  \partial 4 f'4 
  e d cis d8 e 
  f4 cis a f' 
  e d e f 
  f e8 d e4 e 
  a g f g 
  f8 e e4 f f 
  e b' e, e8 d 
  c d e4 e g 
  g f g f 
  f e c d 
  d e d d 
  d cis a2 
}


tenor = \relative c {
  \partial 4 d'4 
  a a g d' 
  d a f d' 
  a bes c c 
  d8 cis d4 cis c 
  c8 a b cis d c bes4 
  b a a b4. a4 gis8 a4 gis 
  a b c b 
  c d e d 
  d8 c bes4 a a 
  g8 f e4 a g8 a 
  b4 e,8 f16 g fis2 
}


baixo = \relative c {
  \partial 4 d4 
  cis d e f8 g 
  a4 a, d d 
  c bes a8 c f4 
  bes bes a a8 g 
  f4. e8 d4 g 
  gis a d, g 
  c, b a e' 
  f e a, g'8 f 
  e4 d c d8 c 
  bes4 c f, fis' 
  g cis, d8 c bes a 
  gis4 a d2 
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