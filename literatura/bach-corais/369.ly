% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 369.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \minor
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  f''4 f c cis |
  % 2
  dis cis8 c c4 ais |
  % 3
  cis cis c ais |
  % 4
  a ais c2 |
  % 5
  f4 f c cis |
  % 6
  dis cis8 c c4 ais |
  % 7
  cis cis c ais |
  % 8
  a ais c2 |
  % 9
  c4 cis dis8 cis c4 |
  % 10
  cis c8 ais ais4 gis |
  % 11
  cis dis f8 dis cis4 |
  % 12
  fis f dis cis |
  % 13
  c cis dis f |
  % 14
  dis cis c2 |
  % 15
  ais4 c cis dis8 cis |
  % 16
  c4. c8 ais2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  ais''4 f8 g a4 f |
  % 2
  dis8 f fis4 f8 dis cis4 |
  % 3
  f ais8 gis fis f f dis |
  % 4
  dis c f g a2 |
  % 5
  ais4 f8 g a4 f |
  % 6
  dis8 f fis4 f8 dis cis4 |
  % 7
  f ais8 gis fis f f dis |
  % 8
  dis c f g a2 |
  % 9
  a4 ais ais gis |
  % 10
  gis8 g gis4 g dis |
  % 11
  ais' gis gis ais8 gis |
  % 12
  ais c cis4 gis8 fis f4 |
  % 13
  gis gis gis gis8 ais |
  % 14
  c4 ais a2 |
  % 15
  ais4 f f dis8 f |
  % 16
  fis4 f8 dis d2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  cis'8 c ais4 f'8 dis cis c |
  % 2
  ais4 c a f |
  % 3
  ais ais ais8 a ais4 |
  % 4
  c ais8 cis c2 |
  % 5
  cis8 c ais4 f'8 dis cis c |
  % 6
  ais4 c a f |
  % 7
  ais ais ais8 a ais4 |
  % 8
  c ais8 cis c2 |
  % 9
  f4 f dis dis |
  % 10
  cis8 dis f4 dis8 cis c4 |
  % 11
  f8 fis f dis cis c ais4 |
  % 12
  dis gis,8 ais c4 cis |
  % 13
  dis f dis cis |
  % 14
  fis8 f f e f2 |
  % 15
  f4 f ais, ais |
  % 16
  ais a f2 |
  % 17
  
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
  ais8 c cis dis f4 ais8 gis |
  % 2
  fis4 f8 dis f4 ais, |
  % 3
  ais'8 gis fis f dis f fis4 |
  % 4
  c8 dis cis ais f'2 |
  % 5
  ais,8 c cis dis f4 ais8 gis |
  % 6
  fis4 f8 dis f4 ais, |
  % 7
  ais'8 gis fis f dis f fis4 |
  % 8
  c8 dis cis ais f'2 |
  % 9
  f4 ais8 gis g dis gis g |
  % 10
  f dis cis4 dis gis, |
  % 11
  ais c cis fis8 f |
  % 12
  dis4 f8 fis gis4 cis, |
  % 13
  gis'8 fis f dis cis c cis4 |
  % 14
  a ais f'2 |
  % 15
  cis'8 c ais a ais gis fis f |
  % 16
  dis4 f ais,2 |
  % 17
  
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
