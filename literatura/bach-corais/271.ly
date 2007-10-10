
\version "2.10.33"

\header {
  title = "271 - Gib dich zufrieden und sei stille"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  g a8 b16 c b4. a8 
  g4 fis8 g16 a g4. fis8 
  e2 c'4 b 
  e d fis,8 c' b a 
  a2 g4 b 
  g a8 b16 c b4. a8 
  g4 fis8 g16 a g4. fis8 
  e2 c'4 b 
  e d fis,8 c' b a 
  a2 g4 b 
  a b8 g a4 b8 c 
  d4 c8 b c b a4 
  s4 c fis, e'8 dis 
  e d c b a g' fis e 
  dis cis b4 s4 e 
  c b8 a b dis, e a 
  g4 fis8 e e2 
}


alto = \relative c {
  \partial 4 e'4 
  e fis8 g16 a g8 dis e fis 
  fis e e dis e4. dis8 
  e2 g4. fis8 
  e fis fis g fis4 g 
  g fis d e 
  e fis8 g16 a g8 dis e fis 
  fis e e dis e4. dis8 
  e2 g4. fis8 
  e fis fis g fis4 g 
  g fis d g 
  a8 fis g e fis4 e 
  d e e8 d e4 
  s4 e dis8 e fis4 
  e8 fis g fis e4 a8 b16 c 
  fis,8 e dis4 s4 e 
  e4. fis8 dis fis e e 
  e4 dis b2 
}


tenor = \relative c {
  \partial 4 g'4 
  b c8 fis, g a b c 
  b4 b b8 g a4 
  g2 g8 a b4 
  b8 a a b c4 d 
  e d8 c b4 g 
  b c8 fis, g a b c 
  b4 b b8 g a4 
  g2 g8 a b4 
  b8 a a b c4 d 
  e d8 c b4 d 
  d d8 cis d4 gis,8 a 
  a b gis4 a8 b c4 
  s4 c b4. c8 
  b a g gis a b c4 
  b fis s4 b 
  a8 b c4 fis,8 a b a 
  b4 a8 g g2 
}


baixo = \relative c {
  \partial 4 e4 
  e8 dis e dis e fis g a 
  b4 b, e2 
  e e4. d8 
  c c'4 b8 a4 g 
  c, d g, e' 
  e8 dis e dis e fis g a 
  b4 b, e2 
  e e4. d8 
  c c'4 b8 a4 g 
  c, d g, g' 
  fis8 d g4 d8 e d c 
  b4 e a a, 
  s4 a' b8 c b a 
  g fis e d c b a4 
  b b s4 gis' 
  a8 a, a'4. fis8 g c, 
  b a b4 e2 
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