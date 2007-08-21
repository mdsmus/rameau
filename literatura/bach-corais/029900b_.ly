% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 029900b_.mid
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
  s2 f'4 ais |
  % 2
  d8 c d ais g'4 dis2 f4 ais, dis |
  % 4
  c2 ais4 c |
  % 5
  dis d c d8 c |
  % 6
  d ais a ais ais4. c8 |
  % 7
  c2 f,4 ais |
  % 8
  d8 c d ais g'4 dis2 f4 ais, dis |
  % 10
  c2 ais4 c |
  % 11
  dis d c d8 c |
  % 12
  d ais a ais ais4. c8 |
  % 13
  c2 a4 ais |
  % 14
  c d g, g'8 dis |
  % 15
  c b c d d4. dis8 |
  % 16
  dis2 c4 a |
  % 17
  ais8 a g f f'4. ais,8 |
  % 18
  g'4. f8 dis d c ais |
  % 19
  ais2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 d'4 f |
  % 2
  ais8 a ais4 ais g2 f4 g8 a ais4 |
  % 4
  ais a f f |
  % 5
  f4. g8 a4 ais8 a |
  % 6
  ais4 dis, f8 dis f e |
  % 7
  f2 d4 f |
  % 8
  ais8 a ais4 ais g2 f4 g8 a ais4 |
  % 10
  ais a f f |
  % 11
  f4. g8 a4 ais8 a |
  % 12
  ais4 dis, f8 dis f e |
  % 13
  f2 f4 f2 f4 dis4. g8 |
  % 15
  dis d dis4 gis g |
  % 16
  g2 g4 f |
  % 17
  g a ais4. ais8 |
  % 18
  ais4 ais ais a |
  % 19
  f2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 ais'4 ais |
  % 2
  f'8 dis f4 dis ais8 a |
  % 3
  ais c d2 g4 |
  % 4
  f4. dis8 d4 c8 ais |
  % 5
  c a ais4 c f, |
  % 6
  f c' ais f8 g |
  % 7
  a2 ais4 ais |
  % 8
  f'8 dis f4 dis ais8 a |
  % 9
  ais c d2 g4 |
  % 10
  f4. dis8 d4 c8 ais |
  % 11
  c a ais4 c f, |
  % 12
  f c' ais f8 g |
  % 13
  a2 c4 f, |
  % 14
  a ais ais4. ais8 |
  % 15
  c4. c8 c4 b |
  % 16
  c2 c4 c2 c4 d4. d8 |
  % 18
  dis4 ais f' dis8 d |
  % 19
  d2. 
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
  s2 ais'4 d, |
  % 2
  c ais dis g8 f |
  % 3
  g dis ais' a g4 dis |
  % 4
  f2 ais,4 a'8 g |
  % 5
  a f ais4 f dis |
  % 6
  d c d8 c d ais |
  % 7
  f2 ais'4 d, |
  % 8
  c ais dis g8 f |
  % 9
  g dis ais' a g4 dis |
  % 10
  f2 ais,4 a'8 g |
  % 11
  a f ais4 f dis |
  % 12
  d c d8 c d ais |
  % 13
  f2 f'8 dis d4 |
  % 14
  dis8 d c ais dis4. dis8 |
  % 15
  gis4. g8 f4 g |
  % 16
  c,2 dis4 f2 dis4 d g8 f |
  % 18
  dis d dis4 f f, |
  % 19
  ais2. 
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
