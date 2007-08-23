% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 196.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g ais g |
  % 3
  ais b c d |
  % 4
  dis8 d c d dis4 d |
  % 5
  c c b g |
  % 6
  c8 d dis4 d c |
  % 7
  b2 c4 g |
  % 8
  g a ais gis |
  % 9
  g f dis dis |
  % 10
  ais' ais c d |
  % 11
  dis d dis dis |
  % 12
  f dis d c |
  % 13
  c b c2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. dis'8 f |
  % 2
  g f dis4 f4. dis8 |
  % 3
  g4 f dis g |
  % 4
  g g g g |
  % 5
  g g8 f g4 d |
  % 6
  g g gis8 g g f |
  % 7
  g gis g f dis4 dis8 f |
  % 8
  g4 f f8 g4 f dis d8 dis4 c |
  % 10
  dis8 f g4 dis f |
  % 11
  g f g g8 gis4 g8 g4 f8 gis g f |
  % 13
  dis d16 c d8 f4 e4. |
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
  s2. c'4 |
  % 2
  d4. c8 ais4 ais |
  % 3
  ais8 c d4 g, d' |
  % 4
  c8 d dis d c4 b |
  % 5
  c8 b c4 d b |
  % 6
  c c4. b8 c4 |
  % 7
  d g, g c |
  % 8
  c8 g c4 d8 c4 d16 c |
  % 9
  ais8 c f, ais16 gis g4 g8 gis |
  % 10
  ais gis ais cis c ais gis4 |
  % 11
  ais ais ais c |
  % 12
  d4. c4 b8 c gis |
  % 13
  g2 g |
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
  s2. c4 |
  % 2
  b c d dis2 d4 c b |
  % 4
  c8*5 dis8 g f |
  % 5
  dis4 gis g g8 f |
  % 6
  dis d c4 f8 g gis4 |
  % 7
  g g, c c8 d |
  % 8
  dis4. f16 dis d8 dis f4 |
  % 9
  g8 gis ais ais, c4 c |
  % 10
  g8 f dis4 gis8 g f4 |
  % 11
  dis8 g ais4 dis c4. b8 c4 d dis8 f |
  % 13
  g4 g, c2 |
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
