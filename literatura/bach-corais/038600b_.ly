% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 038600b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e''4 |
  % 2
  e e fis fis |
  % 3
  e2 s4 cis |
  % 4
  d cis b cis8. d16 |
  % 5
  b2 a4 e' |
  % 6
  e2 fis4 fis |
  % 7
  e2 s4 cis |
  % 8
  d cis b cis8. d16 |
  % 9
  b2 a4 b |
  % 10
  b b cis cis |
  % 11
  b2 s4 b |
  % 12
  cis8 dis e4 e dis |
  % 13
  e2 s4 e |
  % 14
  fis e d cis |
  % 15
  d2 s4 cis |
  % 16
  b cis8. d16 b4. a8 |
  % 17
  a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  a a a a |
  % 3
  a2 s4 a |
  % 4
  b a gis a |
  % 5
  a8 fis gis4 e a |
  % 6
  a a a a |
  % 7
  a2 s4 a |
  % 8
  b a gis a |
  % 9
  a8 fis gis4 e gis8 fis |
  % 10
  e4 e e e |
  % 11
  e2 s4 gis |
  % 12
  a gis fis fis |
  % 13
  gis2 s4 a |
  % 14
  a8 b cis4 cis8 b4 ais8 |
  % 15
  b2 s4 a |
  % 16
  gis a a gis |
  % 17
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
  cis cis d d |
  % 3
  cis2 s4 fis |
  % 4
  e e e e |
  % 5
  e8 d16 cis d4 cis cis |
  % 6
  cis cis d d |
  % 7
  cis2 s4 fis |
  % 8
  e e e e |
  % 9
  e8 d16 cis d4 cis b8 a |
  % 10
  gis a b4 b8 a16 gis a4 |
  % 11
  gis2 s4 e' |
  % 12
  e e cis b |
  % 13
  b2 s4 cis |
  % 14
  d cis fis g8 fis |
  % 15
  fis2 s4 e |
  % 16
  e e8 fis fis d b8. e16 |
  % 17
  cis2. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. a4 |
  % 2
  a'8 b cis a d, e fis d |
  % 3
  a'2 s4 a |
  % 4
  gis a e8 d cis a |
  % 5
  e'2 a,4 a |
  % 6
  a'8 b cis a d, e fis d |
  % 7
  a'2 s4 a |
  % 8
  gis a e8 d cis a |
  % 9
  e'2 a,4 e' |
  % 10
  e8 fis gis e a, b cis a |
  % 11
  e2 s4 e' |
  % 12
  a8 b cis gis a fis b b, |
  % 13
  e2 s4 a, |
  % 14
  d8 cis b ais b d e fis |
  % 15
  b,2 s4 cis8 d |
  % 16
  e4 a8 fis d b e e, |
  % 17
  a2. 
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
