% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024425b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'8 g |
  % 2
  a4 b a d |
  % 3
  d cis d d |
  % 4
  cis b e d8 cis |
  % 5
  cis2 b4 fis8 g |
  % 6
  a4 b a d |
  % 7
  d cis d d |
  % 8
  cis b e d8 cis |
  % 9
  cis2 b4 b |
  % 10
  b b cis8 b a4 |
  % 11
  a gis a a |
  % 12
  b cis d cis |
  % 13
  b2 cis4 fis,8 g |
  % 14
  a4 b a d |
  % 15
  d cis d d |
  % 16
  cis b e d8 cis |
  % 17
  cis2 b |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  d d d d8 e |
  % 3
  fis g a4 a gis |
  % 4
  a g8 a b4 b |
  % 5
  b ais fis d |
  % 6
  d d d d8 e |
  % 7
  fis g a4 a gis |
  % 8
  a g8 a b4 b |
  % 9
  b ais fis fis |
  % 10
  e8 fis gis4 gis fis |
  % 11
  fis e e fis |
  % 12
  fis8 e e d d4 e |
  % 13
  fis gis8 f fis4 fis |
  % 14
  fis fis8 f fis4 fis |
  % 15
  e fis8 g fis4 fis |
  % 16
  e8 fis gis ais b4 b |
  % 17
  b ais fis2 |
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
  s2. b'4 |
  % 2
  a g fis8 g a b |
  % 3
  a4 e' fis e8 d |
  % 4
  e fis g4 g fis |
  % 5
  g fis8 e d4 b |
  % 6
  a g fis8 g a b |
  % 7
  a4 e' fis e8 d |
  % 8
  e fis g4 g fis |
  % 9
  g fis8 e d4 d8 cis |
  % 10
  b4 e8 d cis4 cis |
  % 11
  b cis8 d cis4 d |
  % 12
  d8 cis cis b b ais ais gis |
  % 13
  fis b d gis, ais4 d |
  % 14
  cis d8 b cis4 d8 cis |
  % 15
  b4 a a a8 b |
  % 16
  cis dis e4 b8 cis d4 |
  % 17
  gis, cis dis2 |
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
  s2. b'4 |
  % 2
  fis g d8 e fis g |
  % 3
  a4 a, d b |
  % 4
  a e'8 fis g a b4 |
  % 5
  e, fis b, b' |
  % 6
  fis g d8 e fis g |
  % 7
  a4 a, d b |
  % 8
  a e'8 fis g a b4 |
  % 9
  e, fis b, b'8 a |
  % 10
  gis fis e4 f fis8 e |
  % 11
  dis4 e a, d |
  % 12
  gis, ais b cis |
  % 13
  d b fis' b |
  % 14
  a gis fis b8 a |
  % 15
  gis4 a d, fis8 gis |
  % 16
  a4 gis g fis |
  % 17
  f fis b,2 |
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
