% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 076.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''4 b cis b |
  % 2
  a gis fis2 |
  % 3
  e a4 b |
  % 4
  cis d cis b |
  % 5
  a1 |
  % 6
  a4 b cis b |
  % 7
  a gis fis2 |
  % 8
  e a4 b |
  % 9
  cis d cis b |
  % 10
  a1 |
  % 11
  cis4 d e d |
  % 12
  cis b cis2 |
  % 13
  e4 e fis e |
  % 14
  d cis b2 |
  % 15
  cis8 d e4 d cis8 b |
  % 16
  a4 b cis2 |
  % 17
  a cis8 d e4 |
  % 18
  d cis b cis8. d16 |
  % 19
  b2 a |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 e a dis, |
  % 2
  e8 fis fis e e4 dis |
  % 3
  b2 fis'4 fis8 e |
  % 4
  e4 b' b8 a a gis |
  % 5
  e1 |
  % 6
  e4 e a dis, |
  % 7
  e8 fis fis e e4 dis |
  % 8
  b2 fis'4 fis8 e |
  % 9
  e4 b' b8 a a gis |
  % 10
  e1 |
  % 11
  a4 a8 g g4 fis8 gis |
  % 12
  ais4 b8 b, fis'2 |
  % 13
  e4 a8 g fis4 gis |
  % 14
  a8 e4 fis8 gis2 |
  % 15
  a4 b a gis |
  % 16
  gis8 fis fis gis a4 gis |
  % 17
  fis2 ais4 b8 fis |
  % 18
  fis gis a4 gis a4. gis16 fis gis4 e2 |
  % 20
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  cis'4 e e8 fis fis gis |
  % 2
  cis, b b4 cis b8 a |
  % 3
  gis2 cis4 b |
  % 4
  b8 a a gis e'4 e8 d |
  % 5
  cis1 |
  % 6
  cis4 e e8 fis fis gis |
  % 7
  cis, b b4 cis b8 a |
  % 8
  gis2 cis4 b |
  % 9
  b8 a a gis e'4 e8 d |
  % 10
  cis1 |
  % 11
  e4 b b8 ais b4 |
  % 12
  fis8 fis'4 e8 ais,2 |
  % 13
  a8 b cis4 cis8 b b cis |
  % 14
  cis b cis dis e2 |
  % 15
  e4 e a,8 b cis4 |
  % 16
  cis d8 b fis'4. f8 |
  % 17
  cis2 fis4 b,8 cis |
  % 18
  d4 e e e |
  % 19
  e4. d8 cis2 |
  % 20
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  a'4 gis a b |
  % 2
  cis8 dis e4 a, b |
  % 3
  e,2 fis4 gis |
  % 4
  a b cis8 d e e, |
  % 5
  a1 |
  % 6
  a4 gis a b |
  % 7
  cis8 dis e4 a, b |
  % 8
  e,2 fis4 gis |
  % 9
  a b cis8 d e e, |
  % 10
  a1 |
  % 11
  a,4 b cis d8 e |
  % 12
  fis4 g fis2 |
  % 13
  cis8 b a4 d e |
  % 14
  fis8 gis a4 e2 |
  % 15
  a4 a8 gis fis4 f |
  % 16
  fis8 e d4 a'8 b cis4 |
  % 17
  fis,2 fis4 gis8 ais |
  % 18
  b4 cis8 d e, d cis a |
  % 19
  e'2 a, |
  % 20
  
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
