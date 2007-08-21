% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 008107b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 92 
  
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
  b'4 cis d b |
  % 4
  e2 dis |
  % 5
  e4 g fis fis |
  % 6
  e1 |
  % 7
  b4 b a g |
  % 8
  fis2 e |
  % 9
  b'4 cis d b |
  % 10
  e2 dis |
  % 11
  e4 g fis fis |
  % 12
  e1 |
  % 13
  b4 b c b |
  % 14
  a a g2 |
  % 15
  b4 cis d b |
  % 16
  e d8 cis cis2 |
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
  g''4 fis e8 dis e4 |
  % 2
  e dis b2 |
  % 3
  g'8 fis e4 fis d |
  % 4
  g a b2 |
  % 5
  b4 b c b8 a |
  % 6
  g1 |
  % 7
  g4 fis e8 dis e4 |
  % 8
  e dis b2 |
  % 9
  g'8 fis e4 fis d |
  % 10
  g a b2 |
  % 11
  b4 b c b8 a |
  % 12
  g1 |
  % 13
  g4 fis e d8 g |
  % 14
  g4 fis d2 |
  % 15
  d4 g fis fis |
  % 16
  g fis fis4. e8 |
  % 17
  dis2 e4 e8 dis |
  % 18
  e fis g e e4 dis |
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
  e'4 b c c8 b |
  % 2
  c4 b8 a g2 |
  % 3
  e'8 d cis b a4 g8 a |
  % 4
  b4 e fis2 |
  % 5
  b,4 e e dis |
  % 6
  b1 |
  % 7
  e4 b c c8 b |
  % 8
  c4 b8 a g2 |
  % 9
  e'8 d cis b a4 g8 a |
  % 10
  b4 e fis2 |
  % 11
  b,4 e e dis |
  % 12
  b1 |
  % 13
  e4 b8 a g a b4 |
  % 14
  e d8 c b2 |
  % 15
  b4 b ais b |
  % 16
  ais b b ais |
  % 17
  fis2 g8 a b4 |
  % 18
  c b cis b8 a |
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
  e4 d c8 b a g |
  % 2
  a4 b e,2 |
  % 3
  e'4 a8 g fis4 g8 fis |
  % 4
  e g c4 b2 |
  % 5
  g8 fis e4 a b |
  % 6
  e,1 |
  % 7
  e4 d c8 b a g |
  % 8
  a4 b e,2 |
  % 9
  e'4 a8 g fis4 g8 fis |
  % 10
  e g c4 b2 |
  % 11
  g8 fis e4 a b |
  % 12
  e,1 |
  % 13
  e4 dis e8 fis g4 |
  % 14
  cis, d g,2 |
  % 15
  g'4 fis8 e fis4 e8 d |
  % 16
  cis4 d8 e fis2 |
  % 17
  b, e8 fis g e |
  % 18
  c d e c ais4 b |
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
