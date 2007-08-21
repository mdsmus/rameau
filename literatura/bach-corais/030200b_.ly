% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 030200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  d d a8 b cis4 |
  % 3
  d8 cis b4 a d |
  % 4
  cis b a b |
  % 5
  g8 fis e4 d d' |
  % 6
  d d a8 b cis4 |
  % 7
  d8 cis b4 a d |
  % 8
  cis b a b |
  % 9
  g8 fis e4 d d |
  % 10
  a' b a gis |
  % 11
  a2 d,4 a' |
  % 12
  b cis d cis |
  % 13
  d8 cis b4 a b |
  % 14
  b a b8 a g4 |
  % 15
  fis d' cis b |
  % 16
  a b8 a g4 fis |
  % 17
  e2 d |
  % 18
  
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
  d, d8 e fis4 g |
  % 3
  a gis e b' |
  % 4
  e, d cis b |
  % 5
  cis8 d4 cis8 d4 a' |
  % 6
  d, d8 e fis4 g |
  % 7
  a gis e b' |
  % 8
  e, d cis b |
  % 9
  cis8 d4 cis8 d4 d |
  % 10
  cis d e8 d b4 |
  % 11
  cis2 d8 e fis4 |
  % 12
  g8 fis e4 fis fis |
  % 13
  fis16 gis a4 gis8 e4 g |
  % 14
  g dis8 e fis4 e |
  % 15
  dis fis fis8 e d e |
  % 16
  fis e d4 e8 a, d2 cis4 a2 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. fis'4 |
  % 2
  fis b,8 cis d4 e |
  % 3
  fis4. e16 d cis4 fis,8 gis |
  % 4
  ais4 b fis'8 e d4 |
  % 5
  e8 a,4 g8 fis4 fis' |
  % 6
  fis b,8 cis d4 e |
  % 7
  fis4. e16 d cis4 fis,8 gis |
  % 8
  ais4 b fis'8 e d4 |
  % 9
  e8 a,4 g8 fis4 fis8 g |
  % 10
  a4 gis8 fis e fis e4 |
  % 11
  e2 a4 d |
  % 12
  d a a a |
  % 13
  b8 e fis e cis4 e |
  % 14
  d8 e fis4 b, b |
  % 15
  b b a b8 cis |
  % 16
  d4 g,8 fis e4 fis16 g a8 |
  % 17
  b4 a8 g fis2 |
  % 18
  
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
  s2. d'8 cis |
  % 2
  b4 a8 g fis4 e |
  % 3
  d e a, b |
  % 4
  cis d8 e fis4 g8 fis |
  % 5
  e d a4 d d'8 cis |
  % 6
  b4 a8 g fis4 e |
  % 7
  d e a, b |
  % 8
  cis d8 e fis4 g8 fis |
  % 9
  e d a4 d d8 e |
  % 10
  fis4 e8 d cis d e4 |
  % 11
  a,2 fis'4 e8 d |
  % 12
  g4 a d, fis |
  % 13
  b,8 cis d e a,4 e'8 fis |
  % 14
  g4 fis8 e dis4 e |
  % 15
  b b fis' g |
  % 16
  d8 cis b4 cis d |
  % 17
  g, a d,2 |
  % 18
  
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
