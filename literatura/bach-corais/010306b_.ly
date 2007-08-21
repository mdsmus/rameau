% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 010306b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'8 g |
  % 2
  a4 b a d |
  % 3
  d cis d d |
  % 4
  cis b e d8 cis |
  % 5
  cis2 b4 fis8 g |
  % 6
  a4 b a d |
  % 7
  d cis d d |
  % 8
  cis b e d8 cis |
  % 9
  cis2 b4 b |
  % 10
  b b8 cis16 d cis8 b a4 |
  % 11
  a gis a a |
  % 12
  b cis d cis |
  % 13
  b2 cis4 fis,8 g |
  % 14
  a4 b a d |
  % 15
  d cis d d |
  % 16
  cis b e d8 cis |
  % 17
  cis2 b |
  % 18
  
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
  d d d d8 e |
  % 3
  fis g e4 fis fis |
  % 4
  fis8 e d4 g fis8 gis |
  % 5
  ais b4 ais8 fis4 d |
  % 6
  d d d d8 e |
  % 7
  fis g e4 fis fis |
  % 8
  fis8 e d4 g fis8 gis |
  % 9
  ais b4 ais8 fis4 fis |
  % 10
  e8 fis gis4 a e |
  % 11
  e e e fis |
  % 12
  fis fis fis e |
  % 13
  d cis8 b fis'4 d8 e |
  % 14
  fis4 g d8 e fis g |
  % 15
  a e fis g fis4 b |
  % 16
  e,8 fis g a b a16 g fis4 |
  % 17
  fis8 g fis e dis2 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  a g fis8 g a b |
  % 3
  a4 a a b |
  % 4
  ais b b8 cis d e |
  % 5
  fis cis fis e d4 b |
  % 6
  a g fis8 g a b |
  % 7
  a4 a a b |
  % 8
  ais b b8 cis d e |
  % 9
  fis cis fis e d4 d8 cis |
  % 10
  b4 e e8 d cis4 |
  % 11
  b cis8 d cis4 d8 cis |
  % 12
  b4 e d8 cis b ais |
  % 13
  fis'4 e ais, b |
  % 14
  cis d8 e fis4 a, |
  % 15
  a8 b a4 a a8 gis |
  % 16
  a4 b b8 cis d gis, |
  % 17
  ais b4 ais8 fis2 |
  % 18
  
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
  s2. b'4 |
  % 2
  fis g d8 e fis g |
  % 3
  a4 a, d b |
  % 4
  fis' g8 fis e4 b' |
  % 5
  fis2 b,4 b' |
  % 6
  fis g d8 e fis g |
  % 7
  a4 a, d b |
  % 8
  fis' g8 fis e4 b' |
  % 9
  fis2 b,4 b'8 a |
  % 10
  gis fis e4 a,8 b cis d |
  % 11
  e d e4 a, d8 e |
  % 12
  d cis b ais b4 cis |
  % 13
  d g fis b |
  % 14
  a g fis e8 d |
  % 15
  a' g a4 d, b |
  % 16
  a e'8 fis g a b4 |
  % 17
  fis8 e fis4 b,2 |
  % 18
  
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
