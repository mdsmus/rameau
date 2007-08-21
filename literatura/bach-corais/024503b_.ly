% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024503b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g fis d |
  % 3
  g a ais ais |
  % 4
  c ais a a |
  % 5
  ais c d8 c ais4 |
  % 6
  dis dis d cis8 c |
  % 7
  c2 ais4 ais |
  % 8
  a g f d8 dis |
  % 9
  f4 f g f |
  % 10
  dis2 d4 d' |
  % 11
  c ais8 a a2 |
  % 12
  g1 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  dis8 d c4 d a |
  % 3
  d8 e fis4 g g |
  % 4
  a g fis fis |
  % 5
  g a ais f |
  % 6
  g8 a ais4 ais ais |
  % 7
  ais a f g8 f |
  % 8
  dis d e4 d a |
  % 9
  d8 dis f4 f8 dis dis d |
  % 10
  d c16 ais c4 ais ais' |
  % 11
  a g g fis |
  % 12
  d1 |
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
  s2. ais'4 |
  % 2
  ais a8 g a4 fis |
  % 3
  g c d d |
  % 4
  dis d d d |
  % 5
  d dis f8 dis d c |
  % 6
  ais4 ais8 c d ais g'4 |
  % 7
  f4. dis8 d4 d |
  % 8
  c ais a f |
  % 9
  ais ais ais a |
  % 10
  ais f f f' |
  % 11
  dis d e d8 c |
  % 12
  b1 |
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
  s2. g'4 |
  % 2
  c,8 d dis4 d c |
  % 3
  ais a g g' |
  % 4
  fis g d d |
  % 5
  g c ais gis |
  % 6
  g fis f e |
  % 7
  f2 ais,4 g |
  % 8
  c cis d4. c8 |
  % 9
  ais c d ais dis4 f |
  % 10
  g a ais ais |
  % 11
  fis g cis, d |
  % 12
  g,1 |
  % 13
  
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
  s2. g'4 |
  % 2
  c,8 d dis4 d c |
  % 3
  ais a g g' |
  % 4
  fis g d d |
  % 5
  g c ais gis |
  % 6
  g fis f e |
  % 7
  f f, ais g |
  % 8
  c cis d4. c8 |
  % 9
  ais c d ais dis,4 f |
  % 10
  g a ais ais' |
  % 11
  fis, g cis d |
  % 12
  g,1 |
  % 13
  
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
