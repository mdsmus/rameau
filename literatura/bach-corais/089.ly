% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 089.mid
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
  s2. fis'4 |
  % 2
  b a g fis |
  % 3
  e2 fis4 cis' |
  % 4
  d cis8 d16 e d4 cis8 b |
  % 5
  b2. fis4 |
  % 6
  b a g fis |
  % 7
  e2 fis4 cis' |
  % 8
  d cis8 d16 e d4 cis8 b |
  % 9
  b2. d4 |
  % 10
  cis8 b a4 b cis |
  % 11
  d2 d4 a |
  % 12
  b a b8 a g4 |
  % 13
  fis2. d'4 |
  % 14
  cis8 d e4 d cis |
  % 15
  b2 cis4 fis, |
  % 16
  g fis e a8 g |
  % 17
  fis1 |
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
  d8 e fis4 b,8 cis d4 |
  % 3
  d cis d fis |
  % 4
  fis g fis e8 d |
  % 5
  d2. d4 |
  % 6
  d8 e fis4 b,8 cis d4 |
  % 7
  d cis d fis |
  % 8
  fis g fis e8 d |
  % 9
  d2. fis4 |
  % 10
  gis fis g g |
  % 11
  a g fis fis |
  % 12
  fis8 e dis e fis4. e8 |
  % 13
  e4 dis2 b'4 |
  % 14
  a a a8 b cis a |
  % 15
  a4 gis a d, |
  % 16
  e d e fis8 e |
  % 17
  e4 d cis2 |
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
  b8 cis d4 e a, |
  % 3
  b a a cis |
  % 4
  b b b ais |
  % 5
  fis2. b4 |
  % 6
  b8 cis d4 e a, |
  % 7
  b a a cis |
  % 8
  b b b ais |
  % 9
  fis2. b8 a |
  % 10
  gis4 cis d e |
  % 11
  d8 c4 ais8 a4 d8 c |
  % 12
  b4 c b b |
  % 13
  b2. e4 |
  % 14
  e e8 fis16 g fis4 e |
  % 15
  fis e e a, |
  % 16
  a a a8 b c4 |
  % 17
  cis b ais2 |
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
  s2. b'8 a |
  % 2
  g4 fis e d |
  % 3
  gis, a d ais |
  % 4
  b e fis fis, |
  % 5
  b2. b'8 a |
  % 6
  g4 fis e d |
  % 7
  gis, a d ais |
  % 8
  b e fis fis, |
  % 9
  b2. b'4 |
  % 10
  f fis f e |
  % 11
  fis g d d |
  % 12
  g fis8 e dis4 e |
  % 13
  b2. gis'4 |
  % 14
  a8 b cis4 fis,8 gis a4 |
  % 15
  dis, e a, d |
  % 16
  cis d c8 b a4 |
  % 17
  ais b fis2 |
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
