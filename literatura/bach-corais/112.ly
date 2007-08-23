% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 112.mid
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
  b cis d cis |
  % 3
  b cis ais2 |
  % 4
  fis s4 a |
  % 5
  a g fis b |
  % 6
  b ais b fis |
  % 7
  b cis d cis |
  % 8
  b cis ais2 |
  % 9
  fis s4 a |
  % 10
  a g fis b |
  % 11
  b ais b cis |
  % 12
  d e fis fis |
  % 13
  e4. d8 d4 fis |
  % 14
  e d cis b8 cis |
  % 15
  d4 cis b2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 e |
  % 2
  fis4 fis fis fis8 e |
  % 3
  d4 g fis2 |
  % 4
  cis s4 fis |
  % 5
  fis e d d |
  % 6
  g fis fis d8 e |
  % 7
  fis4 fis fis fis8 e |
  % 8
  d4 g fis2 |
  % 9
  cis s4 fis |
  % 10
  fis e d d |
  % 11
  g fis fis ais |
  % 12
  b a a b |
  % 13
  b a a a |
  % 14
  ais b b8 ais b4 |
  % 15
  b ais fis2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'8 cis |
  % 2
  d4 cis b ais |
  % 3
  b e8 d cis2 |
  % 4
  ais s4 cis |
  % 5
  d a a b |
  % 6
  cis cis d b8 cis |
  % 7
  d4 cis b ais |
  % 8
  b e8 d cis2 |
  % 9
  ais s4 cis |
  % 10
  d a a b |
  % 11
  cis cis d fis |
  % 12
  fis e d d |
  % 13
  d cis fis d |
  % 14
  e fis g8 fis fis e |
  % 15
  fis4. e8 dis2 |
  % 16
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. b4 |
  % 2
  b' ais b fis |
  % 3
  g e fis2 |
  % 4
  fis, s4 fis' |
  % 5
  b, cis d g8 fis |
  % 6
  e4 fis b, b |
  % 7
  b' ais b fis |
  % 8
  g e fis2 |
  % 9
  fis, s4 fis' |
  % 10
  b, cis d g8 fis |
  % 11
  e4 fis b, fis' |
  % 12
  b cis d8 cis b a |
  % 13
  g4 a d, d' |
  % 14
  cis b e,8 fis g4 |
  % 15
  fis8 e fis4 b,2 |
  % 16
  
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
