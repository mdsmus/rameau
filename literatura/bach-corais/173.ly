% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 173.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key ees \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  ais''4 g c ais2 dis,4 f2 |
  % 3
  g4 gis2 ais4 |
  % 4
  g dis2 f4 |
  % 5
  g a ais2 |
  % 6
  d4 c d dis |
  % 7
  d c2 ais2. ais4 b |
  % 9
  b c2 d4 |
  % 10
  dis4. dis8 f4 dis |
  % 11
  d2 c |
  % 12
  ais4 c4. d8 dis4 |
  % 13
  dis2 d4 dis2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  dis'4 dis dis d2 dis4 d8 c ais2 f' f4 |
  % 4
  dis ais2 d4 |
  % 5
  dis dis d2 |
  % 6
  f4 f f dis |
  % 7
  f g f8 dis d2. f4 g |
  % 9
  g8 f dis2 g4 |
  % 10
  g g f g |
  % 11
  gis g8 f dis2 |
  % 12
  dis4 dis f g2 f8 dis f gis g2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 ais gis8 g f2 ais4 gis2 |
  % 3
  g4 c ais ais |
  % 4
  ais g2 ais4 |
  % 5
  ais c f,2 |
  % 6
  ais4 c ais ais |
  % 7
  ais2 a4 f2. d'4 d |
  % 9
  g, g2 d'4 |
  % 10
  c c c c2 b4 g2 |
  % 12
  cis4 c8 ais c4 ais |
  % 13
  ais2 ais4 ais2. 
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
  dis4 dis gis, gis2 g'4 f8 dis d4 |
  % 3
  dis2 d8 c d4 |
  % 4
  dis dis,2 ais'4 |
  % 5
  dis8 d c4 ais2 |
  % 6
  ais'4 a gis g |
  % 7
  f dis f f2. ais8 gis g f |
  % 9
  dis d c2 b4 |
  % 10
  c4. ais8 gis4 g |
  % 11
  f g c2 |
  % 12
  g4 gis2 g8 gis |
  % 13
  ais2. dis, 
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
