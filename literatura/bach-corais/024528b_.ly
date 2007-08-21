% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024528b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  cis''4 b a b |
  % 2
  cis dis e2 |
  % 3
  fis4 e d cis8 b |
  % 4
  b2 a |
  % 5
  cis4 e d cis |
  % 6
  b a gis2 |
  % 7
  a4 b cis cis8 d16 e |
  % 8
  d2 cis |
  % 9
  cis4 d e d |
  % 10
  cis b cis2 |
  % 11
  b4 b cis8 dis e4 |
  % 12
  e dis e2 |
  % 13
  e4 cis fis4. e8 |
  % 14
  d4 cis8 b b2 |
  % 15
  cis4 e d cis8 b |
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
  a''4 gis a gis |
  % 2
  a8 gis fis4 gis2 |
  % 3
  b4 b gis a |
  % 4
  a gis e2 |
  % 5
  a4 b a gis |
  % 6
  fis fis f2 |
  % 7
  cis4 e e e |
  % 8
  a b a2 |
  % 9
  a4 a a a |
  % 10
  a gis a2 |
  % 11
  gis4 e a gis |
  % 12
  fis2 gis |
  % 13
  g4 g fis8 gis a4 |
  % 14
  a8 gis a4 gis2 |
  % 15
  a4 b a a |
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
  e'4 e e e |
  % 2
  e b b2 |
  % 3
  d4 b e e |
  % 4
  fis e8 d cis2 |
  % 5
  e4 e fis cis |
  % 6
  d d gis,2 |
  % 7
  fis4 gis a b |
  % 8
  fis' e e2 |
  % 9
  e4 d cis b |
  % 10
  cis8 d e4 e2 |
  % 11
  e4 b a b |
  % 12
  cis b b2 |
  % 13
  ais4 a a8 b cis4 |
  % 14
  d e e2 |
  % 15
  e4 e fis fis |
  % 16
  fis e8 d cis2 |
  % 17
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  a'4 e cis e |
  % 2
  a, b e2 |
  % 3
  b'4 gis e a |
  % 4
  d, e a,2 |
  % 5
  a'4 gis fis e |
  % 6
  d cis8 b cis2 |
  % 7
  fis4 e a gis |
  % 8
  fis gis a2 |
  % 9
  a4 fis cis d |
  % 10
  e e a,2 |
  % 11
  e'8 fis gis4 fis e |
  % 12
  a b e,2 |
  % 13
  g4 a d, cis |
  % 14
  b a e'2 |
  % 15
  a4 gis fis e |
  % 16
  dis e a,2 |
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
