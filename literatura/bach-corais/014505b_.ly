% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 014505b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key cis \minor
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  fis'4 fis fis cis'2 dis4 e dis |
  % 3
  cis b2. |
  % 4
  cis4 dis f fis2 cis4 e dis2 cis cis4 |
  % 7
  e d cis b |
  % 8
  a gis a fis2 e e4 |
  % 10
  a2 b4 cis2 b4 a e'2 cis b4 |
  % 13
  a gis2 fis2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  cis'4 cis dis e |
  % 2
  fis fis gis8 ais b4 |
  % 3
  ais fis2. |
  % 4
  fis4 fis gis a8 b |
  % 5
  a gis fis4 gis a |
  % 6
  gis f2 fis4 |
  % 7
  e2 e4 fis2 e4 e2 |
  % 9
  dis4 b2 cis4 |
  % 10
  cis fis e e8 fis |
  % 11
  gis2 fis4 gis8 a |
  % 12
  b4 a2 gis4 |
  % 13
  fis2 f4 cis2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'8 b cis4 b gis |
  % 2
  cis b b gis |
  % 3
  cis dis2. |
  % 4
  cis4 b b cis2 cis4 cis2 |
  % 6
  c4 gis2 a4 |
  % 7
  b2 a4 fis |
  % 8
  b2 a8 b cis4 |
  % 9
  b8 a gis2 gis4 |
  % 10
  a d2 cis4 |
  % 11
  cis2 cis8 d e2 e d4 |
  % 13
  cis b8 a b4 ais2. 
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
  fis8 gis a4 b b |
  % 2
  ais b gis e |
  % 3
  fis b,2. |
  % 4
  ais'4 b gis fis8 f |
  % 5
  fis gis a4 gis fis |
  % 6
  gis cis,2 fis4 |
  % 7
  gis2 a4 dis,2 e4 cis a |
  % 9
  b e2 cis4 |
  % 10
  fis2 gis4 a |
  % 11
  f2 fis4 cis' |
  % 12
  gis a2 b4 |
  % 13
  cis cis,2 fis2. 
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
