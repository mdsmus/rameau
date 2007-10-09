% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 061.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key ees \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 f dis f |
  % 2
  g gis ais2 |
  % 3
  c4 ais gis g8 f |
  % 4
  f2 dis |
  % 5
  g4 ais gis g |
  % 6
  f dis d2 |
  % 7
  dis4 f g g |
  % 8
  gis2 g |
  % 9
  g4 gis ais gis |
  % 10
  g f g2 |
  % 11
  f4 f g8 a ais4 |
  % 12
  ais a ais2 |
  % 13
  ais4 g c ais |
  % 14
  gis g f2 |
  % 15
  g8 gis ais4 gis g8 f |
  % 16
  f2 dis |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  dis'4 d4. c4 ais8 |
  % 2
  ais4 gis d'2 |
  % 3
  dis8 gis4 g f8 dis2 d4 ais2 |
  % 5
  dis4 f dis8 f g dis |
  % 6
  d4 c b2 |
  % 7
  c4 d dis dis4. d16 dis f8 d dis2 |
  % 9
  dis4 dis e f |
  % 10
  cis8 c c d dis2 |
  % 11
  c4 c8 d dis4 cis8 dis |
  % 12
  f2 f |
  % 13
  f4 dis8 f g4 g |
  % 14
  dis8 f ais, c d2 |
  % 15
  dis4. ais8 dis f g c, |
  % 16
  d dis16 c d4 ais2 |
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
  ais'4 ais8 gis g4 f |
  % 2
  dis8 dis'4 dis8 dis2 |
  % 3
  c4 d dis8 d dis c |
  % 4
  ais4. gis8 g2 |
  % 5
  ais4 ais c8 d dis c |
  % 6
  gis g g4 g2 |
  % 7
  g4 ais ais ais |
  % 8
  c8 gis f ais ais2 |
  % 9
  c4 c ais c |
  % 10
  ais gis g2 |
  % 11
  gis8 ais c ais ais4. c8 |
  % 12
  cis4 c d2 |
  % 13
  ais4 ais dis d8 ais |
  % 14
  c d dis4 ais2 |
  % 15
  ais8 gis g f dis d dis4 |
  % 16
  ais'4. gis8 g2 |
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
  dis4 ais c d |
  % 2
  dis f g2 |
  % 3
  gis4 ais c ais8 gis |
  % 4
  ais4 ais, dis2 |
  % 5
  dis8 d d c c8*5 b8 c dis g2 |
  % 7
  c,8 c' ais gis g f dis d |
  % 8
  c f d ais dis2 |
  % 9
  c4 ais8 gis g g'4 f e8 f4 c2 |
  % 11
  f8 g gis4 g fis |
  % 12
  f8 dis f4 ais,2 |
  % 13
  d8 ais dis4. c8 g'4. f8 g gis ais2 |
  % 15
  dis,4. d8 c c' ais gis |
  % 16
  ais4 ais, dis2 |
  % 17
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  dis4 ais c d |
  % 2
  dis f g2 |
  % 3
  gis4 ais c ais8 gis |
  % 4
  ais4 ais, dis2 |
  % 5
  dis8 d d c c8*5 b8 c dis g2 |
  % 7
  c,8 c' ais gis g f dis d |
  % 8
  c f d ais dis2 |
  % 9
  c4 ais8 gis g g'4 f e8 f4 c2 |
  % 11
  f8 g gis4 g fis |
  % 12
  f8 dis f4 ais,2 |
  % 13
  d8 ais dis4. c8 g'4. f8 g gis ais2 |
  % 15
  dis,4. d8 c4 ais8 gis |
  % 16
  ais2 dis, |
  % 17
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
