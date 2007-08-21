% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024432b_.mid
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
  s2. ais''4 |
  % 2
  ais f' f dis8 d |
  % 3
  c4 d dis8 d c4 |
  % 4
  ais ais c d |
  % 5
  dis c f g |
  % 6
  f d d8 dis f4 |
  % 7
  dis d8 c ais c d c |
  % 8
  c4 d ais8 c d4 |
  % 9
  dis d c d |
  % 10
  dis d c ais |
  % 11
  f'4. dis8 d4 dis8 d |
  % 12
  c2 ais |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  g a8 ais c4 ais8 a |
  % 3
  g4 f ais a |
  % 4
  f g fis f |
  % 5
  dis8 f g4 f4. e8 |
  % 6
  a4 a g f |
  % 7
  c' ais d, g |
  % 8
  f f g8 a b4 |
  % 9
  c ais ais gis |
  % 10
  g f f8 dis d dis |
  % 11
  f g a2 g4 |
  % 12
  g f8 dis d2 |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  d8 dis f4 f g8 f |
  % 3
  dis4 f ais, f'8 dis |
  % 4
  d4 dis dis d |
  % 5
  g, g8 a ais c d c |
  % 6
  c4 c ais8 c d dis |
  % 7
  f4 f g ais, |
  % 8
  a ais8 a g4 f |
  % 9
  g g'8 f dis4 f |
  % 10
  ais, ais a ais |
  % 11
  c2. ais4 |
  % 12
  ais a f2 |
  % 13
  
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
  s2. ais'8 a |
  % 2
  g4 d a' ais2 gis4 g8 dis f4 |
  % 4
  ais, dis a b |
  % 5
  c8 d dis4 d8 c ais c |
  % 6
  f4 fis g gis |
  % 7
  a ais8 a g f e4 |
  % 8
  f ais, dis d |
  % 9
  c g' gis8 g f4 |
  % 10
  dis ais f' g |
  % 11
  a8 g f4 fis g8 f |
  % 12
  e4 f ais,2 |
  % 13
  
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
