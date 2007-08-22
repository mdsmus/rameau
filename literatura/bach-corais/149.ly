% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 149.mid
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
  s2 dis''4 d8 c |
  % 2
  g'4 f8 dis d4 dis8 f |
  % 3
  b,2 c8 d dis4 |
  % 4
  gis, g f ais |
  % 5
  g2 dis'4 d8 c |
  % 6
  g'4 f8 dis d4 dis8 f |
  % 7
  b,2 c8 d dis4 |
  % 8
  gis, g f ais |
  % 9
  g2 g'4 ais, |
  % 10
  a ais dis d8 c |
  % 11
  d2 d4 dis8 f |
  % 12
  b,4 g' dis d8. c16 |
  % 13
  c1 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 g''4 f |
  % 2
  dis8 f g4 gis g8 f |
  % 3
  g2 g4 g |
  % 4
  f ais, ais f' |
  % 5
  dis2 g4 f |
  % 6
  dis8 f g4 gis g8 f |
  % 7
  g2 g4 g |
  % 8
  f ais, ais f' |
  % 9
  dis2 dis4 dis |
  % 10
  f f g f |
  % 11
  f2 f4 f |
  % 12
  g g g f8. dis16 |
  % 13
  dis1 |
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
  s2 c'4 b |
  % 2
  c c c b8 c |
  % 3
  d2 c4 c |
  % 4
  c8 d dis4 dis d |
  % 5
  ais2 c4 b |
  % 6
  c c c b8 c |
  % 7
  d2 c4 c |
  % 8
  c8 d dis4 dis d |
  % 9
  ais2 ais4 ais |
  % 10
  c ais ais a |
  % 11
  ais2 ais4 c |
  % 12
  d c c4. b8 |
  % 13
  g1 |
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
  s2 c4 d |
  % 2
  dis c f g8 gis |
  % 3
  g2 dis8 d c4 |
  % 4
  f g8 gis ais4 ais, |
  % 5
  dis2 c4 d |
  % 6
  dis c f g8 gis |
  % 7
  g2 dis8 d c4 |
  % 8
  f g8 gis ais4 ais, |
  % 9
  dis2 dis4 g |
  % 10
  f8 dis d4 c f |
  % 11
  ais,2 ais'4 gis |
  % 12
  g8 f dis f g4 g, |
  % 13
  c1 |
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
