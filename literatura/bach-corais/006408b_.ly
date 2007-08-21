% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006408b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  b''4 b a g |
  % 2
  fis2 e |
  % 3
  b'4 b cis dis |
  % 4
  e2 dis |
  % 5
  e4 g fis4. e8 |
  % 6
  e1 |
  % 7
  b4 b a g |
  % 8
  fis2 e |
  % 9
  b'4 b cis dis |
  % 10
  e2 dis |
  % 11
  e4 g fis4. e8 |
  % 12
  e1 |
  % 13
  b4 b c b |
  % 14
  a4. g8 g2 |
  % 15
  b4 cis d b |
  % 16
  e d cis2 |
  % 17
  b b4 b |
  % 18
  a g fis2 |
  % 19
  e1 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''4 g8 fis e4 e |
  % 2
  e dis b2 |
  % 3
  g'4 g a8 g fis4 |
  % 4
  e fis fis2 |
  % 5
  g8 a b4 b a |
  % 6
  g1 |
  % 7
  g4 g8 fis e4 e |
  % 8
  e dis b2 |
  % 9
  g'4 g a8 g fis4 |
  % 10
  e fis fis2 |
  % 11
  g8 a b4 b a |
  % 12
  g1 |
  % 13
  g8 fis e dis e fis g4 |
  % 14
  g fis d2 |
  % 15
  g4 g fis fis |
  % 16
  g fis fis4. e8 |
  % 17
  dis2 d8 e f4 |
  % 18
  e8 fis g e e4 dis |
  % 19
  b1 |
  % 20
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  e'4 d c b |
  % 2
  c b8 a g2 |
  % 3
  e'4 d a8 b c4 |
  % 4
  b cis b2 |
  % 5
  b4 e e dis |
  % 6
  b1 |
  % 7
  e4 d c b |
  % 8
  c b8 a g2 |
  % 9
  e'4 d a8 b c4 |
  % 10
  b cis b2 |
  % 11
  b4 e e dis |
  % 12
  b1 |
  % 13
  e4 b a g |
  % 14
  e' d b2 |
  % 15
  d4 e ais, b |
  % 16
  ais b b ais |
  % 17
  fis2 gis4 gis |
  % 18
  a8 c b4 cis b8 a |
  % 19
  gis1 |
  % 20
  
}

trackD = <<

  \clef bass
  
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  e8 fis g4 c,8 d e4 |
  % 2
  a, b e2 |
  % 3
  e8 fis g4 fis8 g a4 |
  % 4
  gis ais b2 |
  % 5
  g8 fis e4 b' b, |
  % 6
  e1 |
  % 7
  e8 fis g4 c,8 d e4 |
  % 8
  a, b e2 |
  % 9
  e8 fis g4 fis8 g a4 |
  % 10
  gis ais b2 |
  % 11
  g8 fis e4 b' b, |
  % 12
  e1 |
  % 13
  e8 fis g4 c,8 d e4 |
  % 14
  cis d g,2 |
  % 15
  g'8 fis e4 fis8 e d4 |
  % 16
  cis d8 e fis2 |
  % 17
  b, b8 cis d4 |
  % 18
  cis8 dis e4 ais, b |
  % 19
  e,1 |
  % 20
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
  >>
}
