% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 011007b_.mid
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
  s2. b''8 cis |
  % 2
  d4 cis b b8 cis |
  % 3
  d4 cis b fis' |
  % 4
  e d cis cis |
  % 5
  d d e e |
  % 6
  fis fis e d |
  % 7
  cis2 b4 fis' |
  % 8
  e d cis fis |
  % 9
  e d cis cis |
  % 10
  d d e e |
  % 11
  fis fis e d |
  % 12
  cis2 b |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  b ais fis fis |
  % 3
  b ais fis fis8 g |
  % 4
  a4 fis fis fis |
  % 5
  fis fis b a |
  % 6
  a a8 b cis4 fis, |
  % 7
  fis4. e8 d4 b' |
  % 8
  b8 ais b4 ais b8 a |
  % 9
  gis4 a8 b a4 a |
  % 10
  a8 g fis4 b8 a gis4 |
  % 11
  cis b8 ais b4 b |
  % 12
  b ais fis2 |
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
  s2. d'8 e |
  % 2
  fis4 fis8 e d4 d8 e |
  % 3
  fis4 fis8 e d4 a8 b |
  % 4
  cis4 b ais ais |
  % 5
  b8 cis d4 d cis |
  % 6
  d d cis b |
  % 7
  b ais fis d' |
  % 8
  e fis fis fis |
  % 9
  b, fis'8 e e4 e |
  % 10
  fis8 e d cis b4 e |
  % 11
  e d8 cis b cis d e |
  % 12
  fis4. e8 dis2 |
  % 13
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. b4 |
  % 2
  b' fis b, b |
  % 3
  b' fis b, d |
  % 4
  a' b fis fis |
  % 5
  b b8 a g e a g |
  % 6
  fis e d cis b ais b4 |
  % 7
  fis2 b4 b |
  % 8
  cis d8 e fis4 d |
  % 9
  e fis8 gis a4 a8 g |
  % 10
  fis4 b8 a gis4 cis8 b |
  % 11
  ais4 d gis,8 ais b4 |
  % 12
  fis2 b, |
  % 13
  
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
