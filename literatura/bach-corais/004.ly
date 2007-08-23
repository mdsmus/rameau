% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004.mid
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
  b b b d |
  % 3
  cis b a b |
  % 4
  gis e8 fis gis4 ais |
  % 5
  b cis b b |
  % 6
  b b b d |
  % 7
  cis b a b |
  % 8
  gis e8 fis gis4 ais |
  % 9
  b cis b b |
  % 10
  e dis cis dis |
  % 11
  e8 dis cis4 b b |
  % 12
  e b cis gis8 a |
  % 13
  b4 a gis gis |
  % 14
  fis a gis fis |
  % 15
  cis dis e2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  fis8 gis a4 gis fis |
  % 3
  e8 a a gis e4 fis |
  % 4
  e e8 dis e4 cis |
  % 5
  fis8 e16 dis e4 dis gis |
  % 6
  fis8 gis a4 gis fis |
  % 7
  e8 a a gis e4 fis |
  % 8
  e e8 dis e4 cis |
  % 9
  fis8 e16 dis e4 dis e8 fis |
  % 10
  gis ais b4 ais b |
  % 11
  b fis fis gis |
  % 12
  e8 fis gis4 a e8 fis |
  % 13
  gis4 fis f e |
  % 14
  dis cis b b |
  % 15
  cis b b2 |
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
  s2. e'4 |
  % 2
  fis e8 dis e4 a,8 b |
  % 3
  cis16 d e4 d8 cis4 b |
  % 4
  b b8 a gis4 fis |
  % 5
  fis8 b4 ais8 fis4 e' |
  % 6
  fis e8 dis e4 a,8 b |
  % 7
  cis16 d e4 d8 cis4 b |
  % 8
  b b8 a gis4 fis |
  % 9
  fis8 b4 ais8 fis4 gis |
  % 10
  cis fis, fis' fis |
  % 11
  b, ais dis e |
  % 12
  b e e cis |
  % 13
  d cis cis b |
  % 14
  b e e dis8 b |
  % 15
  fis2 gis |
  % 16
  
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
  dis b e fis8 gis |
  % 3
  a4 e a, dis |
  % 4
  e8 fis gis4 cis, fis8 e |
  % 5
  dis cis16 b fis'4 b, e |
  % 6
  dis b e fis8 gis |
  % 7
  a4 e a, dis |
  % 8
  e8 fis gis4 cis, fis8 e |
  % 9
  dis cis16 b fis'4 b, e |
  % 10
  cis dis8 e fis4 b |
  % 11
  gis8 e fis4 b, e |
  % 12
  gis e a8 b cis4 |
  % 13
  f, fis cis e |
  % 14
  b cis8 dis e4 b |
  % 15
  ais b e,2 |
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
