% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 263.mid
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
  b'4 cis d b |
  % 4
  e2 dis |
  % 5
  e8 fis g4 fis4. fis8 |
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
  e8 fis g4 fis4. fis8 |
  % 12
  e1 |
  % 13
  b4 b c b |
  % 14
  a4. a8 g2 |
  % 15
  b4 cis d b |
  % 16
  e d8 cis cis2 |
  % 17
  b b4 b |
  % 18
  a g8 fis fis2 |
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
  g'8 fis e4 d d |
  % 4
  g8 a b4 b2 |
  % 5
  g8 a b4 b4. a8 |
  % 6
  g1 |
  % 7
  g4 fis e8 dis e4 |
  % 8
  e dis b2 |
  % 9
  g'8 fis e4 d d |
  % 10
  g8 a b4 b2 |
  % 11
  g8 a b4 b4. a8 |
  % 12
  g1 |
  % 13
  g4 g a g |
  % 14
  g fis d2 |
  % 15
  g4 g a g8 a |
  % 16
  b4 b b ais |
  % 17
  fis2 g4 fis |
  % 18
  e e e dis |
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
  e'4 b c8 fis, g4 |
  % 2
  c b8 a g2 |
  % 3
  e'8 d cis b a4 g8 a |
  % 4
  b4 g' fis2 |
  % 5
  e4 e e dis |
  % 6
  b1 |
  % 7
  e4 b c8 fis, g4 |
  % 8
  c b8 a g2 |
  % 9
  e'8 d cis b a4 g8 a |
  % 10
  b4 g' fis2 |
  % 11
  e4 e e dis |
  % 12
  b1 |
  % 13
  e4 d d d |
  % 14
  e d8 c b2 |
  % 15
  d4 e d d |
  % 16
  g fis g fis8 e |
  % 17
  dis2 e4 fis8 g |
  % 18
  a a, b4 c b8 a |
  % 19
  gis1 |
  % 20
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  e4 d c4. b8 |
  % 2
  a4 b e2 |
  % 3
  e4 a8 g fis4 g8 fis |
  % 4
  e fis g a b2 |
  % 5
  c4 b8 a b4 b, |
  % 6
  e1 |
  % 7
  e4 d c4. b8 |
  % 8
  a4 b e2 |
  % 9
  e4 a8 g fis4 g8 fis |
  % 10
  e fis g a b2 |
  % 11
  c4 b8 a b4 b, |
  % 12
  e1 |
  % 13
  e8 fis g4 fis g |
  % 14
  c, d g,2 |
  % 15
  g'4 fis8 e fis4 g8 fis |
  % 16
  e4 b e fis |
  % 17
  b,2 e4 d |
  % 18
  c b a b |
  % 19
  e1 |
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
