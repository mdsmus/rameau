
\version "2.10.33"

\header {
  title = "337 - O Gott, du frommer Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 a''4 
  a bes8 c16 d c4 bes16 a bes8 
  a4 a8 bes c4 f, 
  g a g2 
  f4 a a bes8 c16 d 
  c4 bes a a8 bes 
  c4 f, g a8. bes16 
  g2 f4 g 
  g a bes bes8. c16 
  a4 a g c8 d16 dis 
  d4 c8 b c4 c 
  c8 bes a4 bes c8 d16 dis 
  d4 g, a a 
  g g f2 
}

alto = \relative c {
  \partial 4 e'8 f16 g 
  f4 f f8 e16 d e4 
  f f g8 e f4 
  e f d e 
  c f f f8 g 
  e f4 e8 f4 f 
  f8 dis d4 e f 
  f e c d 
  e f4. e16 d e4 
  f dis d g 
  f8 gis g f e4 g 
  f f f f 
  f e c f2 e4 c2 
}

tenor = \relative c {
  \partial 4 cis'4 
  d d8 bes a g16 f g4 
  c c8 d e4 a,8 f 
  c'4 c bes g 
  a c d d8 bes4 a8 g c c4 f,8 g 
  a g f4 c' c 
  c8 bes16 a bes8 g a4 d8 b 
  c4 c d8 c16 bes c4 
  c c b c 
  c8 f d4 c e 
  c c d c 
  bes bes a d 
  d8 g, a bes a2 
}

baixo = \relative c {
  \partial 4 a4 
  d8 c bes4 c c 
  f, f' e d 
  c8 bes a f bes g c c, 
  f4 f'8 e d c bes g 
  c4 c f, d' 
  a bes bes'8 a g f 
  c4 c f b,8 g 
  c4 bes8 a g4 c 
  f fis f dis8 f16 g 
  gis8 g16 f g8 g, c4 c'8 bes 
  a g f dis d c bes a 
  bes4 c f8 e d c 
  bes b c4 f2 
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