% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 005605b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s4 c''2 g4 |
  % 2
  c c ais ais8 a |
  % 3
  a2 g |
  % 4
  s4 dis2 g4 |
  % 5
  f dis8 d dis4 d |
  % 6
  c1 |
  % 7
  s4 c'2 g4 |
  % 8
  c c ais ais8 a |
  % 9
  a2 g |
  % 10
  s4 dis2 g4 |
  % 11
  f dis8 d dis4 d |
  % 12
  c1 |
  % 13
  dis2 f4 g |
  % 14
  gis gis g g |
  % 15
  f2 dis |
  % 16
  dis f4 g |
  % 17
  gis gis g g |
  % 18
  f2 dis |
  % 19
  g4 a ais g |
  % 20
  c c b2 |
  % 21
  c4 dis d c |
  % 22
  c b c2 |
  % 23
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s4 dis'2 d4 |
  % 2
  fis8 g a4 a8 g g4 |
  % 3
  g fis d2 |
  % 4
  s4 c2 c4 |
  % 5
  d8 b c4 c b |
  % 6
  g1 |
  % 7
  s4 dis'2 d4 |
  % 8
  fis8 g a4 a8 g g4 |
  % 9
  g fis d2 |
  % 10
  s4 c2 c4 |
  % 11
  d8 b c4 c b |
  % 12
  g1 |
  % 13
  c2 d4 dis |
  % 14
  f f f8 d dis4 |
  % 15
  dis d ais2 |
  % 16
  c d4 dis |
  % 17
  f f f8 d dis4 |
  % 18
  dis d ais2 |
  % 19
  dis4 dis f dis |
  % 20
  dis dis8 d d2 |
  % 21
  g4 g gis8 g4 f8 |
  % 22
  g4 g g2 |
  % 23
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s4 g'2 ais4 |
  % 2
  c dis8 d d4 dis |
  % 3
  d4. c8 b2 |
  % 4
  s4 c2 g4 |
  % 5
  gis a g g8 f |
  % 6
  dis1 |
  % 7
  s4 g2 ais4 |
  % 8
  c dis8 d d4 dis |
  % 9
  d4. c8 b2 |
  % 10
  s4 c2 g4 |
  % 11
  gis a g g8 f |
  % 12
  dis1 |
  % 13
  g2 ais |
  % 14
  c4 ais ais c |
  % 15
  c ais8 gis g2 |
  % 16
  g ais |
  % 17
  c4 ais ais c |
  % 18
  c ais8 gis g2 |
  % 19
  ais4 c ais ais |
  % 20
  c8 ais a4 g2 |
  % 21
  g4 c c8 b c d |
  % 22
  dis4 d e2 |
  % 23
  
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
  s4 c2 ais4 |
  % 2
  a fis' g c, |
  % 3
  d2 g, |
  % 4
  s4 gis'2 dis4 |
  % 5
  f fis g g, |
  % 6
  c1 |
  % 7
  s4 c2 ais4 |
  % 8
  a fis' g c, |
  % 9
  d2 g, |
  % 10
  s4 gis'2 dis4 |
  % 11
  f fis g g, |
  % 12
  c1 |
  % 13
  c'4 ais gis g |
  % 14
  f d dis c |
  % 15
  gis ais dis2 |
  % 16
  c'4 ais gis g |
  % 17
  f d dis c |
  % 18
  gis ais dis2 |
  % 19
  dis4 c d dis |
  % 20
  gis8 g fis4 g2 |
  % 21
  dis8 d c4 f8 g gis4 |
  % 22
  g g, c2 |
  % 23
  
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
  s4 c2 ais4 |
  % 2
  a fis' g c, |
  % 3
  d2 g, |
  % 4
  s4 gis2 dis'4 |
  % 5
  f fis g g, |
  % 6
  c1 |
  % 7
  s4 c2 ais4 |
  % 8
  a fis' g c, |
  % 9
  d2 g, |
  % 10
  s4 gis2 dis'4 |
  % 11
  f fis g g, |
  % 12
  c1 |
  % 13
  c4 ais gis g |
  % 14
  f d' dis c |
  % 15
  gis ais dis,2 |
  % 16
  c'4 ais gis g |
  % 17
  f d' dis c |
  % 18
  gis ais dis,2 |
  % 19
  dis'4 c d dis |
  % 20
  gis,8 g fis4 g2 |
  % 21
  dis'8 d c4 f8 g gis4 |
  % 22
  g g, c,2 |
  % 23
  
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
