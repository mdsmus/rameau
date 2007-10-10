
\version "2.10.33"

\header {
  title = "68 - Wenn wir in höchsten Nöten sein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 
  f g a g8 a 
  bes4 a g4. g8 
  f2 s4 a 
  bes a g f 
  e f g c 
  bes a g8 f e4 
  f d c a' 
  bes a g f 
  a g f2 
}


alto = \relative c {
  \partial 4 c'4. b8 c4. d8 e4 
  f8 g4 f e16 d e4 
  c2 s4 f4. g4 f e8 d4 
  g, c c e8 fis 
  g e f e d4. c4 d16 c b4 g f'8 dis 
  d e f4. e4 d16 e 
  f4. e8 c2 
}


tenor = \relative c {
  \partial 4 a'8 g 
  f4 c'8 bes a bes c4 
  f,8 c' c4 d8 bes g c16 bes 
  a2 s4 c 
  d8 c c4 d8 c4 b8 
  c4 f, e a 
  d8 cis d4 g, g 
  a g8 f e4 c' 
  bes c16*7 bes16 a8 bes 
  c4 c8. bes16 a2 
}


baixo = \relative c {
  \partial 4 f8 e 
  d4 e8 c f4 c 
  d8 e f4 bes, c 
  f,2 s4 f'8 dis 
  d e f4 b,8 c d4 
  c8 bes a f c'4 a 
  g d'8 c b4 c 
  f, g c f, 
  g a8 bes c4 d 
  a8 bes c4 f,2 
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