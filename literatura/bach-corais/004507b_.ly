% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004507b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  gis fis8 e b'4 b |
  % 3
  cis2 s4 cis |
  % 4
  fis, fis b a |
  % 5
  gis fis e b' |
  % 6
  cis cis b a |
  % 7
  gis2 s4 fis |
  % 8
  gis ais b cis |
  % 9
  dis cis8 b b4 b |
  % 10
  b b e d |
  % 11
  cis2 s4 cis |
  % 12
  cis cis fis e |
  % 13
  dis2 s4 b |
  % 14
  cis b cis dis |
  % 15
  e2 s4 b |
  % 16
  b a8 gis fis4 fis |
  % 17
  e2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  e dis e8 fis gis4 |
  % 3
  a2 s4 fis8 e |
  % 4
  dis cis dis4 e fis |
  % 5
  e dis b e |
  % 6
  e a a8 gis fis4 |
  % 7
  e2 s4 fis |
  % 8
  fis e fis gis |
  % 9
  fis2 dis4 fis |
  % 10
  e e e8 fis gis4 |
  % 11
  a2 s4 a |
  % 12
  a ais b b8 ais |
  % 13
  b2 s4 b |
  % 14
  a b b8 a gis fis |
  % 15
  e2 s4 fis |
  % 16
  e e e dis |
  % 17
  b2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. gis'8 a |
  % 2
  b4 a b e |
  % 3
  e2 s4 cis |
  % 4
  b b b b |
  % 5
  b4. a8 gis4 b |
  % 6
  a8 cis fis e dis e e dis |
  % 7
  b2 s4 b |
  % 8
  b cis fis,8 b b4 |
  % 9
  b ais fis b8 a |
  % 10
  gis fis gis a b4 e |
  % 11
  e2 s4 e |
  % 12
  fis cis dis e |
  % 13
  fis2 s4 e |
  % 14
  e e a, b8 a |
  % 15
  gis2 s4 fis8 gis16 a |
  % 16
  gis4 a8 b cis4 b8 a |
  % 17
  gis2. 
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
  s2. e4 |
  % 2
  e fis gis fis8 e |
  % 3
  a2 s4 ais |
  % 4
  b a gis dis |
  % 5
  e b e gis |
  % 6
  a fis b b, |
  % 7
  e2 s4 dis |
  % 8
  e cis dis e |
  % 9
  fis2 b,4 dis |
  % 10
  e8 dis e fis gis4 fis8 e |
  % 11
  a2 s4 a8 gis |
  % 12
  fis4 e dis cis |
  % 13
  b2 s4 gis' |
  % 14
  a gis fis b, |
  % 15
  cis2 s4 dis |
  % 16
  e8 dis cis b a4 b |
  % 17
  e2. 
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
  s2. e,4 |
  % 2
  e' fis gis fis8 e |
  % 3
  a2 s4 ais |
  % 4
  b a gis dis |
  % 5
  e b e, gis' |
  % 6
  a fis b b, |
  % 7
  e2 s4 dis |
  % 8
  e cis dis e |
  % 9
  fis fis, b dis |
  % 10
  e8 dis e fis gis4 fis8 e |
  % 11
  a2 s4 a8 gis |
  % 12
  fis4 e dis cis |
  % 13
  b2 s4 gis' |
  % 14
  a gis fis b, |
  % 15
  cis2 s4 dis |
  % 16
  e8 dis cis b a4 b |
  % 17
  e,2. 
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
