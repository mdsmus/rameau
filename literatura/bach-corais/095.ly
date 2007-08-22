% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 095.mid
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
  d''4 dis f f |
  % 2
  dis d c c |
  % 3
  d dis f dis8 d |
  % 4
  c4. ais8 ais2 |
  % 5
  d4 dis f f |
  % 6
  dis d c c |
  % 7
  d dis f dis8 d |
  % 8
  c4. ais8 ais2 |
  % 9
  c4 d dis dis |
  % 10
  d d c2 |
  % 11
  dis4 f g g |
  % 12
  f f dis2 |
  % 13
  d4 dis f f |
  % 14
  dis d c c |
  % 15
  d dis f dis8 d |
  % 16
  c4. ais8 ais4 ais2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 g8 a ais4 ais |
  % 2
  ais8 a ais4 a a |
  % 3
  ais a8 g f4 g |
  % 4
  g f f2 |
  % 5
  f4 g8 a ais4 ais |
  % 6
  ais8 a ais4 a a |
  % 7
  ais a8 g f4 g |
  % 8
  g f f2 |
  % 9
  f4 f dis8 f g4 |
  % 10
  gis g8 f dis2 |
  % 11
  g4 ais ais8 gis ais g |
  % 12
  c4 ais8 gis g2 |
  % 13
  g4 g f8 dis d4 |
  % 14
  dis f8 g a4 a |
  % 15
  ais a8 g f4 g |
  % 16
  g f f f2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 ais ais8 c d4 |
  % 2
  dis f f f |
  % 3
  f c c8 a ais4 |
  % 4
  ais a d2 |
  % 5
  ais4 ais ais8 c d4 |
  % 6
  dis f f f |
  % 7
  f c c8 a ais4 |
  % 8
  ais a d2 |
  % 9
  a4 b c c |
  % 10
  c b g2 |
  % 11
  c4 d dis dis |
  % 12
  dis d ais2 |
  % 13
  ais4 ais ais ais |
  % 14
  ais8 a ais4 f' f |
  % 15
  f dis d8 c ais4 |
  % 16
  ais a8 dis d4 d2. 
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
  ais'8 a g4 d g |
  % 2
  c, d8 dis f4 f |
  % 3
  ais, c d g8 f |
  % 4
  dis4 f ais,2 |
  % 5
  ais'8 a g4 d g |
  % 6
  c, d8 dis f4 f |
  % 7
  ais, c d g8 f |
  % 8
  dis4 f ais,2 |
  % 9
  f'8 dis d4 c8 d dis c |
  % 10
  f4 g c,2 |
  % 11
  c'4 ais8 gis g f dis4 |
  % 12
  gis ais dis,2 |
  % 13
  g4 f8 dis d4 g |
  % 14
  c, d8 dis f4 f |
  % 15
  ais, c d g8 f |
  % 16
  dis4 f ais, ais2. 
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
