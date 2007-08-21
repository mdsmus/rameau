% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 025800b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  d b8 cis d e fis4 |
  % 3
  e e d d |
  % 4
  cis b8 cis d4 e8 d |
  % 5
  cis2 b4 d |
  % 6
  d b8 cis d e fis4 |
  % 7
  e e d d |
  % 8
  cis b8 cis d4 e8 d |
  % 9
  cis2 b4 e |
  % 10
  fis fis cis8 d e4 |
  % 11
  d d cis d |
  % 12
  e b8 cis d4 cis |
  % 13
  b b a d |
  % 14
  cis b8 cis d4 e8 d |
  % 15
  cis2 b |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'8 g |
  % 2
  a4 g a a |
  % 3
  b a8 g fis4 gis |
  % 4
  a g fis e8 fis |
  % 5
  g4 fis fis fis8 g |
  % 6
  a4 g a a |
  % 7
  b a8 g fis4 gis |
  % 8
  a g fis e8 fis |
  % 9
  g4 fis fis a |
  % 10
  a a e8 fis g4 |
  % 11
  fis gis ais b |
  % 12
  b8 a gis4 fis e |
  % 13
  a gis e gis |
  % 14
  a gis8 ais b4 b8 fis |
  % 15
  g4 fis8 e d2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  d d d d |
  % 3
  d cis a b |
  % 4
  e e d8 cis b4 |
  % 5
  b ais8 e' d4 d |
  % 6
  d d d d |
  % 7
  d cis a b |
  % 8
  e e d8 cis b4 |
  % 9
  b ais8 e' d4 a |
  % 10
  a a8 b cis4 cis |
  % 11
  d8 cis b4 fis' fis |
  % 12
  b, e a,8 b cis4 |
  % 13
  fis e8 d cis4 d |
  % 14
  e e fis b, |
  % 15
  b ais fis2 |
  % 16
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. b'4 |
  % 2
  fis g fis8 e d4 |
  % 3
  gis a d, b |
  % 4
  a e' b'8 a g fis |
  % 5
  e4 fis b, b' |
  % 6
  fis g fis8 e d4 |
  % 7
  gis a d, b |
  % 8
  a e' b'8 a g fis |
  % 9
  e4 fis b, cis |
  % 10
  d8 e fis g a4 ais |
  % 11
  b f fis b8 a |
  % 12
  gis fis e4 fis8 gis a4 |
  % 13
  dis, e a, b |
  % 14
  cis8 d e4 b'8 a g fis |
  % 15
  e4 fis b,2 |
  % 16
  
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
