% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 212.mid
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
  dis'4 dis ais' ais |
  % 2
  c d dis2 |
  % 3
  d4. dis8 f4 ais, |
  % 4
  dis d c2 |
  % 5
  ais dis4 dis |
  % 6
  ais ais gis gis |
  % 7
  g2 ais4 ais |
  % 8
  gis g f2 |
  % 9
  dis f4 f |
  % 10
  g8 a ais4 ais a |
  % 11
  ais2 c4 d |
  % 12
  dis2 ais4 ais |
  % 13
  gis g f2 |
  % 14
  dis1 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  ais'4 ais dis g8 f |
  % 2
  dis4 f g2 |
  % 3
  f4 ais4. gis8 g4. f8 f4 g f8 dis |
  % 5
  d2 g4 g |
  % 6
  f f8 g4 c,8 f dis16 d |
  % 7
  dis2 f4 dis |
  % 8
  f4. dis8 dis4 d |
  % 9
  ais2 d4 d |
  % 10
  dis f8 g f4 f |
  % 11
  f2 f8 gis4 g8 |
  % 12
  g2 f8 gis4 g8 |
  % 13
  f4. dis4 d16 c d4 |
  % 14
  ais1 |
  % 15
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 g8 gis ais dis4 cis8 |
  % 2
  c ais gis4 ais2 |
  % 3
  ais4 ais ais ais4. a8 ais2 a4 |
  % 5
  f2 ais4 ais8 c |
  % 6
  d4. c8 c4 ais |
  % 7
  ais2 d8 c ais4 |
  % 8
  ais ais c8 f, ais gis |
  % 9
  g2 ais4. gis8 |
  % 10
  ais c d4 c8 d dis4 |
  % 11
  d2 c8 f d4 |
  % 12
  c2 f4. dis4 d16 c ais4 c ais8 gis |
  % 14
  g1 |
  % 15
  
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
  dis4. f8 g4 dis |
  % 2
  gis8 g f4 dis2 |
  % 3
  ais'8 gis g4 d dis8 d |
  % 4
  c f ais, d dis c f4 |
  % 5
  ais,2 dis,8 f g gis |
  % 6
  ais c d dis f dis d ais |
  % 7
  dis2 ais'8 gis g f |
  % 8
  dis d dis4 gis, ais |
  % 9
  dis,2 ais''8 gis g f |
  % 10
  dis4 d8 dis f2 |
  % 11
  ais, gis'4 b, |
  % 12
  c2 d4 dis |
  % 13
  f g gis ais8 ais, |
  % 14
  dis1 |
  % 15
  
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
