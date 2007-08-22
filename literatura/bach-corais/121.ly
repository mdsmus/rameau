% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 121.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key fis \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  cis''4 d e e |
  % 2
  d cis b b |
  % 3
  cis d e d8 cis |
  % 4
  b4 b8 a a2 |
  % 5
  cis4 d e e |
  % 6
  d cis b b |
  % 7
  cis d e d8 cis |
  % 8
  b4 b8 a a2 |
  % 9
  b4 cis d8 cis d e |
  % 10
  cis4 cis b2 |
  % 11
  d4 e fis e8 fis16 g |
  % 12
  fis4 e8 d d2 |
  % 13
  cis4 d e e |
  % 14
  d cis b b |
  % 15
  cis d e a,8 b |
  % 16
  cis4 b8 a a4 a4. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''8 gis fis4 b8 a gis4 |
  % 2
  fis e8 fis gis4 gis |
  % 3
  a8 gis a4 a8 gis a4 |
  % 4
  a8 fis gis4 e2 |
  % 5
  a8 gis fis4 b8 a gis4 |
  % 6
  fis e8 fis gis4 gis |
  % 7
  a8 gis a4 a8 gis a4 |
  % 8
  a8 fis gis4 e2 |
  % 9
  gis4 ais b8 ais b4 |
  % 10
  b ais fis2 |
  % 11
  b4 b8 a a4 b |
  % 12
  a g8 fis fis2 |
  % 13
  e4 a gis b8 a |
  % 14
  a gis a4 e8 fis gis4 |
  % 15
  a gis8 fis e gis a4 |
  % 16
  a gis e e4. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  fis'8 e d cis b4 cis8 b |
  % 2
  a b cis d e4 e |
  % 3
  e a,8 b cis d e4 |
  % 4
  fis e8 d cis2 |
  % 5
  e4 d8 cis b4 cis8 b |
  % 6
  a b cis d e4 e |
  % 7
  e a,8 b cis d e4 |
  % 8
  fis e8 d cis2 |
  % 9
  e4 e fis e8 d |
  % 10
  g4 fis8 e d2 |
  % 11
  fis4 e d8 cis d4 |
  % 12
  d8 b cis4 a2 |
  % 13
  a4 b8 cis b4 cis |
  % 14
  d8 e fis4 gis e |
  % 15
  e d cis8 d e fis |
  % 16
  e4 d8 cis cis4 cis4. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  fis4 b8 a gis fis e4 |
  % 2
  fis8 gis a4 e e |
  % 3
  a fis cis b8 a |
  % 4
  d4 e a,2 |
  % 5
  a'4 b8 a gis fis e4 |
  % 6
  fis8 gis a4 e e |
  % 7
  a fis cis b8 a |
  % 8
  d4 e a,2 |
  % 9
  e'4 d8 cis b4 g' |
  % 10
  e fis b,2 |
  % 11
  b4 cis d g |
  % 12
  a a, d2 |
  % 13
  a'4 gis8 fis gis4 cis, |
  % 14
  fis e8 dis e4 e, |
  % 15
  a8 gis a b cis b cis d |
  % 16
  e4 e, a a4. 
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
