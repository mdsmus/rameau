% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 104.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 100 
  
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
  fis4 a a g |
  % 5
  fis b b ais |
  % 6
  b2. fis4 |
  % 7
  b cis d cis |
  % 8
  b cis ais2 |
  % 9
  fis4 a a g |
  % 10
  fis b b ais |
  % 11
  b2. cis4 |
  % 12
  d e fis8 e fis g |
  % 13
  e4 e d fis |
  % 14
  e d cis b8 cis |
  % 15
  d e cis4 b2 |
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
  fis4 fis fis8 g a4 |
  % 3
  g g fis2 |
  % 4
  cis4 cis8 d e4 e |
  % 5
  fis8 e d4 cis8 d e4 |
  % 6
  d2. d8 e |
  % 7
  fis4 fis fis8 g a4 |
  % 8
  g g fis2 |
  % 9
  cis4 cis8 d e4 e |
  % 10
  fis8 e d4 cis8 d e4 |
  % 11
  d2. fis4 |
  % 12
  fis8 b a g fis4 b |
  % 13
  b a8 g fis4 a |
  % 14
  ais b e,8 dis e4 |
  % 15
  fis8 g fis e dis2 |
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
  d4 cis b cis8 d |
  % 3
  e4 e8 d cis2 |
  % 4
  ais4 a a8 b cis4 |
  % 5
  cis b8 a g4 fis |
  % 6
  fis2. b8 cis |
  % 7
  d4 cis b cis8 d |
  % 8
  e4 e8 d cis2 |
  % 9
  ais4 a a8 b cis4 |
  % 10
  cis b8 a g4 fis |
  % 11
  fis2. ais4 |
  % 12
  b8 g' fis e d4 d |
  % 13
  d8 b cis4 a a8 b |
  % 14
  cis4 fis,8 g a fis b4 |
  % 15
  b ais fis2 |
  % 16
  
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
  s2. b4 |
  % 2
  b' ais b fis |
  % 3
  g8 fis e4 fis2 |
  % 4
  fis,4 fis' cis b8 a |
  % 5
  d4 g8 fis e4 fis |
  % 6
  b,2. b'4 |
  % 7
  b ais b fis |
  % 8
  g8 fis e4 fis2 |
  % 9
  fis,4 fis' cis b8 a |
  % 10
  d4 g8 fis e4 fis |
  % 11
  b,2. fis'4 |
  % 12
  b cis d8 cis b a |
  % 13
  g4 a d, d |
  % 14
  cis b a g |
  % 15
  fis'8 e fis4 b,2 |
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
