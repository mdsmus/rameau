% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 027.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. ais''4 |
  % 2
  ais a8 g f4 ais |
  % 3
  c d ais f |
  % 4
  ais c d dis |
  % 5
  c8 ais c4 ais ais |
  % 6
  ais a8 g f4 ais |
  % 7
  c d ais f |
  % 8
  ais c d dis |
  % 9
  c8 ais c4 ais ais |
  % 10
  g a ais8 a g4 |
  % 11
  f e f f |
  % 12
  ais c d dis |
  % 13
  d c d c |
  % 14
  d dis f8 dis d4 |
  % 15
  c8 ais c4 ais2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  f dis d d |
  % 3
  dis f dis c |
  % 4
  f f f g |
  % 5
  f2 f4 f |
  % 6
  f dis d d |
  % 7
  dis f dis c |
  % 8
  f f f g |
  % 9
  f2 f4 f |
  % 10
  e f2 e8 d |
  % 11
  c4 c c c |
  % 12
  f8 g a4 ais c4. ais4 a8 ais4 f |
  % 14
  f g a f |
  % 15
  f2 f |
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
  s2. d'4 |
  % 2
  d c4. ais8 ais4. a8 ais gis g4 a |
  % 4
  ais dis d8 c ais4. a16 g a4 d d |
  % 6
  d c4. ais8 ais4. a8 ais gis g4 a |
  % 8
  ais dis d8 c ais4. a16 g a4 d d |
  % 10
  c c d g,8 a16 ais |
  % 11
  c8 ais16 a g8 a16 ais a4 a |
  % 12
  ais dis f g8 f |
  % 13
  f4 f f f8 dis |
  % 14
  d c ais4 c4. ais4 a16 g a4 d2 |
  % 16
  
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
  s2. ais4 |
  % 2
  ais c d g |
  % 3
  f ais, dis dis |
  % 4
  d a ais dis |
  % 5
  f2 ais,4 ais |
  % 6
  ais c d g |
  % 7
  f ais, dis dis |
  % 8
  d a ais dis |
  % 9
  f2 ais,4 ais2 a4 g c8 ais |
  % 11
  a ais c4 f, f'8 dis |
  % 12
  d dis d c ais ais'4 a8 |
  % 13
  ais4 f ais, a' |
  % 14
  ais8 a g4 f ais |
  % 15
  f2 ais, |
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
