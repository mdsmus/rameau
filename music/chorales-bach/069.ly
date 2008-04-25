\version "2.10.33"

\header {
  title = "69 - Komm, heiliger Geist, Herre Gott"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key bes \major
}


soprano = \relative c'' {
  \partial 4 f4 
    g4 f8 ees8 d8 ees8 f4 
  c2 d4 e4 
  f2 r4 f4 
  g4 f4 c8 d8 ees4 
  d4 c4 bes4 bes4   %5
  c8 d8 ees4 d8 ees8 f4~ 
  f4 c4 bes8 a8 g4 
  f2 r4 f4 
  bes4 c4 d8 ees8 f4~ 
  f4 ees4 d4 c4   %10
  d2 r4 d8 ees8 
  f4 g4 f4 c4 
  d4 e4 f4 f4 
  g4 f4 c8 d8 ees4 
  d4 c4 bes4 bes4   %15
  c8 d8 ees4 d8 ees8 f4~ 
  f4 c4 bes8 a8 g4 
  f2 r4 f4 
  bes4 c4 d8 ees8 f4~ 
  f4 ees4 d4 c4   %20
  g4 a4 bes4 c4 
  d4 bes4 g2 
  f4 c'8 d16 ees16 d2 
  c2 bes2 
  
}

alto = \relative c'' {
  \partial 4 bes4 
    bes4 a4 bes4 f8 g8 
  a2 bes4 bes4 
  a2 r4 bes4 
  bes4 a8 g8 f4 g8 a8 
  bes4 a4 f4 f4   %5
  f4 g4 f8 g8 a4~ 
  a8 bes8 a8 g8 f8 d8 e4 
  c2 r4 c4 
  f8 g8 a4 bes4. c8 
  d4. c8 bes8 a8 g4   %10
  fis2 r4 bes4 
  a8 b8 c4 c8 bes8 a8 g8 
  f4 g4 a4 bes8 a8 
  g8 a8 bes4 a4 g4 
  f8 g8 a4 f4 g4   %15
  g4 g8 a8 bes2~ 
  bes4 a4 bes8 f4 e8 
  c2 r4 f8 ees8 
  d8 g8 f8 ees8 d4. ees16 f16 
  g4 g4 g4 g8 f8   %20
  ees2 d4 f4 
  f2~ f8 d8 ees4 
  d4 f2 g4~ 
  g4 f8 ees8 d2 
  
}

tenor = \relative c' {
  \partial 4 d4 
    ees8 d8 c4 bes4 bes4 
  f'2 f4 bes,4 
  c2 r4 bes4 
  ees8 d8 c8 bes8 a8 bes8 ees,4 
  f4 f'8 ees8 d4 d4   %5
  c4 bes8 c8 d4 c8 bes8 
  c4 f4 f4 c8 bes8 
  a2 r4 a4 
  bes4 ees4 f8 ees8 d8 c8 
  b8 a8 g4 fis4 g4   %10
  a2 r4 bes8 c8 
  d4 e4 f4. ees8 
  d8 c8 bes4 c4 d4 
  ees4 f4 f4 bes,8 c8 
  d8 bes8 f'8 ees8 d4 ees4   %15
  ees8 d8 c4 d8 c8 bes8 c8 
  d8 e8 f2 c8 bes8 
  a2 r4 a4 
  bes8 ees8 d8 c8 bes4. c8 
  d4. c8 bes8 a8 g4   %20
  c2 bes4 a4 
  bes2. bes8 a8 
  bes4 c2 bes4~ 
  bes4 a16 g16 a8 f2 
  
}

baixo = \relative c' {
  \partial 4 bes4 
    ees,4 f4 g4 d8 ees8 
  f2 bes8 a8 g4 
  f2 r4 d4 
  ees4 f4 ees8 d8 c4 
  d8 ees8 f4 bes,4 bes'4   %5
  a4 g8 a8 bes4 a8 g8 
  a8 g8 f8 e8 d8 bes8 c4 
  f2 r4 f8 ees8 
  d8 ees8 d8 c8 bes4 bes'8 gis8 
  g4 c,4 d4 ees4   %10
  d2 r4 g4 
  d'4 c8 bes8 a8 g8 f4 
  bes8 a8 g4 f4 bes4 
  ees,4 d8 ees8 f4 g8 a8 
  bes8 ees,8 f4 bes,4 ees8 d8   %15
  c4 c'4 g4 d8 ees8 
  f8 g8 a8 f8 d'8 bes8 c4 
  f,2 r4 d4 
  g4 a4 bes8 c8 d8 c8 
  b8 g8 c4 g8 f8 ees8 d8   %20
  ees8 c8 f4 bes,4 f'4 
  bes,8 c8 d4 ees2 
  bes'4 a4 bes8 a8 g8 f8 
  ees8 c8 f4 bes,2 
  
}

\score {
  <<
    \new StaffGroup <<
      \override StaffGroup.SystemStartBracket #'style = #'line 
      \new Staff {
        <<
          \global
          \new Voice = "soprano" { \voiceOne \soprano }
          \new Voice = "alto" { \voiceTwo \alto }
        >>
      }
      \new Staff {
        <<
          \global
          \clef "bass"
          \new Voice = "tenor" {\voiceOne \tenor }
          \new Voice = "baixo" { \voiceTwo \baixo \bar "|."}
        >>
      }
    >>
  >>
  \layout {}
  \midi {}
}