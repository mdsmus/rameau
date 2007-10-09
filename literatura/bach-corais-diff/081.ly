% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 081.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  e''4 e e e |
  % 2
  d c b2 |
  % 3
  c4 d e e |
  % 4
  d c b2 |
  % 5
  a4 b c a |
  % 6
  a8 g f4 e2 |
  % 7
  f4 g a a |
  % 8
  g f e2 |
  % 9
  a4 gis a b |
  % 10
  c b a2 |
  % 11
  c4 d e e |
  % 12
  d c b2 |
  % 13
  a4 b c a |
  % 14
  a8 g f4 e2 |
  % 15
  f4 g a a |
  % 16
  g f e1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelB = \relative c {
  gis''4 gis a b |
  % 2
  a a gis2 |
  % 3
  e8 fis g4 g f8 e |
  % 4
  f4 e e2 |
  % 5
  e4 e e f |
  % 6
  e d cis2 |
  % 7
  d4 e dis d |
  % 8
  d2 cis |
  % 9
  dis4 e e fis8 gis |
  % 10
  a4 g fis2 |
  % 11
  g4 g g f |
  % 12
  f e8 fis g2 |
  % 13
  a4 e e e |
  % 14
  a, d cis2 |
  % 15
  d4 e f f |
  % 16
  e d2 c4 |
  % 17
  b1 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
>>


trackDchannelB = \relative c {
  b'4 b c b8 c |
  % 2
  d e f4 b,2 |
  % 3
  a4 ais ais a |
  % 4
  a2 gis |
  % 5
  c4 b a8 b c d |
  % 6
  e4 a, a2 |
  % 7
  a4 c c c |
  % 8
  ais8 c d4 a2 |
  % 9
  a4 b c d |
  % 10
  e d d2 |
  % 11
  c4 ais a a |
  % 12
  a8 b c4 d2 |
  % 13
  d8 c b4 a8 b c d |
  % 14
  e4 a, a2 |
  % 15
  a4 c c c |
  % 16
  c8 b a4 gis a |
  % 17
  gis1 |
  % 18
  
}

trackD = <<

  \clef bass
  
  \context Voice = channelA \trackDchannelA
>>


trackEchannelB = \relative c {
  e4 e a g |
  % 2
  f e8 d e2 |
  % 3
  a4 g cis, cis |
  % 4
  d a e'2 |
  % 5
  a4 gis a f |
  % 6
  cis d a2 |
  % 7
  d4 c f, fis |
  % 8
  g gis a2 |
  % 9
  f'4 e8 d c4 b |
  % 10
  a b8 c d2 |
  % 11
  dis4 d cis d8 e |
  % 12
  f g a4 g2 |
  % 13
  fis4 gis a a,8 b |
  % 14
  cis4 d a2 |
  % 15
  d4 c f,8 g a b |
  % 16
  c4 d e1. 
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
  >>
}
