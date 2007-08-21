% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024514b_.mid
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
  cis''4 b a b |
  % 2
  cis d e2 |
  % 3
  fis4 e d cis8 b |
  % 4
  b2 a |
  % 5
  cis4 e d cis |
  % 6
  b a gis2 |
  % 7
  a4 b cis cis8 d16 e |
  % 8
  d2 cis |
  % 9
  cis8 b cis d e4 d |
  % 10
  cis b cis2 |
  % 11
  b4 b cis8 dis e4 |
  % 12
  e dis e2 |
  % 13
  e4 cis fis4. e8 |
  % 14
  d4 cis8 b b2 |
  % 15
  cis4 cis8 d16 e d4 cis8 b |
  % 16
  b2 a |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''4 gis fis e |
  % 2
  e fis g2 |
  % 3
  fis4 gis a8 b e, a |
  % 4
  a4 gis e2 |
  % 5
  a4 b a a |
  % 6
  gis fis f2 |
  % 7
  fis4 e e fis |
  % 8
  fis8 a gis fis gis2 |
  % 9
  fis4 fis cis8 gis' a b |
  % 10
  a4 gis a2 |
  % 11
  fis4 e a b |
  % 12
  cis b8 a gis2 |
  % 13
  gis4 a a g |
  % 14
  g8 fis e4 d2 |
  % 15
  fis4 e8 fis gis4 a |
  % 16
  a8 fis gis4 e2 |
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
  fis'4 cis cis b |
  % 2
  a a a2 |
  % 3
  d4 cis cis8 b cis d |
  % 4
  e4 d8 cis cis2 |
  % 5
  e4 e fis e |
  % 6
  d cis cis2 |
  % 7
  cis4 b a8 b cis4 |
  % 8
  cis b8 a b2 |
  % 9
  a4 a' gis fis |
  % 10
  e e e2 |
  % 11
  dis4 e e8 fis g4 |
  % 12
  fis b, b2 |
  % 13
  cis4 cis c b8 ais |
  % 14
  b4 ais b2 |
  % 15
  a4 a b e, |
  % 16
  e' d16 cis d8 cis2 |
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
  fis4 f fis gis |
  % 2
  a fis cis2 |
  % 3
  d4 e fis8 gis a4 |
  % 4
  e2 a, |
  % 5
  a'4 gis fis8 gis a4 |
  % 6
  f fis cis2 |
  % 7
  fis4 gis a ais |
  % 8
  b2 f |
  % 9
  fis8 gis a b cis4 fis,8 gis |
  % 10
  a4 e a,2 |
  % 11
  a'4 gis g fis8 e |
  % 12
  ais4 b e,2 |
  % 13
  cis4 fis d g |
  % 14
  e fis b,2 |
  % 15
  fis'8 e d cis b4 cis8 d |
  % 16
  e2 a, |
  % 17
  
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
  fis4 f fis gis |
  % 2
  a fis cis2 |
  % 3
  d4 e fis8 gis a4 |
  % 4
  e2 a, |
  % 5
  a'4 gis fis8 gis a4 |
  % 6
  f fis cis2 |
  % 7
  fis4 gis a ais |
  % 8
  b2 f |
  % 9
  fis8 gis a b cis4 fis,8 gis |
  % 10
  a4 e a,2 |
  % 11
  a'4 gis g fis8 e |
  % 12
  ais,4 b e,2 |
  % 13
  cis'4 fis d g |
  % 14
  e fis fis2 |
  % 15
  fis8 e d cis b4 cis8 d |
  % 16
  e2 a, |
  % 17
  
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
