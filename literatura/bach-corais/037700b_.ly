% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 037700b_.mid
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
  s2. d'8 e |
  % 2
  fis4 g a a |
  % 3
  g fis e a |
  % 4
  b cis d cis |
  % 5
  b2 a4 d,8 e |
  % 6
  fis4 g a a |
  % 7
  g fis e a |
  % 8
  b cis d cis |
  % 9
  b2 a4 a |
  % 10
  d cis b a |
  % 11
  g fis e a |
  % 12
  g fis e8 fis g4 |
  % 13
  fis e d2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  d d e d8 cis |
  % 3
  b cis d4 cis e |
  % 4
  fis8 gis a4 b a2 gis4 e a, |
  % 6
  d d e d8 cis |
  % 7
  b cis d4 cis e |
  % 8
  fis8 gis a4 b a2 gis4 e e |
  % 10
  fis e d8 e fis4 |
  % 11
  e a,8 b cis4 fis8 e |
  % 12
  d e4 d cis8 d4 |
  % 13
  d cis a2 |
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
  s2. fis8 g |
  % 2
  a4 g8 fis e4 fis |
  % 3
  g a a a |
  % 4
  d e e e |
  % 5
  fis e8 d cis4 fis,8 g |
  % 6
  a4 g8 fis e4 fis |
  % 7
  g a2 cis4 |
  % 8
  d e e e |
  % 9
  fis e8 d cis4 cis8 b |
  % 10
  a fis g a b4 b |
  % 11
  b8 cis d4 a cis |
  % 12
  b8 a a4 a g |
  % 13
  a4. g8 fis2 |
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
  s2. d4 |
  % 2
  d8 cis b4 cis d |
  % 3
  e fis8 g a4 cis |
  % 4
  b a gis a |
  % 5
  d, e a, d |
  % 6
  d8 cis b4 cis d |
  % 7
  e fis8 g a4 cis |
  % 8
  b a gis a |
  % 9
  d, e a, a'8 g |
  % 10
  fis d e fis g fis e dis |
  % 11
  e4 fis8 gis a4 fis |
  % 12
  b,8 cis d4 a b |
  % 13
  a8 g a4 d,2 |
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
