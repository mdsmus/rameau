\version "2.10.33"

\header {
  title = "197 - Christ ist erstanden"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key c \major
}


soprano = \relative c'' {
  \partial 4 a4 
    g4 a8 b8 c4 d4 
  a2 a4 f8 g8 
  a8 g8 f4 e8 d8 e4 
  d2 r4 f4 
  g4 g4 d4 c4   %5
  f4 g4 a4 a8 g8 
  f4 g4 a8 g8 f4 
  e4 d4 e2 
  d4 d4 d2 
  d1   %10
  a'4 a4 g4 a8 ais8 
  c4 d4 a4 a4 
  a8. g16 f8 g8 a8 g8 f4 
  e8 d8 e4 d4 f4 
  g4 g4 d4 c4   %15
  f4 g4 a4 a4 
  a8 g8 f8. g16 a4 f4 
  e4 d4 e2 
  d4 d4 d2 
  d1   %20
  a'4 f4 c'4 a4 
  c8 ais8 a4 g4 f4 
  a8 g8 f4 e4 d4 
  f4 g4 g4 d4 
  c4 f4 g4 a4   %25
  a8 g8 f4 g4 a4 
  f4 e4 d4 e4~ 
  e4 d4 d4 d4~ 
  d4 d2.~ 
  d4 
}

alto = \relative c' {
  f4. e8 e8 gis8 a4~ 
  a8 g4 f16 e16 f4 e4 
  d4 c8 cis8 d4 cis8 d8~ 
  d8 cis8 a2 r4 
  d4. c16 b16 c4. b8~   %5
  b8 a16 ais16 c8 d8 e4 f4 
  e4. d4 cis8 d4~ 
  d8 c8 ais8 a4 b8 cis4~ 
  cis4 d4 c4 c4 
  ais2 a8 g8 a4~   %10
  a4 f'4 e8 d8 g8 ais8 
  a8 g8 f2 f4 
  f4 e4 d8 e8 f8 cis8 
  d2 cis4 d4 
  c4 c8 b8 c4. ais8~   %15
  ais8 a16 g16 c4 c4 c4 
  c8 cis8 d4 a4 d4 
  d4. c4 b8 c4~ 
  c4 c8 ais8 a4 g4~ 
  g8 ais8 a2.~   %20
  a4 e'4 d4 c4 
  c4 c8 d8 e8 f4 e8 
  c4 e4. d4 c8~ 
  c8 ais8 c4 d4 c8 g8 
  a8 b8 c8 ais8 a16 g16 a8 d8 c8   %25
  c4 f8 e8 d4. c16 ais16 
  a4. d16 c16 b8 a4 gis8 
  cis2 d4 c4 
  ais8 a8 g16 a16 ais4 a8 ais8 g8 
  a2 
}

tenor = \relative c' {
  \partial 4 d8  c8 
    b4 c8 d8 e8 f16 e16 d4 
  d2 a4 a4 
  a4 a4 ais8 f8 g8 a16 g16 
  f2 r4 a4 
  e8 f8 g4~ g16 d16 e4 f16 g16   %5
  a8 f8 ais4 c4 a4 
  a4 g8 ais8 a4~ a16 g16 a8 
  g16 f16 g8 f16 e16 f8 e2 
  a8 g8 a8 fis8 g8 d8 g4~ 
  g4 fis8 e8 fis2   %10
  d'4 c8 b8 c4 c4 
  c4. ais8 c4 c8 d8 
  e8 a,4 g8 f8 g8 a4 
  a4. g8 f4 a4 
  g8 f8 g4 g8. f16 e4   %15
  a4 g4 f4 a8 g8 
  f8 e8 d8 e8 f8 g8 a4 
  a8 e8 f4 g2 
  a8 g4 fis8 g8 d8 g4~ 
  g4 fis8 e8 fis2   %20
  a4. ais8 a8 g8 f4 
  f4 c'4. ais8 a4 
  a4 a4 g8 a8 d,4 
  a'8 f8 d16 e16 f4 e8 fis8 gis8 
  a8 g8 f16 e16 f4 e8 f4   %25
  c'4. ais16 a16 g4. f16 e16 
  f8 ais16 a16 gis8 a8 d8 d,8 a'4~ 
  a4 f8 g8 a4. g16 fis16 
  g4. fis8 g8 e8 fis4~ 
  fis4 
}

baixo = \relative c {
  \partial 4 d4 
    e8. d16 c8 b8 a4 ais8. c16 
  d2 cis4 d8 e8 
  f4. f,8 g8 ais8 a4 
  d2 r4 d,4 
  e4. f8 g8 gis8 a4~   %5
  a8 ais8 a8 g8 f4 cis'4 
  d4 e4 f8 e8 d4~ 
  d8 cis8 d4 a2 
  fis8 e8 fis8 d8 g8 a8 ais8 g8 
  d'2 d,2   %10
  d'8 e8 f4. e8 f8 g8 
  a8 f8 ais4 f4 f4 
  cis4 d4. e8 f8 g8 
  a4 a,4 ais4 a4 
  e8 d8 e8 f8 g4 a4~   %15
  a8 g8 f8 e8 f4 f'8 e8 
  d2~ d8 e8 f8 g8 
  a8 a,8 d4 c2 
  fis,8 g8 c4. ais16 a16 ais8 g8 
  d'2 d,2   %20
  cis'4 d4 e4 f4 
  a,8 ais8 c4 c,4 f4 
  cis'4 d8 d,8 e8 fis8 g4 
  a4 b4 c4. b8 
  a4. d8 ais8 c8 f4   %25
  f,4 ais4 dis8 d8 cis4 
  d4. c8 b4 a4~ 
  a4 ais8 a8 g8 fis8 g8 a8 
  ais8 g8 d2.~ 
  d4 
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