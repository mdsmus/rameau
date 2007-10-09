
\version "2.10.33"

\header {
  title = "335 - Es ist das Heil uns kommen her"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 c''4 
  c c c8 d dis4 
  d c bes c8 bes 
  a g f g a4 b 
  c8. d16 d4 c c 
  c c c8 d dis4 
  d c bes c8 bes 
  a g f g a4 b 
  c8. d16 d4 c c 
  f e d e 
  f8 e d4 c c 
  f c d a8 bes 
  c4 bes a a 
  g8 a bes4 a g 
  d e f2 
}


alto = \relative c {
  \partial 4 f'4 
  f e f g 
  f f8 dis d4 c 
  c c f8 a g f 
  e8. f16 g8. f16 e4 f 
  f e f g 
  f f8 dis d4 c 
  c c f8 a g f 
  e8. f16 g8. f16 e4 f8 g 
  a4 g g8 f e g 
  c, a' d, g e4 f8 g 
  a bes a g f4 f 
  e d8 e fis4 f 
  e d c8 d e4 
  d c8 bes a2 
}


tenor = \relative c {
  \partial 4 a'8 bes 
  c d c bes a4 g8 a 
  bes4 a bes g 
  f8 g a bes c4 d 
  g,8 c4 b8 c4 a8 bes 
  c d c bes a4 g8 a 
  bes4 a bes g 
  f8 g a bes c4 d 
  g,8 c4 b8 c4 a 
  a8 b c4 b8 a g4 
  f8 c' b4 c a8 bes 
  c4 f8 e d4 d 
  g,8 a bes c d4 c 
  c f,8 g a bes c4 
  bes8 a g4 f2 
}


baixo = \relative c {
  \partial 4 f4 
  a,8 bes c4 f, c' 
  d8 dis f4 g e 
  f f, f'8 e d4 
  c g c f 
  a,8 bes c4 f, c' 
  d8 dis f4 g e 
  f f, f'8 e d4 
  c g c f8 e 
  d4 e8 f g4 c,8 bes 
  a f g4 c f 
  f,8 g a4 bes8 c d4 
  e8 fis g4 d a8 bes 
  c4 d8 e f4 e8 f 
  g4 c, f,2 
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