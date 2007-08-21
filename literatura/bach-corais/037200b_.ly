% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 037200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  \skip 1*2 
  \time 2/4 
  \skip 2 |
  % 4
  
  \time 4/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g fis g |
  % 2
  a ais a2 |
  % 3
  g g4 g |
  % 4
  fis g a ais |
  % 5
  a2 g |
  % 6
  ais4 a g ais |
  % 7
  a g fis2 |
  % 8
  f4 dis d g |
  % 9
  g fis g2 |
  % 10
  ais4 c d d |
  % 11
  c ais c2 |
  % 12
  ais ais4 c |
  % 13
  d d c ais |
  % 14
  c2 ais |
  % 15
  ais4 a g ais |
  % 16
  a g fis2 |
  % 17
  f4 dis d g |
  % 18
  g fis g1 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d d |
  % 2
  dis8 d d g g4 fis |
  % 3
  d2 d4 d |
  % 4
  d d dis8 d d g |
  % 5
  g4 fis d2 |
  % 6
  g4 g8 fis g4 g8 f |
  % 7
  dis d e4 d2 |
  % 8
  a8 ais c4 ais8 c d4 |
  % 9
  dis d d2 |
  % 10
  g4 a ais ais8 gis |
  % 11
  g f f4 g f8 dis |
  % 12
  d2 f4 f |
  % 13
  f f f8 dis d4 |
  % 14
  g f8 dis d2 |
  % 15
  d4 d8 c ais4 dis8 d |
  % 16
  c d d4 d2 |
  % 17
  d4 d8 c16 ais a4 d |
  % 18
  dis d d1 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 ais a ais |
  % 2
  c ais8 d dis4 d8 c |
  % 3
  ais2 ais4 ais |
  % 4
  a ais c ais8 d |
  % 5
  dis4 d8 c ais2 |
  % 6
  d4 d8. c16 ais8 c d4 |
  % 7
  c ais8 a a2 |
  % 8
  f4 f f ais |
  % 9
  a16*5 ais16 c8 ais2 |
  % 10
  d4 f f f |
  % 11
  dis8 c d ais4 a16 g a4 |
  % 12
  ais2 d4 c |
  % 13
  c8 ais16 a ais4 a ais |
  % 14
  ais a f2 |
  % 15
  g4 fis g g |
  % 16
  a ais a2 |
  % 17
  g4 g fis g8 ais |
  % 18
  a4. c8 b1 
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
  g8 a ais c d c ais g |
  % 2
  fis4 g c d |
  % 3
  ais2 g8 a ais c |
  % 4
  d c ais g fis4 g |
  % 5
  c d ais2 |
  % 6
  g'4 d dis ais |
  % 7
  c cis d2 |
  % 8
  d8 c ais a ais a g ais |
  % 9
  c a d4 g,2 |
  % 10
  g'4 f8 dis d c ais4. a8 ais d dis c f4 |
  % 12
  ais,2 ais4. a8 |
  % 13
  ais f' ais4 f g8 f |
  % 14
  dis4 f ais,2 |
  % 15
  g4 d' dis4. e8 |
  % 16
  f fis g g, d'2 |
  % 17
  b4 c4. ais16 a ais8 g |
  % 18
  c a d4 g,1 
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
