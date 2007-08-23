% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 334.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \major
  
  \tempo 4 = 120 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 d''4 d2 cis4 b2 |
  % 3
  a4 d e2 |
  % 4
  fis fis4 fis2 fis4 e2 |
  % 6
  fis4 g fis2 |
  % 7
  e d4 e2 fis4 e2 |
  % 9
  d4 b cis2 |
  % 10
  d a'4 fis2 d4 e2 |
  % 12
  g4 fis e2 |
  % 13
  d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 a''4 b2 a4 g2 |
  % 3
  fis4 fis b a |
  % 4
  a2 cis4 b2 b4 b a |
  % 6
  a a d a |
  % 7
  a2 b4 a2 a4 b a8 g |
  % 9
  fis4 b b ais |
  % 10
  b2 a4 a2 b4 a2 |
  % 12
  a4 a g2 |
  % 13
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
  s2 fis'4 fis2 fis4 d2 |
  % 3
  d4 d2 cis4 |
  % 4
  d2 cis4 d2 d4 d cis |
  % 6
  d e a, d |
  % 7
  cis2 fis4 e2 d4 d cis |
  % 9
  d d g fis |
  % 10
  fis2 e4 fis2 fis4 e2 |
  % 12
  cis4 a b cis |
  % 13
  a2. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2 d4 b |
  % 2
  d fis g b |
  % 3
  d b g a |
  % 4
  d,2 ais'4 b2 a4 gis a |
  % 6
  fis cis d fis |
  % 7
  a2 b4 cis2 d4 g, a |
  % 9
  b g e fis |
  % 10
  b,2 cis'4 d |
  % 11
  cis b cis b |
  % 12
  a d g, a |
  % 13
  d,2. 
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
