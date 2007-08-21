% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024526b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key ees \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. dis'4 |
  % 2
  ais' ais c d |
  % 3
  dis2 dis4 g |
  % 4
  f dis dis d |
  % 5
  dis2. dis,4 |
  % 6
  ais' ais c d |
  % 7
  dis2 dis4 g |
  % 8
  f dis dis d |
  % 9
  dis2. dis8 f |
  % 10
  g4 g f dis |
  % 11
  d8 c d4 ais d |
  % 12
  dis d c c |
  % 13
  ais2. ais4 |
  % 14
  g8 gis ais4 c ais |
  % 15
  ais gis g ais |
  % 16
  gis g f f |
  % 17
  dis1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. ais'4 |
  % 2
  dis g gis g |
  % 3
  g2 g4 c |
  % 4
  c gis g f |
  % 5
  g2. ais,4 |
  % 6
  dis g gis g |
  % 7
  g2 g4 c |
  % 8
  c gis g f |
  % 9
  g2. g8 gis |
  % 10
  ais4 c c a |
  % 11
  ais8 a ais4 f ais |
  % 12
  ais ais ais a |
  % 13
  f2. f4 |
  % 14
  dis8 f g4 gis g |
  % 15
  g f dis dis |
  % 16
  dis dis dis d |
  % 17
  ais1 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. g'4 |
  % 2
  ais dis dis d |
  % 3
  c2 c4 dis |
  % 4
  c c ais ais |
  % 5
  ais2. g4 |
  % 6
  ais dis dis d |
  % 7
  c2 c4 dis |
  % 8
  c c ais ais |
  % 9
  ais2. ais4 |
  % 10
  dis dis f f |
  % 11
  f8 dis f4 d f |
  % 12
  dis f g f8 dis |
  % 13
  d2. ais4 |
  % 14
  ais dis dis cis |
  % 15
  c2 c4 g |
  % 16
  gis ais c ais8 gis |
  % 17
  g1 |
  % 18
  
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
  s2. dis4 |
  % 2
  g dis gis b, |
  % 3
  c2 c4 c' |
  % 4
  gis f ais ais, |
  % 5
  dis2. dis4 |
  % 6
  g dis gis b, |
  % 7
  c2 c4 c' |
  % 8
  gis f ais ais, |
  % 9
  dis2. dis4 |
  % 10
  dis'8 d c ais a4 f |
  % 11
  ais2 ais,4 gis' |
  % 12
  g f dis f |
  % 13
  ais,2. d4 |
  % 14
  dis cis c8 d e4 |
  % 15
  f2 c4 cis |
  % 16
  c ais a ais |
  % 17
  dis,1 |
  % 18
  
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
