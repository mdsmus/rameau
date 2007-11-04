\version "2.10.33"

\header {
  title = "230 - Christ, der du bist der helle Tag"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key g \minor
}


soprano = \relative c'' {
  \partial 4 g4 
    g4 bes4 a4 g4 
  bes4 c4 d4 d4 
  d4 d8 ees8 f8 ees8 d4 
  c4 c4 bes4 bes4 
  bes4 d4 c4 a4   %5
  bes4 c4 d4 d4 
  d4 d4 c4 c4 
  bes4. a16 g16 f4 f4 
  bes8 c8 d4 c4 d4 
  bes4 a4 g2   %10
  
}

alto = \relative c' {
  \partial 4 d4 
    d8 e8 f8 g8 f8 ees8 d4 
  g8 f8 ees8 f8 f4 f4 
  f4 g4 a4 bes4~ 
  bes8 a16 g16 a4 f4 g4 
  g8 a8 bes4 bes8 a16 g16 f4   %5
  f4 f4 f4 f4 
  f4 f4 f8. ees16 d4~ 
  d4 e4 d4 d4 
  g8 a8 bes4 bes4 a4~ 
  a8 g4 fis8 d2   %10
  
}

tenor = \relative c' {
  \partial 4 bes4 
    bes4 d8 c8 c4 bes8 a8 
  g16 a16 bes4 a8 bes4 bes8 c8 
  d8 c8 bes4 c4 bes8 d8 
  g4 f8 ees8 d4 d4 
  ees4 f4 f4 c4   %5
  bes4. a8 bes4 bes4 
  bes4 bes4. a8 a4~ 
  a8 g8 g8 a16 bes16 a4 bes8 c8 
  d8 c8 bes8 a8 g4 d'4 
  d8 ees8 a8 d8 bes2   %10
  
}

baixo = \relative c {
  \partial 4 g4 
    g'4 d8 e8 f8 fis8 g8 f8 
  ees8 d8 c8 f8 bes,4 bes4 
  bes'8 a8 g4 f4 g8 f8 
  ees4 f4 bes,4 g'8 f8 
  ees8 d8 c8 bes8 f'4. ees8   %5
  d8 bes8 f'4 bes,4 bes4 
  bes8 c8 d8 ees8 f4 fis8 d8 
  g4 cis,4 d4 bes8 a8 
  g4 g'8 f8 e4 fis4 
  g8 c,8 d4 g,2   %10
  
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