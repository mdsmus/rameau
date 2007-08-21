% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 034700b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 76 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a a a b |
  % 3
  g fis e b' |
  % 4
  cis b a gis8 fis |
  % 5
  gis4 fis e a |
  % 6
  a a a b |
  % 7
  g fis e b' |
  % 8
  cis b a gis8 fis |
  % 9
  gis4 fis e e' |
  % 10
  d cis b a |
  % 11
  a8 b cis4 b cis |
  % 12
  d cis b ais |
  % 13
  b2. e,4 |
  % 14
  a b cis d |
  % 15
  e d8 cis b4 d |
  % 16
  cis b e4. d8 |
  % 17
  cis b a b cis4 b |
  % 18
  a2. 
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
  fis e fis fis |
  % 3
  e dis b gis' |
  % 4
  a gis8 fis e2. dis4 b e |
  % 6
  fis e fis fis |
  % 7
  e dis b gis' |
  % 8
  a gis8 fis e2. dis4 b cis'8 b |
  % 10
  a4 a gis a8 g |
  % 11
  fis gis a4 gis ais |
  % 12
  b8 a g4 fis8 e fis4 |
  % 13
  fis2. e8 d |
  % 14
  cis4 d e fis8 gis |
  % 15
  a2 e4 b' |
  % 16
  a8 gis fis4 e fis8 gis |
  % 17
  a2 a4 gis |
  % 18
  e2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. cis'4 |
  % 2
  cis cis8 b a gis fis4 |
  % 3
  b4. a8 gis4 e' |
  % 4
  e dis cis2 |
  % 5
  b4. a8 gis4 cis |
  % 6
  cis cis8 b a gis fis4 |
  % 7
  b4. a8 gis4 e' |
  % 8
  e dis cis2 |
  % 9
  b4. a8 gis4 gis |
  % 10
  a8 b cis d e4 e |
  % 11
  d e e e |
  % 12
  fis8 b,4 ais8 b4 cis |
  % 13
  d2. gis,4 |
  % 14
  a gis8 fis e e' d4 |
  % 15
  cis8 d e fis gis4 fis |
  % 16
  fis8 e d cis b4 cis8 d |
  % 17
  e4. d8 cis fis b, e16 d |
  % 18
  cis2. 
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
  s2. a'8 gis |
  % 2
  fis4 cis d dis |
  % 3
  e b e, e' |
  % 4
  a b cis b8 a |
  % 5
  b4 b, e a8 gis |
  % 6
  fis4 cis d dis |
  % 7
  e b e, e' |
  % 8
  a b cis b8 a |
  % 9
  b4 b, e cis |
  % 10
  fis8 gis a4 e cis8 a |
  % 11
  d4 cis8 d e4 cis |
  % 12
  b cis d8 g fis4 |
  % 13
  b,2. cis4 |
  % 14
  fis e8 d cis4 b |
  % 15
  a8 b cis d e4 b |
  % 16
  fis'8 gis a4 gis8 e a4. gis8 fis4 e8 d e4 |
  % 18
  a,2. 
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
