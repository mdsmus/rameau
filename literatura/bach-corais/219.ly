
\version "2.10.33"

\header {
  title = "219 - Ach, wie groß ist Gottes Güt und Wohltat"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  d''4 a c d8 e 
  f4 e d c 
  bes2 a 
  f'4 d c a8 bes 
  c4. c8 a4 bes 
  g2 f4 a 
  g f e2 
  d a'4 c 
  d a c a 
  g f e2 
  d1 
}


alto = \relative c {
  f'8 g a4 e f8 g 
  a4 a8. g16 f4 f 
  d8 bes c4 c2 
  f4 f8 d g e c4 
  f e f8 a g f4 e16 d e4 c f4. e4 d cis16 b cis4 
  d2 c8 d e4 
  f8 g a f g e f4 
  e d d cis 
  a1 
}


tenor = \relative c {
  a'4 d c8 bes a4 
  d4. c4 bes a g8 f e f2 
  c'8 a d bes g4 f8 g 
  a4 g f8 c' d4 
  c8 g c bes a4 c 
  c8. bes16 a4 bes8 e a g 
  f2 f4 g 
  a d c c 
  bes a8 bes bes g e a16 g 
  fis1 
}


baixo = \relative c {
  d8 e f g a g f e 
  d4 a' bes f 
  g c, f2 
  a8 f bes4 e8 c f4. a,8 bes c d c bes4 
  c c, f f' 
  c d g, a 
  bes2 f'4 e 
  d8 e f d e c f e 
  d cis d bes g e a4 
  d,1 
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