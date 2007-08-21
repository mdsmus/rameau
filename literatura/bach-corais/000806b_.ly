% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000806b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s4 b''8 b e4 b |
  % 2
  cis b a4. b16 a |
  % 3
  gis4 fis s4 b8 a |
  % 4
  gis4 cis8 b ais fis b2 ais4 b2 |
  % 6
  s4 b8 b e4 b |
  % 7
  cis b a4. b16 a |
  % 8
  gis4 fis s4 b8 a |
  % 9
  gis4 cis8 b ais fis b2 ais4 b2 |
  % 11
  s4 fis8 gis a4 gis |
  % 12
  cis4. dis8 c2 |
  % 13
  s4 cis8 b ais4 b |
  % 14
  b ais b fis8 fis |
  % 15
  b4. a8 gis4 cis |
  % 16
  c cis2 c4 |
  % 17
  cis2 s4 e8 b |
  % 18
  cis4 gis8 a b4. a8 |
  % 19
  gis4 fis8 e dis4 e2 dis4 e2 |
  % 21
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''8 gis |
  % 2
  a4 a8 gis gis fis16 e fis8 fis |
  % 3
  e4 dis s2. gis8 gis fis4 fis |
  % 5
  fis fis fis2 |
  % 6
  s2. gis8 gis |
  % 7
  a4 a8 gis gis fis16 e fis8 fis |
  % 8
  e4 dis s2. gis8 gis fis4 fis |
  % 10
  fis fis fis2 |
  % 11
  s4 dis8 e fis4 e8 fis |
  % 12
  gis fis gis a gis2 |
  % 13
  s4 gis8 gis fis4 fis |
  % 14
  fis fis fis s2 fis e4 |
  % 16
  fis8 gis ais ais gis2 |
  % 17
  gis4 gis8 dis e2. e4 dis8 e fis4. e8 dis e b4 cis |
  % 20
  b2 b |
  % 21
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. e'8 e |
  % 2
  e4 e cis b |
  % 3
  b b s2. e8 dis cis4 dis |
  % 5
  cis cis dis2 |
  % 6
  s2. e8 e |
  % 7
  e4 e cis b |
  % 8
  b b s2. e8 dis cis4 dis |
  % 10
  cis cis dis2 |
  % 11
  s2. e8 dis |
  % 12
  cis a' gis fis dis2 |
  % 13
  s4 e8 dis cis4 dis |
  % 14
  cis8 b cis4 dis s2 dis8 dis b4 cis |
  % 16
  dis e dis2 |
  % 17
  e4 e8 c cis4. d8 |
  % 18
  cis2 b2. c4 fis, g |
  % 20
  fis8 e fis4 gis2 |
  % 21
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. e8 e |
  % 2
  a4 e fis dis |
  % 3
  e b s2. e4. dis8 cis b |
  % 5
  fis' e fis4 b,2 |
  % 6
  s2. e8 e |
  % 7
  a4 e fis dis |
  % 8
  e b s2. e4. dis8 cis b |
  % 10
  fis' e fis4 b,2 |
  % 11
  s2. cis8 dis |
  % 12
  e dis e fis gis,4 gis'8 fis |
  % 13
  e2. dis8 e |
  % 14
  fis4 fis, b s2 b8 b e dis cis b |
  % 16
  a gis g4 gis2 |
  % 17
  cis s4 cis'8 gis |
  % 18
  a b cis4 gis dis |
  % 19
  e a,2 ais4 |
  % 20
  b2 e, |
  % 21
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  e,4 s2 e'8 e |
  % 2
  a4 e fis dis |
  % 3
  e b8 cis dis2 |
  % 4
  e8 e, e'4. dis8 cis b |
  % 5
  fis'4 fis, b2 |
  % 6
  e,4 s2 e'8 e |
  % 7
  a4 e fis dis |
  % 8
  e b8 cis dis2 |
  % 9
  e8 e, e'4. dis8 cis b |
  % 10
  fis'4 fis, b4. cis8 |
  % 11
  dis4 b fis cis'8 dis |
  % 12
  e dis e fis gis,4 gis'8 fis |
  % 13
  e2. dis8 e |
  % 14
  fis4 fis, b4. cis8 |
  % 15
  dis4 b8 b e dis cis b |
  % 16
  a gis g4 gis2 |
  % 17
  cis s4 cis'8 gis |
  % 18
  a b cis4 gis dis |
  % 19
  e a,2 ais4 |
  % 20
  b2 e, |
  % 21
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
