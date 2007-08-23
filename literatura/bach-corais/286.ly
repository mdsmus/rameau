% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 286.mid
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
  d d cis8 b cis4 |
  % 5
  b2. fis4 |
  % 6
  b a g fis |
  % 7
  e2 fis4 cis' |
  % 8
  d d cis8 b cis4 |
  % 9
  b2. d4 |
  % 10
  cis8 b a4 b cis |
  % 11
  d2 d4 a |
  % 12
  b a g8 fis g4 |
  % 13
  fis2. d'4 |
  % 14
  cis8 d e4 d cis |
  % 15
  b2 cis4 fis, |
  % 16
  g fis e a |
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
  d cis8 b cis4 fis |
  % 4
  fis fis fis4. e8 |
  % 5
  d2. d4 |
  % 6
  d8 e fis4 b,8 cis d4 |
  % 7
  d cis8 b cis4 fis |
  % 8
  fis fis fis4. e8 |
  % 9
  d2. fis4 |
  % 10
  e e8 d cis4 g' |
  % 11
  a g fis fis |
  % 12
  fis8 e e dis e4 e |
  % 13
  dis2. e4 |
  % 14
  e e fis8 e4 gis8 |
  % 15
  fis4 e e d |
  % 16
  d d e e |
  % 17
  e d cis2 |
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
  b8 cis d4 d8 cis cis b |
  % 3
  b ais b4 ais ais |
  % 4
  b b b ais |
  % 5
  fis2. b4 |
  % 6
  b8 cis d4 d8 cis cis b |
  % 7
  b ais b4 ais ais |
  % 8
  b b b ais |
  % 9
  fis2. b8 a |
  % 10
  g4 a g8 b e4 |
  % 11
  d8 c b4 a d8 c |
  % 12
  b4 c8 b b4 b |
  % 13
  b2. b4 |
  % 14
  a4. gis8 a b cis4 |
  % 15
  d8 b gis4 a a |
  % 16
  b a a cis |
  % 17
  cis8 ais b gis ais2 |
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
  g2 fis4 fis |
  % 4
  b,8 cis d e fis4 fis |
  % 5
  b,2. b'8 a |
  % 6
  g4 fis e d |
  % 7
  g2 fis4 fis |
  % 8
  b,8 cis d e fis4 fis |
  % 9
  b,2. b'4 |
  % 10
  e, fis g fis8 e |
  % 11
  fis4 g d d |
  % 12
  g fis e8 g fis e |
  % 13
  b'2. gis4 |
  % 14
  a8 b cis4 fis,8 gis a4 |
  % 15
  d, e a, d8 cis |
  % 16
  b cis d4. cis8 b cis |
  % 17
  d cis b4 fis'2 |
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
