
\version "2.10.33"

\header {
  title = "344 - Vom Himmel hoch, da komm ich her"
  composer = "J. S. Bach"
}

global =  {
  \time 12/8 
  \key g \major
}

soprano = \relative c {
  \partial 4. g'''4. fis e fis d 
  e fis g g g d d4 c8 b4 c8 
  d4. c b b e e d4 e8 fis4. 
  g4 fis8 e4. d g fis e d e4 d8 
  c4 b8 a4. g2. 
}


alto = \relative c {
  \partial 4. b''4. a b4 a8 a4. g 
  g4 c8 b4 a8 b4. b b b a g 
  a4 e8 e8. g16 fis8 g4. g g g4 a8 b4 a8 a4 b8 
  b4 a8 b4 a8 a4. b c4 b8 b4 a8 a4 g8 g4. 
  g g4 fis8 d2. 
}


tenor = \relative c {
  \partial 4. d'4. d d4 cis8 d4 c8 c4 b8 
  b4 a8 d4. d d e fis4 g8 d4. d4 e8 
  a,4 b8 c8. e16 dis8 e4. e e4 d8 c4. b4 cis8 d4. 
  g,4 d'8 d4 cis8 fis4. e e4 d8 d4 c8 c4 b8 c4 b8 
  c4 d8 e4 d8 b2. 
}


baixo = \relative c {
  \partial 4. g'4. d' g,4 a8 d,4. g 
  c, d g, g'4 fis8 e4. b' fis g4 e8 
  fis4 gis8 a4. e e4 d8 c4 d8 e4 c8 g'4. fis4 b8 
  e,4 fis8 g4 a8 d,4. e4 g8 a4 b8 g4 a8 fis4 g8 c,4 d8 
  e4 d8 c4 d8 g,2. 
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