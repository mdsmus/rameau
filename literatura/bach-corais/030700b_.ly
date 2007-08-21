% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 030700b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. ais''4 |
  % 2
  ais8 c d4 c ais |
  % 3
  c c d ais8 c |
  % 4
  d4 dis f8 dis d4 |
  % 5
  c2 ais4 ais |
  % 6
  ais8 c d4 c ais |
  % 7
  c c d ais8 c |
  % 8
  d4 dis f8 dis d4 |
  % 9
  c2 ais4 d |
  % 10
  d c ais a |
  % 11
  ais8 c d4 c c |
  % 12
  ais a ais f |
  % 13
  ais c d ais8 c |
  % 14
  d4 dis f8 dis d4 |
  % 15
  c2 ais |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'8 dis |
  % 2
  f4 ais a g |
  % 3
  g f f f |
  % 4
  ais ais c ais |
  % 5
  ais a f f8 dis |
  % 6
  f4 ais a g |
  % 7
  g f f f |
  % 8
  ais ais c ais |
  % 9
  ais a f f |
  % 10
  f f8 dis d g g fis |
  % 11
  g a ais4 a a |
  % 12
  a8 g g fis g4 d |
  % 13
  d g fis d |
  % 14
  g g f f |
  % 15
  g f8 dis d2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'8 c |
  % 2
  ais4 f' f8 dis d4 |
  % 3
  c8 ais ais a ais4 d8 dis |
  % 4
  f4 g f f |
  % 5
  g f8 dis d4 d8 c |
  % 6
  ais4 f' f8 dis d4 |
  % 7
  c8 ais ais a ais4 d8 dis |
  % 8
  f4 g f f |
  % 9
  g f8 dis d4 ais |
  % 10
  ais a ais c |
  % 11
  d8 dis f4 f d |
  % 12
  d d d d8 c |
  % 13
  ais a g4 a g8 a |
  % 14
  ais4 ais ais ais |
  % 15
  ais a f2 |
  % 16
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. ais8 c |
  % 2
  d4 c8 ais f'4 g8 f |
  % 3
  dis4 f ais, ais |
  % 4
  ais' a8 g a4 ais |
  % 5
  dis, f ais, ais8 c |
  % 6
  d4 c8 ais f'4 g8 f |
  % 7
  dis4 f ais, ais |
  % 8
  ais' a8 g a4 ais |
  % 9
  dis, f ais, ais8 c |
  % 10
  d dis f4 g a |
  % 11
  g d8 dis f4 fis |
  % 12
  g d g8 a ais a |
  % 13
  g f dis4 d g, |
  % 14
  g' f8 dis d c ais4 |
  % 15
  dis f ais,2 |
  % 16
  
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
