% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 013306b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'8 g |
  % 2
  a4 b a g8 fis |
  % 3
  fis2 s4 a |
  % 4
  b cis d d8 cis |
  % 5
  cis2 b4 fis8 g |
  % 6
  a4 b a g8 fis |
  % 7
  fis2 s4 a |
  % 8
  b cis d d8 cis |
  % 9
  cis2 b4 e8 d |
  % 10
  cis4 d8 cis b4. a8 |
  % 11
  a2. a4 |
  % 12
  b cis d4. d8 |
  % 13
  cis2. a4 |
  % 14
  a b a g8 fis |
  % 15
  fis2 s4 a |
  % 16
  b8 cis d4 d cis |
  % 17
  d1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 cis |
  % 2
  d4 d d8 cis16 b cis4 |
  % 3
  d2 s4 fis |
  % 4
  gis ais b gis |
  % 5
  fis4. e8 d4 d8 cis |
  % 6
  d4 d d8 cis16 b cis4 |
  % 7
  d2 s4 fis |
  % 8
  gis ais b gis |
  % 9
  fis4. e8 d4 e |
  % 10
  e fis fis8 d e4 |
  % 11
  e2. e4 |
  % 12
  e8 fis gis4 a e |
  % 13
  e2. e4 |
  % 14
  fis g8 fis e4 e |
  % 15
  d2 s4 d |
  % 16
  d e e8 fis g4 |
  % 17
  fis1 |
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
  s2. a'4 |
  % 2
  a g a a |
  % 3
  a2 s4 a |
  % 4
  e' e fis b, |
  % 5
  b ais b a |
  % 6
  a g a a |
  % 7
  a2 s4 a |
  % 8
  e' e fis b, |
  % 9
  b ais b b |
  % 10
  a a a gis |
  % 11
  cis2. cis4 |
  % 12
  b e d8 cis b4 |
  % 13
  a2. cis4 |
  % 14
  d g, a8 b cis4 |
  % 15
  b2 s4 a |
  % 16
  g8 a b4 a a |
  % 17
  a1 |
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
  s2. d8 e |
  % 2
  fis4 g a a, |
  % 3
  d2 s4 d |
  % 4
  d cis b8 cis d e |
  % 5
  fis2 b,4 d8 e |
  % 6
  fis4 g a a, |
  % 7
  d2 s4 d |
  % 8
  d cis b8 cis d e |
  % 9
  fis2 b,4 gis' |
  % 10
  a8 gis fis e d b e4 |
  % 11
  a,2. a'4 |
  % 12
  gis e fis gis |
  % 13
  a2. g4 |
  % 14
  fis e8 d cis4 a |
  % 15
  b2 s4 fis' |
  % 16
  g gis a a, |
  % 17
  d1 |
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
