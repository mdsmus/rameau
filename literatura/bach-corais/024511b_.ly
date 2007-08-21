% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024511b_.mid
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
  s2. cis''4 |
  % 2
  a b cis8 d e4 |
  % 3
  d2 cis4 cis |
  % 4
  e e b d8 cis |
  % 5
  a2 gis4 e |
  % 6
  a b cis8 d16 e d8 cis |
  % 7
  b2. cis4 |
  % 8
  a b cis8 d e4 |
  % 9
  d2 cis4 cis8 d |
  % 10
  e4 e b cis |
  % 11
  a2 gis4 e |
  % 12
  a b cis8 d e d |
  % 13
  cis4 b a2 |
  % 14
  
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
  fis gis a8 b cis4 |
  % 3
  cis b8 a gis4 a |
  % 4
  a a gis b8 a |
  % 5
  fis2 e4 b |
  % 6
  e fis8 gis a b16 cis b8 a |
  % 7
  gis2. gis4 |
  % 8
  fis e e fis |
  % 9
  fis f fis fis |
  % 10
  e a8 gis fis4 e8 dis16 cis |
  % 11
  fis2 e4 e |
  % 12
  e d cis8 e a4 |
  % 13
  a gis e2 |
  % 14
  
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
  d d e a, |
  % 3
  a b cis fis |
  % 4
  e e e e |
  % 5
  e dis gis, gis |
  % 6
  a d e8 a, gis a |
  % 7
  e'2. cis4 |
  % 8
  cis b a8 b cis4 |
  % 9
  b gis ais a |
  % 10
  a a a gis |
  % 11
  cis b b cis |
  % 12
  cis b e4. fis8 |
  % 13
  e4 d cis2 |
  % 14
  
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
  s2. a'4 |
  % 2
  d cis8 b a4. g8 |
  % 3
  fis2 f4 fis |
  % 4
  cis8 b cis d e4 a, |
  % 5
  b c cis d |
  % 6
  cis b a d |
  % 7
  e2. f4 |
  % 8
  fis gis a ais |
  % 9
  b2 fis4 fis |
  % 10
  cis8 b cis4 dis e |
  % 11
  e dis e cis |
  % 12
  fis8 e fis gis a4 cis,8 d |
  % 13
  e4 e a,2 |
  % 14
  
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
