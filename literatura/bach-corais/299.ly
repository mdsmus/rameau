% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 299.mid
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
  ais''4 ais c c |
  % 2
  d d8 dis16 f dis2 |
  % 3
  f4 f dis dis |
  % 4
  d c8 d16 dis c2 |
  % 5
  ais ais4 ais |
  % 6
  c c ais gis8 g |
  % 7
  g2 ais4 ais |
  % 8
  gis gis g f8 g16 gis |
  % 9
  f2 dis |
  % 10
  ais'4 ais c c |
  % 11
  d d8 dis16 f dis2 |
  % 12
  ais4 ais8 c16 cis c8 ais gis g |
  % 13
  f g16 gis f4 dis2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''4 g dis gis |
  % 2
  gis8 g gis4 g2 |
  % 3
  ais4 ais8 gis g4. a8 |
  % 4
  ais a g dis f4. dis8 |
  % 5
  d2 dis4 dis |
  % 6
  dis gis gis8 g f4 |
  % 7
  e2 e8 f g e |
  % 8
  c4 f8 d dis4 dis |
  % 9
  dis d ais2 |
  % 10
  g'4 g gis gis8 g |
  % 11
  f4 g g2 |
  % 12
  dis4 dis dis8 d dis4 |
  % 13
  dis d ais2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  dis'4 dis c f |
  % 2
  f8 dis f d ais2 |
  % 3
  d8 dis f d d c16 b c4 |
  % 4
  ais ais ais8 g a4 |
  % 5
  f2 g8 gis ais g |
  % 6
  gis ais c4 f,8 g gis ais |
  % 7
  c2 ais8 gis g4 |
  % 8
  gis ais ais c8 gis |
  % 9
  ais g gis4 g2 |
  % 10
  dis'4 dis dis f |
  % 11
  b,8 c d b c2 |
  % 12
  g4 g gis8 f dis ais' |
  % 13
  c4 ais8 gis g2 |
  % 14
  
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
  dis8 f g dis gis g gis f |
  % 2
  ais4 ais, dis2 |
  % 3
  ais8 c d ais c d dis f |
  % 4
  g f dis c f4 f, |
  % 5
  ais2 dis8 f g dis |
  % 6
  gis g f dis d e f4 |
  % 7
  c2 g'8 f e c |
  % 8
  f dis d ais dis g gis f |
  % 9
  ais4 ais, dis2 |
  % 10
  dis'8 cis c ais gis g f dis |
  % 11
  d c b g c2 |
  % 12
  dis8 cis c ais gis ais c ais |
  % 13
  gis4 ais dis2 |
  % 14
  
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
