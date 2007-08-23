% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 022.mid
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
  g''4 f dis f |
  % 2
  g8 gis ais4 gis2 |
  % 3
  g ais4 g |
  % 4
  gis g8 f dis f g4 |
  % 5
  f2 dis |
  % 6
  g4 f dis f |
  % 7
  g8 gis ais4 gis2 |
  % 8
  g ais4 g |
  % 9
  gis g8 f dis f g4 |
  % 10
  f2 dis |
  % 11
  ais'4 c8 d dis4 dis |
  % 12
  d8 c ais c c2 |
  % 13
  ais ais4 c8 d |
  % 14
  dis4 dis d8 c ais c |
  % 15
  c2 ais |
  % 16
  f4 g gis gis |
  % 17
  g8 ais gis g f4 f |
  % 18
  ais g gis g8 f |
  % 19
  dis f g4 f2 |
  % 20
  dis1 |
  % 21
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  dis'4 d c ais |
  % 2
  ais dis2 d4 |
  % 3
  dis2 f4 dis |
  % 4
  dis dis8 d c d dis2 d4 ais2 |
  % 6
  dis4 d c ais |
  % 7
  ais dis2 d4 |
  % 8
  dis2 f4 dis |
  % 9
  dis dis8 d c d dis2 d4 ais2 |
  % 11
  g'4 f dis8 f g4 |
  % 12
  g d g f8 dis |
  % 13
  d2 dis4 dis8 f |
  % 14
  g4 g f f8 g |
  % 15
  f dis16 d dis4 d2 |
  % 16
  d4 dis d8 dis f4 |
  % 17
  dis8 g f dis d4 d |
  % 18
  d dis4. d8 dis d |
  % 19
  c d dis2 d4 |
  % 20
  ais1 |
  % 21
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 ais8 gis g4 f |
  % 2
  dis8 f g4 f8 dis f4 |
  % 3
  dis2 ais'4 ais |
  % 4
  c ais c ais |
  % 5
  ais8 gis16 g gis4 g2 |
  % 6
  ais4 ais8 gis g4 f |
  % 7
  dis8 f g4 f8 dis f4 |
  % 8
  dis2 ais'4 ais |
  % 9
  c ais c ais |
  % 10
  ais8 gis16 g gis4 g2 |
  % 11
  dis'4 a8 b c4 c |
  % 12
  ais8 a ais2 a4 |
  % 13
  ais2 g4 gis |
  % 14
  ais8 a ais c d dis f ais, |
  % 15
  ais4 a ais2 |
  % 16
  ais4 ais gis8 g f4 |
  % 17
  ais c d8 c ais4 |
  % 18
  ais ais gis ais |
  % 19
  c ais ais8 gis16 g gis4 |
  % 20
  g1 |
  % 21
  
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
  dis4 ais c d |
  % 2
  dis g,8 gis ais2 |
  % 3
  dis, d'4 dis |
  % 4
  c8 d dis4 gis, g8 gis |
  % 5
  ais2 dis, |
  % 6
  dis'4 ais c d |
  % 7
  dis g,8 gis ais2 |
  % 8
  dis, d'4 dis |
  % 9
  c8 d dis4 gis, g8 gis |
  % 10
  ais2 dis, |
  % 11
  dis'4 d c8 d dis f |
  % 12
  g4. f8 dis4 f |
  % 13
  ais,2 dis4 gis, |
  % 14
  g8 f g a ais c d dis |
  % 15
  f4 f, ais2 |
  % 16
  ais'4 gis8 g f4 dis8 d |
  % 17
  dis4 gis, ais ais |
  % 18
  g c f, g |
  % 19
  gis g8 gis ais2 |
  % 20
  dis,1 |
  % 21
  
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
