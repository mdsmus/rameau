
\version "2.10.33"

\header {
  title = "319 - Heilig, heilig, heilig"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  c''4 a g2 
  f c'4 d 
  c2 f4 f 
  e e d4. c8 
  c2 c4 d 
  c bes a2 
  s4 g a8 b c4 
  c b c2 
  c4 d bes bes 
  a bes a g 
  f2 s4 a 
  g2 f4 c' 
  c b c f 
  f e d2 
  c c4 d8 c 
  bes4 bes a bes8 a 
  g2 f 
}


alto = \relative c {
  f'4 f4. e16 d e4 
  c2 g'4 g 
  g2 f4 g 
  g e8 f16 g a4. g16 f 
  e2 f4 f 
  e d8 c c2 
  s4 e8 g f4 e 
  a8 g16 f g4 g2 
  a4 a4. g16 f g4. f16 e f4. e16 d e4 
  c2 s4 f 
  f e d g 
  a g8 f e4 f 
  g g a g8 f 
  e2 f4 f8 e 
  d4 c c8 d16 e f4. e16 d e4 c2 
}


tenor = \relative c {
  a'8 bes c4. g8 c bes 
  a2 c4. b8 
  e2 a,4 d4. c16 b c4. b16 a b4 
  g2 a4 bes8 a 
  g4 f8 g a2 
  s4 c c c 
  d4. e16 f e2 
  f4 f d c 
  c bes8 d c4. bes8 
  a2 s4 c 
  c4. bes8 a4 g 
  d' d c c 
  d4. c4 b16 a b4 
  g2 a4 a 
  bes8 a g4 f8 a d4. bes8 g c a2 
}


baixo = \relative c {
  f,8 g a bes c2 
  f, e'8 c g' g, 
  c2 d8 c b g 
  c e a g f d g g, 
  c2 f4 bes, 
  c d8 e f2 
  s4 c8 e f g a g 
  f d g g, c2 
  f8 e d f g f e c 
  f e d bes c4 c, 
  f2 s4 f' 
  c2 d4 e 
  f g a a 
  b c f, g 
  c,2 f8 e d f 
  g f e c f e d c 
  bes g c4 f,2 
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