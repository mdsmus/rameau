% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 035500b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  cis''4 a b b |
  % 2
  cis dis e2 |
  % 3
  b4 cis d cis |
  % 4
  b2 a |
  % 5
  b4 b e e |
  % 6
  d d cis2 |
  % 7
  b4 b a gis |
  % 8
  fis2 e |
  % 9
  a4 a d d |
  % 10
  cis cis b2 |
  % 11
  a4 a a a |
  % 12
  b2 e, |
  % 13
  e'4 d cis b |
  % 14
  a gis fis2 |
  % 15
  b4 a d cis |
  % 16
  b2 a |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 e fis e |
  % 2
  e fis gis2 |
  % 3
  gis4 a4. gis8 a4 |
  % 4
  a gis e2 |
  % 5
  gis4 gis gis ais |
  % 6
  fis fis fis2 |
  % 7
  fis4. e8 e dis e4 |
  % 8
  e dis b2 |
  % 9
  e4 e fis8 gis a b4 a16 gis a4 a gis |
  % 11
  fis g fis fis |
  % 12
  fis8 e fis4 b,2 |
  % 13
  cis8 a'4 gis8 a4. gis4 fis f8 fis2 |
  % 15
  fis8 gis a4 a8 gis a4 |
  % 16
  a gis e2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'4 a a gis |
  % 2
  a a b2 |
  % 3
  e4 e d8 b e4 |
  % 4
  fis8 d b e16 d cis2 |
  % 5
  e4 e e8 d cis2 b4 b ais |
  % 7
  dis8 cis b4 cis8 a b4 |
  % 8
  cis b8 a gis2 |
  % 9
  a8 b cis b a gis fis e |
  % 10
  e'4 e e2 |
  % 11
  cis8 d e2 d8 cis |
  % 12
  b gis a b16 a gis2 |
  % 13
  a8 cis d b e fis b, e16 d |
  % 14
  cis16*7 b16 a2 |
  % 15
  d4 e d8 b cis e |
  % 16
  fis d b e16 d cis2 |
  % 17
  
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
  a4 cis d e |
  % 2
  a8 gis fis4 e2 |
  % 3
  e8 d cis4 b a |
  % 4
  d e a,2 |
  % 5
  e'4 e8 d cis4 fis |
  % 6
  b,8 cis d e fis2 |
  % 7
  b8 a gis4 fis e |
  % 8
  a, b e2 |
  % 9
  cis8 b a gis fis e fis gis |
  % 10
  a b cis d e2 |
  % 11
  fis8 e d cis d e fis e |
  % 12
  dis e4 dis8 e2 |
  % 13
  a,4 b cis8 d e4 |
  % 14
  fis cis d2 |
  % 15
  d8 e d cis b e a, cis |
  % 16
  d b e4 a,2 |
  % 17
  
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
