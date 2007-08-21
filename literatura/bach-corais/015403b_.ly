% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 015403b_.mid
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
  cis''4 d e e |
  % 2
  d cis b b |
  % 3
  cis d e cis |
  % 4
  b b a2 |
  % 5
  cis4 d e e |
  % 6
  d cis b b |
  % 7
  cis d e cis |
  % 8
  b b a2 |
  % 9
  b4 cis d d |
  % 10
  cis cis b b |
  % 11
  d e fis fis |
  % 12
  e e d d |
  % 13
  cis d e e |
  % 14
  d cis b2 |
  % 15
  cis4 d e8 d cis4 |
  % 16
  b b a2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''4 a gis a |
  % 2
  a8 gis a4 gis gis |
  % 3
  a a b a |
  % 4
  a gis e2 |
  % 5
  a4 a gis a |
  % 6
  a8 gis a4 gis gis |
  % 7
  a a b a |
  % 8
  a gis e2 |
  % 9
  gis4 ais b b |
  % 10
  b ais fis fis |
  % 11
  fis a a a |
  % 12
  a8 e a g fis4 fis |
  % 13
  e a e8 fis gis4 |
  % 14
  a a gis2 |
  % 15
  a4 a a8 gis a4 |
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
  e'4 fis e8 d cis4 |
  % 2
  d e e e |
  % 3
  e fis b, cis8 d |
  % 4
  e b e d cis2 |
  % 5
  e4 fis e8 d cis4 |
  % 6
  d e e e |
  % 7
  e fis b, cis8 d |
  % 8
  e b e d cis2 |
  % 9
  e4 e fis fis |
  % 10
  fis8 cis fis e d4 d |
  % 11
  d cis d d |
  % 12
  d cis a a |
  % 13
  a8 b cis4 b e |
  % 14
  fis e e2 |
  % 15
  e4 fis e e |
  % 16
  e8 b e d cis2 |
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
  a'4 fis cis fis |
  % 2
  b, cis8 d e4 e |
  % 3
  a8 gis fis4 gis a |
  % 4
  e e a,2 |
  % 5
  a'4 fis cis fis |
  % 6
  b, cis8 d e4 e |
  % 7
  a8 gis fis4 gis a |
  % 8
  e e a,2 |
  % 9
  e'4 d8 cis b cis d e |
  % 10
  fis4 fis b, b |
  % 11
  b' a8 g fis e d4 |
  % 12
  a' a, d d |
  % 13
  a'8 gis fis4 gis cis |
  % 14
  fis,8 gis a4 e2 |
  % 15
  a8 fis e d cis b a4 |
  % 16
  e' e a,2 |
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
