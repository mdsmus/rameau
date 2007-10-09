
\version "2.10.33"

\header {
  title = "187 - Komm, Gott Schöpfer, heiliger Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 g''4 
  a g f g 
  c d c c 
  g b c d 
  e e d d 
  e8 d c4 a g 
  b cis d g, 
  c a f a 
  g2 g 
}


alto = \relative c {
  \partial 4 d'8 e 
  f4. e4 d16 c b8 e4 c8 g' f e4 c8 d 
  e4 f g g 
  g4. fis8 g4 g 
  g g4. f4 e8 
  g4 g a e 
  e8 d e4. d16 e f2 e4 d2 
}


tenor = \relative c {
  \partial 4 b'4 
  c c a g8 c16 b 
  c8 f b,4 g a 
  b8 c d4 e d4. c16 b c8 a b4 b 
  c8 b c4 c c 
  d e f b, 
  a a a8 ais c4 
  d4. c4 b4. 
}


baixo = \relative c {
  \partial 4 g'4 
  f c d e 
  a, g c f 
  e d c4. b8 
  c4 c, g' g' 
  c, e f c' 
  g8 f e4 d e 
  a,8 b c4 d a 
  b c g2 
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