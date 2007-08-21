% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 039200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  ais c d8 dis f4 |
  % 3
  dis2 d4 d8 dis |
  % 4
  f4 f c d8 c |
  % 5
  ais2 a4 f |
  % 6
  ais c d8 dis16 f dis8 d |
  % 7
  c2 s4 d |
  % 8
  ais c d8 dis f4 |
  % 9
  dis2 d4 d8 dis |
  % 10
  f4 f c d |
  % 11
  ais2 a4 f |
  % 12
  ais c d c8 d16 dis |
  % 13
  d4 c ais2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. ais''4 |
  % 2
  g a ais ais |
  % 3
  ais a ais f |
  % 4
  ais ais4. a8 a4 |
  % 5
  g2 f4 c |
  % 6
  f g8 a ais4 ais |
  % 7
  f2 s4 a |
  % 8
  a8 g g f f g gis g |
  % 9
  g4 fis g ais |
  % 10
  c8 a ais4 g8 f a2 g4 f c |
  % 12
  f dis f g |
  % 13
  f f f2 |
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
  s2. f'4 |
  % 2
  dis dis f f |
  % 3
  g f f ais,8 c |
  % 4
  d dis f4 f f8 dis |
  % 5
  d4 c c a |
  % 6
  ais8 d dis4 f8 d ais4 |
  % 7
  a2 s4 d |
  % 8
  d8 dis dis f d2 |
  % 9
  g,4 a b g' |
  % 10
  f8 dis d4 e8 f f4 |
  % 11
  f e c a |
  % 12
  ais4. a8 ais4 ais |
  % 13
  ais a8 dis d2 |
  % 14
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. ais4 |
  % 2
  dis d8 c ais4 d |
  % 3
  c f ais, ais' |
  % 4
  ais,8 c d dis f4 d |
  % 5
  g8 f e c f4 f8 dis |
  % 6
  d4 c ais dis |
  % 7
  f2 s4 fis |
  % 8
  g a ais b |
  % 9
  c c, g' g |
  % 10
  a8 f ais4. a8 g f |
  % 11
  g4 c, f f8 dis |
  % 12
  d4 c ais dis |
  % 13
  f f, ais2 |
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
