% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 365.mid
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
  cis''4 d e e |
  % 2
  d cis b b |
  % 3
  cis d e8 d cis4 |
  % 4
  b b a2 |
  % 5
  cis4 d e e |
  % 6
  d cis b b |
  % 7
  cis d e8 d cis4 |
  % 8
  b b a2 |
  % 9
  b4 cis d d |
  % 10
  cis cis b2 |
  % 11
  d4 e fis fis |
  % 12
  e e d2 |
  % 13
  cis4 d e e |
  % 14
  d cis b b |
  % 15
  cis d e8 d cis4 |
  % 16
  b b a2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''4 a gis a |
  % 2
  a8 gis a4 gis gis |
  % 3
  a a b4. a8 |
  % 4
  a4 gis e2 |
  % 5
  a4 a gis a |
  % 6
  a8 gis a4 gis gis |
  % 7
  a a b4. a8 |
  % 8
  a4 gis e2 |
  % 9
  gis4 ais b b |
  % 10
  b ais fis2 |
  % 11
  fis4 a a4. b16 c |
  % 12
  b4 a8 g fis2 |
  % 13
  e4 a e8 fis g4 |
  % 14
  fis8 gis e fis gis4 gis |
  % 15
  a a b8 gis a4 |
  % 16
  a gis e2 |
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
  e'4 fis e8 d cis4 |
  % 2
  d e e e |
  % 3
  e fis e4. fis16 g |
  % 4
  fis4 e8 d cis2 |
  % 5
  e4 fis e8 d cis4 |
  % 6
  d e e e |
  % 7
  e fis e4. fis16 g |
  % 8
  fis4 e8 d cis2 |
  % 9
  e4 e fis fis |
  % 10
  fis8 g fis e d2 |
  % 11
  d4 cis d d |
  % 12
  d cis a2 |
  % 13
  a4 a b cis4. b4 a8 e'4 e |
  % 15
  e fis e e |
  % 16
  fis e8 d cis2 |
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
  a'4 fis cis fis |
  % 2
  b, cis8 d e4 e |
  % 3
  a8 gis fis4 gis a |
  % 4
  d, e a,2 |
  % 5
  a'4 fis cis fis |
  % 6
  b, cis8 d e4 e |
  % 7
  a8 gis fis4 gis a |
  % 8
  d, e a,2 |
  % 9
  e'4 d8 cis b cis d e |
  % 10
  fis4 fis b,2 |
  % 11
  b'4 a8 g fis e d4 |
  % 12
  g a d,2 |
  % 13
  a'8 gis fis4 g ais, |
  % 14
  b cis8 d e4 e |
  % 15
  a,8 a' gis fis gis e a cis, |
  % 16
  d b e4 a,2 |
  % 17
  
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
