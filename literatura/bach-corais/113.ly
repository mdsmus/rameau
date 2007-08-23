% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 113.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  f''4 f f f |
  % 2
  dis cis c2 |
  % 3
  cis4 dis f f |
  % 4
  dis cis c2 |
  % 5
  ais4 c cis ais |
  % 6
  ais8 gis fis4 f2 |
  % 7
  fis4 gis ais ais |
  % 8
  gis fis f2 |
  % 9
  ais4 a ais c |
  % 10
  cis c8 ais ais2 |
  % 11
  cis4 dis f f |
  % 12
  dis cis8 c c2 |
  % 13
  ais4 c cis8 c ais4 |
  % 14
  ais8 gis fis4 f2 |
  % 15
  fis4 gis ais ais |
  % 16
  gis fis f1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''4 a ais c |
  % 2
  ais ais a2 |
  % 3
  f4 fis gis gis |
  % 4
  fis f f2 |
  % 5
  f4 f f fis |
  % 6
  f dis d2 |
  % 7
  dis4 dis e e |
  % 8
  dis2 d |
  % 9
  f4 dis f fis |
  % 10
  f f fis2 |
  % 11
  gis4 gis gis ais |
  % 12
  ais2 a |
  % 13
  f4 f f fis |
  % 14
  f dis d2 |
  % 15
  dis4 f fis fis |
  % 16
  f dis2 cis4 |
  % 17
  c1 |
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
  c'4 c cis c8 cis |
  % 2
  dis f fis4 c2 |
  % 3
  ais4 ais b ais |
  % 4
  ais2 a |
  % 5
  cis4 c ais8 c cis dis |
  % 6
  f ais, ais4 ais2 |
  % 7
  ais4 b cis cis |
  % 8
  b8 cis dis4 ais2 |
  % 9
  cis4 c ais ais |
  % 10
  ais8 gis cis4 cis2 |
  % 11
  f4 c cis cis |
  % 12
  dis8 f fis4 f2 |
  % 13
  ais,4 a ais8 c cis dis |
  % 14
  f ais, ais4 ais2 |
  % 15
  ais4 cis cis cis |
  % 16
  cis8 b ais4 a ais |
  % 17
  a1 |
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
  f4 f ais gis |
  % 2
  fis f8 dis f2 |
  % 3
  ais4 fis d d |
  % 4
  dis ais f'2 |
  % 5
  ais4 a ais fis |
  % 6
  d dis ais2 |
  % 7
  dis4 b g g |
  % 8
  gis a ais2 |
  % 9
  ais4 c cis dis |
  % 10
  f cis fis2 |
  % 11
  f4 gis cis8 c ais gis |
  % 12
  fis4 f8 dis f2 |
  % 13
  cis4 f ais8 gis fis4 |
  % 14
  d dis ais2 |
  % 15
  dis4 cis fis,8 gis ais b |
  % 16
  cis4 dis f1. 
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
