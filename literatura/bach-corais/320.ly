% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 320.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key fis \minor
  
  \tempo 4 = 108 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  cis''2 e |
  % 2
  cis4 cis cis cis |
  % 3
  d2 cis |
  % 4
  b1 |
  % 5
  a |
  % 6
  cis2 e |
  % 7
  b4 b b b |
  % 8
  b2 fis4 gis |
  % 9
  a2 gis |
  % 10
  fis1*2 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'2 e |
  % 2
  e4 f fis gis |
  % 3
  fis e2 fis4 |
  % 4
  fis2 e |
  % 5
  e1 |
  % 6
  e |
  % 7
  e4 gis fis a |
  % 8
  gis2 fis |
  % 9
  fis2. f4 |
  % 10
  cis2 d1 cis2 |
  % 12
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'2 b |
  % 2
  cis4 b a gis |
  % 3
  a b2 a4 |
  % 4
  a2 gis |
  % 5
  a1 |
  % 6
  a2 a |
  % 7
  gis4 b a fis' |
  % 8
  e2 b |
  % 9
  cis b |
  % 10
  ais b1 ais2 |
  % 12
  
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
  fis2 gis |
  % 2
  a4 gis fis f |
  % 3
  fis gis a fis |
  % 4
  d b e2 |
  % 5
  a,1 |
  % 6
  a4 b cis d |
  % 7
  e2 dis |
  % 8
  e d |
  % 9
  cis1 |
  % 10
  fis,4 e' d b |
  % 11
  fis1 |
  % 12
  
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
