% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 012306b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/2 
  

  \key b \minor
  
  \tempo 4 = 160 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d''2 d |
  % 2
  d cis2. b4 a2 |
  % 4
  b g |
  % 5
  fis4 e e1 d2 |
  % 7
  a' a |
  % 8
  fis b2. cis4 d2 |
  % 10
  d,4 e e2. fis4 fis1. d'2 d |
  % 14
  d cis2. b4 a2 |
  % 16
  b g |
  % 17
  fis4 e e1 d2 |
  % 19
  a' a |
  % 20
  fis b2. cis4 d2 |
  % 22
  d,4 e e2. fis4 fis1. fis2 fis |
  % 26
  g a |
  % 27
  fis1 |
  % 28
  b2 ais |
  % 29
  b cis |
  % 30
  ais1 |
  % 31
  d2 cis |
  % 32
  b ais2. fis4 b2 |
  % 34
  cis4 d ais2. b4 b1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'2 fis |
  % 2
  f4 fis gis2 |
  % 3
  f fis |
  % 4
  g e |
  % 5
  d d |
  % 6
  cis a |
  % 7
  d e |
  % 8
  d d |
  % 9
  g fis |
  % 10
  fis e4 d |
  % 11
  cis b cis1. fis2 fis |
  % 14
  f4 fis gis2 |
  % 15
  f fis |
  % 16
  g e |
  % 17
  d d |
  % 18
  cis a |
  % 19
  d e |
  % 20
  d d |
  % 21
  g fis |
  % 22
  fis e4 d |
  % 23
  cis b cis1. d2 d |
  % 26
  d e |
  % 27
  d1 |
  % 28
  fis2 e |
  % 29
  fis fis |
  % 30
  fis1 |
  % 31
  fis2 g |
  % 32
  e fis2. fis4 fis2 |
  % 34
  g fis |
  % 35
  fis fis1. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'2 b |
  % 2
  b4 a gis2 |
  % 3
  cis cis |
  % 4
  d e4 a, |
  % 5
  a2 a2. g4 fis2 |
  % 7
  a a |
  % 8
  a g4 a |
  % 9
  b2 b |
  % 10
  b b |
  % 11
  e ais,1. b2 b |
  % 14
  b4 a gis2 |
  % 15
  cis cis |
  % 16
  d e4 a, |
  % 17
  a2 a2. g4 fis2 |
  % 19
  a a |
  % 20
  a g4 a |
  % 21
  b2 b |
  % 22
  b b |
  % 23
  e ais,1. b2 b |
  % 26
  b a |
  % 27
  a1 |
  % 28
  b2 cis |
  % 29
  d ais |
  % 30
  cis1 |
  % 31
  b2 ais |
  % 32
  b cis2. cis4 b2 |
  % 34
  e4 d cis2 |
  % 35
  cis dis1. 
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
  b2 b'4 a |
  % 2
  gis fis f2 |
  % 3
  cis fis |
  % 4
  b, cis |
  % 5
  d a' |
  % 6
  a, d |
  % 7
  fis cis |
  % 8
  d g |
  % 9
  e b |
  % 10
  a g |
  % 11
  g' fis1. b,2 b'4 a |
  % 14
  gis fis f2 |
  % 15
  cis fis |
  % 16
  b, cis |
  % 17
  d a' |
  % 18
  a, d |
  % 19
  fis cis |
  % 20
  d g |
  % 21
  e b |
  % 22
  a g |
  % 23
  g' fis1. b,2 d |
  % 26
  e cis |
  % 27
  d1 |
  % 28
  d2 cis |
  % 29
  b fis' |
  % 30
  fis1 |
  % 31
  b2 e, |
  % 32
  g fis |
  % 33
  e d |
  % 34
  e fis |
  % 35
  fis, b1. 
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
