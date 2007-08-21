% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 032100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d''4 ais d dis2 d4 c2 |
  % 3
  ais4 c2 c4 |
  % 4
  d d d g,2 a4 ais2 |
  % 6
  ais4 a2. |
  % 7
  d4 ais d dis2 d4 c2 |
  % 9
  ais4 c2 c4 |
  % 10
  d d d g,2 a4 ais2 |
  % 12
  ais4 a2. |
  % 13
  f4 c' c c2 d4 dis2 |
  % 15
  dis4 d2. |
  % 16
  f4 f f dis2. d4 d |
  % 18
  c ais2. |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 f ais2 |
  % 2
  a4 f g f4. e8 a2 a4 |
  % 4
  ais f8 a g f e2 f e8 d |
  % 6
  e4 f2. |
  % 7
  f4 f ais2 |
  % 8
  a4 f g f4. e8 a2 a4 |
  % 10
  ais f8 a g f e2 f e8 d |
  % 12
  e4 f2. |
  % 13
  c4 c e f2 ais a8 g |
  % 15
  a4 ais2. |
  % 16
  f4 ais8 a ais4 g |
  % 17
  c a ais ais4. a8 f2. |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 ais f' dis |
  % 2
  c ais2 a4 |
  % 3
  ais f'2 f4 |
  % 4
  f ais,8 c d4 c2 c4 d ais |
  % 6
  c c2. |
  % 7
  ais4 ais f' dis |
  % 8
  c ais2 a4 |
  % 9
  ais f'2 f4 |
  % 10
  f ais,8 c d4 c2 c4 d ais |
  % 12
  c c2. |
  % 13
  a4 g g a2 f'4 g dis |
  % 15
  f f2. |
  % 16
  d4 ais8 c d4 c2 f4 f2 |
  % 18
  f8. dis16 d2. |
  % 19
  
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
  ais4 d ais c |
  % 2
  f ais e f |
  % 3
  g f2 f4 |
  % 4
  ais, d ais c |
  % 5
  ais a g2 |
  % 6
  c4 f,2. |
  % 7
  ais4 d ais c |
  % 8
  f ais e f |
  % 9
  g f2 f4 |
  % 10
  ais, d ais c |
  % 11
  ais a g2 |
  % 12
  c4 f,2. |
  % 13
  f'4 e c f |
  % 14
  dis d c2 |
  % 15
  f4 ais,2. |
  % 16
  ais4 d ais c |
  % 17
  a f ais d |
  % 18
  f ais,2. |
  % 19
  
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
