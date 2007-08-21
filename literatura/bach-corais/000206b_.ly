% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000206b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  ais a g d' |
  % 3
  d8 c ais4 a c |
  % 4
  ais a g c |
  % 5
  ais a g a |
  % 6
  ais a g d' |
  % 7
  d8 c ais4 a c |
  % 8
  ais a g c |
  % 9
  ais a g g |
  % 10
  a f e d8 e |
  % 11
  f4 g a f |
  % 12
  g8 a ais4 a ais |
  % 13
  g fis g g |
  % 14
  d' ais c d |
  % 15
  c ais a2 |
  % 16
  a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  g fis g ais |
  % 3
  a g fis gis |
  % 4
  g fis cis d |
  % 5
  d2 d4 fis |
  % 6
  g fis g ais |
  % 7
  a g fis gis |
  % 8
  g fis cis d |
  % 9
  d2 d4 d |
  % 10
  e d cis d |
  % 11
  d d e d8 c |
  % 12
  ais c d4 c d |
  % 13
  d8 dis d4 d d |
  % 14
  d d dis f |
  % 15
  dis d cis8 d4 cis8 |
  % 16
  d2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  d c d g |
  % 3
  d d d dis |
  % 4
  e d8 c ais4 a |
  % 5
  g fis16 a c8 ais4 d |
  % 6
  d c d g |
  % 7
  d d d dis |
  % 8
  e d8 c ais4 a |
  % 9
  g fis16 a c8 ais4 ais |
  % 10
  a a a a |
  % 11
  a d cis a |
  % 12
  g f8 g a g fis4 |
  % 13
  g8 c a4 ais ais |
  % 14
  a g g g |
  % 15
  g8*5 f8 e4 |
  % 16
  fis2. 
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
  s2. d4 |
  % 2
  g a ais a8 g |
  % 3
  fis4 g d c |
  % 4
  cis d e fis |
  % 5
  g d g, d' |
  % 6
  g a ais a8 g |
  % 7
  fis4 g d c |
  % 8
  cis d e fis |
  % 9
  g d g, g' |
  % 10
  cis, d a'8 g f e |
  % 11
  d c ais4 a d |
  % 12
  dis d8 e f dis d c |
  % 13
  ais c d4 g, g' |
  % 14
  fis g8 f dis d c b |
  % 15
  c4 g a2 |
  % 16
  d2. 
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
