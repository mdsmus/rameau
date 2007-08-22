% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 294.mid
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
  s2. b''4 |
  % 2
  b ais b cis |
  % 3
  d cis b b |
  % 4
  cis cis fis e |
  % 5
  d2 cis4 b |
  % 6
  b ais b cis |
  % 7
  d cis b b |
  % 8
  cis cis fis e |
  % 9
  d2 cis4 fis |
  % 10
  e d cis8 d e4 |
  % 11
  d cis b d |
  % 12
  cis b a8 gis fis gis |
  % 13
  a b b4 cis cis |
  % 14
  d e fis4. e8 |
  % 15
  d4 e cis2 |
  % 16
  b2. 
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
  e fis fis gis8 ais |
  % 3
  b4 ais fis fis8 gis |
  % 4
  a4 a8 g fis4 gis8 ais |
  % 5
  b2 ais4 fis |
  % 6
  e fis fis gis8 ais |
  % 7
  b4 ais fis fis8 gis |
  % 8
  a4 a8 g fis4 gis8 ais |
  % 9
  b2 ais4 a |
  % 10
  a8 g fis gis ais b cis4 |
  % 11
  b ais fis fis8 gis |
  % 12
  a4. gis8 fis e fis4 |
  % 13
  cis fis8 e e4 fis |
  % 14
  fis8 b a g fis4 gis8 a |
  % 15
  b a g4 fis2 |
  % 16
  fis2. 
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
  cis8 b cis4 d e |
  % 3
  fis4. e8 d4 d |
  % 4
  e a, d8 cis b cis |
  % 5
  d e fis4 fis d |
  % 6
  cis8 b cis4 d e |
  % 7
  fis4. e8 d4 d |
  % 8
  e a, d8 cis b cis |
  % 9
  d e fis4 fis a,8 b |
  % 10
  cis4 d8 e fis4 g |
  % 11
  g cis,8 e d4 d |
  % 12
  e8 e, fis gis a b a gis |
  % 13
  fis4. gis8 a4 cis |
  % 14
  b8 fis' e4 d4. cis8 |
  % 15
  b4 cis8 b ais cis e4 |
  % 16
  dis2. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. b'8 a |
  % 2
  g4 fis8 e d4 cis |
  % 3
  b fis b b' |
  % 4
  a8 g fis e d4. cis8 |
  % 5
  b cis d e fis4 b8 a |
  % 6
  g4 fis8 e d4 cis |
  % 7
  b fis b b' |
  % 8
  a8 g fis e d4. cis8 |
  % 9
  b cis d e fis4 d |
  % 10
  a' b fis e8 fis |
  % 11
  g e fis4 b, b' |
  % 12
  a dis,8 f fis4 fis, |
  % 13
  fis'8 e d e a,4 ais |
  % 14
  b cis d e8 fis |
  % 15
  g fis e4 fis fis, |
  % 16
  b2. 
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
