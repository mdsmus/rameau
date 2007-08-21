% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024410b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key aes \major
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  gis ais c8 cis dis4 |
  % 3
  cis2 c4 c8 cis |
  % 4
  dis4 dis ais c |
  % 5
  gis2 g4 dis |
  % 6
  gis ais c c |
  % 7
  ais2. c4 |
  % 8
  gis ais c8 cis dis4 |
  % 9
  cis2 c4 c8 cis |
  % 10
  dis4 dis ais c |
  % 11
  gis2 g4 dis |
  % 12
  gis ais c cis |
  % 13
  c ais gis2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  f g gis8 ais c4 |
  % 3
  c ais gis gis |
  % 4
  gis8 g gis f g f dis4 |
  % 5
  dis d dis ais |
  % 6
  dis cis c8 cis dis4 |
  % 7
  dis2. g4 |
  % 8
  f dis dis f |
  % 9
  f8 dis f g a4 gis |
  % 10
  ais gis8 g f4 g |
  % 11
  g f e dis |
  % 12
  dis8 f dis cis c dis f g |
  % 13
  gis4 g dis2 |
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
  s2. dis'4 |
  % 2
  cis cis dis8 cis c ais |
  % 3
  gis4 dis' dis f |
  % 4
  dis dis dis g, |
  % 5
  gis8 g gis4 ais g8 f |
  % 6
  dis4 f8 g gis4 gis |
  % 7
  g2. c4 |
  % 8
  c8 cis c ais gis ais c4 |
  % 9
  ais8 c cis dis f4 f |
  % 10
  dis8 cis c4 d g, |
  % 11
  c2 c4 c |
  % 12
  c8 cis c ais gis4 gis |
  % 13
  f' ais,8 c16 cis c2 |
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
  s2. gis'4 |
  % 2
  cis8 c ais4 gis4. g8 |
  % 3
  f4 g gis f |
  % 4
  c8 ais c cis dis cis c4 |
  % 5
  f2 dis4 cis |
  % 6
  c ais gis8 ais c cis |
  % 7
  dis2. e4 |
  % 8
  f g gis a |
  % 9
  ais ais, f' f |
  % 10
  g gis gis8 g f e |
  % 11
  f g gis ais c4 c, |
  % 12
  f g gis8 g f dis |
  % 13
  cis4 dis gis,2 |
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
