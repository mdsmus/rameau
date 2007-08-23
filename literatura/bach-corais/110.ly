% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 110.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g dis f g8 f |
  % 3
  dis4 d c g' |
  % 4
  g f ais g8 f |
  % 5
  dis4 f g g8 a |
  % 6
  ais4 c8 d dis4 d |
  % 7
  c b c c |
  % 8
  d c ais a |
  % 9
  g a g c |
  % 10
  ais a ais8 gis g4 |
  % 11
  g f dis g |
  % 12
  gis g8 f dis4 f |
  % 13
  dis d c2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. dis'4 |
  % 2
  d c c8 d dis d |
  % 3
  c4 b g dis' |
  % 4
  dis d8 dis f4 dis8 d |
  % 5
  c b c d b4 dis |
  % 6
  d dis8 f g4 f |
  % 7
  dis8 f g4 g f |
  % 8
  f fis g g8 fis |
  % 9
  g4 fis d f |
  % 10
  f dis d dis8 d |
  % 11
  c4 d ais c |
  % 12
  f dis8 d c4 d8 c |
  % 13
  b c c b g2 |
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
  g g c c8 gis |
  % 3
  g4 g8 f dis4 c' |
  % 4
  ais ais ais ais |
  % 5
  c gis d c' |
  % 6
  ais gis g a8 b |
  % 7
  c4 d dis a |
  % 8
  ais c d dis8 d |
  % 9
  d c c b b4 a |
  % 10
  ais c f, dis |
  % 11
  dis ais'8 gis g4 c |
  % 12
  c b c8 ais ais4 |
  % 13
  g g8 f e2 |
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
  b c gis' dis8 f |
  % 3
  g4 g, c c' |
  % 4
  g8 gis ais4 d, dis |
  % 5
  gis gis, g c |
  % 6
  g' f dis f8 g |
  % 7
  gis4 g c, f |
  % 8
  ais a g c,8 d |
  % 9
  dis4 d g, f'8 dis |
  % 10
  d4 c ais c8 ais |
  % 11
  gis4 ais dis e |
  % 12
  f g gis8 g f4 |
  % 13
  g g, c2 |
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
