% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 031100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. cis''4 |
  % 2
  d cis b cis8 d |
  % 3
  e4 fis e d |
  % 4
  cis2 s4 e |
  % 5
  d cis d b |
  % 6
  a fis8 g a4 g |
  % 7
  fis2. cis'4 |
  % 8
  d cis b cis8 d |
  % 9
  e4 fis e d |
  % 10
  cis2 s4 e |
  % 11
  d cis d b |
  % 12
  a fis8 g a4 g |
  % 13
  fis2. a4 |
  % 14
  g fis e fis |
  % 15
  d e fis cis' |
  % 16
  d cis b cis8 d |
  % 17
  e4 d cis fis |
  % 18
  e8 d cis d e4 b |
  % 19
  a g fis e |
  % 20
  a b cis8 d e4 |
  % 21
  d cis b d |
  % 22
  cis b a8 g fis g |
  % 23
  a4 g fis1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  fis fis g a |
  % 3
  g fis8 gis ais4 b |
  % 4
  ais2 s4 cis |
  % 5
  b8 a g4 a g8 fis |
  % 6
  e4 d8 e fis4 e8 d |
  % 7
  cis2. fis4 |
  % 8
  fis fis g a |
  % 9
  g fis8 gis ais4 b |
  % 10
  ais2 s4 cis |
  % 11
  b8 a g a a4 g8 fis |
  % 12
  e4 d8 e fis4 e8 d |
  % 13
  cis2. cis4 |
  % 14
  d d cis cis |
  % 15
  d8 cis b4 cis fis |
  % 16
  fis8 gis ais4 b ais8 b |
  % 17
  cis fis, fis4 fis a |
  % 18
  gis a e e |
  % 19
  e8 d e cis d4 cis |
  % 20
  cis8 dis e4 e8 fis g fis |
  % 21
  fis gis a4 gis fis |
  % 22
  e8 fis g4 fis8 e d4 |
  % 23
  e2. d2 cis8 b cis2 |
  % 25
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'4 |
  % 2
  b cis8 d e4 a, |
  % 3
  b8 cis d4 e fis |
  % 4
  fis2 s4 fis |
  % 5
  fis e d d |
  % 6
  e a,8 b c4 b |
  % 7
  ais2. ais4 |
  % 8
  b cis8 d e4 a, |
  % 9
  b8 cis d4 e fis |
  % 10
  fis2 s4 fis |
  % 11
  fis e d d |
  % 12
  e a,8 b c4 b |
  % 13
  ais2. a4 |
  % 14
  b a a8 g fis4 |
  % 15
  fis b ais ais |
  % 16
  b e fis e8 d |
  % 17
  cis4 b ais b |
  % 18
  b a b8 a gis4 |
  % 19
  a a a a |
  % 20
  a gis ais8 b cis4. b8 e4 e a,8 b |
  % 22
  cis4 d d a |
  % 23
  a b cis b2 ais8 gis ais2 |
  % 25
  
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
  s2. fis4 |
  % 2
  b a g fis |
  % 3
  e d cis b |
  % 4
  fis'2 s4 ais |
  % 5
  b e, fis g |
  % 6
  cis, d dis e |
  % 7
  fis2. fis4 |
  % 8
  b a g fis |
  % 9
  e d cis b |
  % 10
  fis'2 s4 ais |
  % 11
  b e, fis g |
  % 12
  cis, d dis e |
  % 13
  fis2. fis4 |
  % 14
  b,8 cis d4 a ais |
  % 15
  b g fis fis' |
  % 16
  b cis d cis8 b |
  % 17
  ais4 b fis dis |
  % 18
  e fis gis8 fis e d |
  % 19
  cis b cis a d4 a'8 gis |
  % 20
  fis4 e8 d cis b ais4 |
  % 21
  b cis8 dis e4 fis8 gis |
  % 22
  a4 b8 cis d4 d, |
  % 23
  c b ais b |
  % 24
  fis1 |
  % 25
  
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
