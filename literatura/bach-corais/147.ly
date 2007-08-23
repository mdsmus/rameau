% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 147.mid
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
  dis2 s4 d |
  % 4
  dis d c c |
  % 5
  ais2 s4 ais |
  % 6
  c ais gis g |
  % 7
  f2 s4 g |
  % 8
  dis f g8 gis ais4 |
  % 9
  gis2 g4 d' |
  % 10
  dis d c c |
  % 11
  ais2 s4 dis |
  % 12
  d c ais c |
  % 13
  ais gis g8 gis ais4 |
  % 14
  gis g f2 |
  % 15
  dis1 |
  % 16
  
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
  dis dis dis f |
  % 3
  g2 s4 f |
  % 4
  c' ais8 d, g4 f8 dis |
  % 5
  d2 s4 dis |
  % 6
  dis d dis8 ais ais4 |
  % 7
  ais2 s4 d4. c4 ais8 ais4 dis |
  % 9
  dis8 f16 dis d4 dis f |
  % 10
  g8 f f4 g f8 dis |
  % 11
  d2 s4 g |
  % 12
  g dis dis dis |
  % 13
  f8 g4 f dis8 dis4 |
  % 14
  dis2 dis4 d |
  % 15
  ais1 |
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
  s2. g'8 gis |
  % 2
  ais c cis4 c8 ais gis4 |
  % 3
  ais2 s4 ais4. a8 ais2 a4 |
  % 5
  f2 s4 ais4. gis4 g f dis8 |
  % 7
  d2 s4 g |
  % 8
  g f dis ais' |
  % 9
  c ais ais d |
  % 10
  c ais ais a |
  % 11
  f2 s4 c'4. ais4 gis g8 g4 |
  % 13
  d'8 c c4 c ais |
  % 14
  dis,8 f g dis c'4 ais8 gis |
  % 15
  g1 |
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
  s2. dis8 f |
  % 2
  g4 g gis8 g f4 |
  % 3
  dis2 s4 ais |
  % 4
  c g' dis f |
  % 5
  ais,2 s4 g |
  % 6
  gis ais c8 d dis4 |
  % 7
  ais2 s4 b |
  % 8
  c d dis g, |
  % 9
  f ais dis, ais''4. a8 ais4 dis, f |
  % 11
  ais,2 s4 c |
  % 12
  g' gis dis c |
  % 13
  d8 e f4 c g |
  % 14
  c ais gis ais |
  % 15
  dis,1 |
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
