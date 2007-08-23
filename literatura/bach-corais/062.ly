% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 062.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 94 
  
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
  b cis8 b ais4 fis |
  % 4
  s4 a a g |
  % 5
  fis b b ais |
  % 6
  b2. fis4 |
  % 7
  b cis d cis |
  % 8
  b cis8 b ais4 fis |
  % 9
  s4 a a g |
  % 10
  fis b b ais |
  % 11
  b2. cis4 |
  % 12
  d e fis fis |
  % 13
  e4. d8 d4 fis |
  % 14
  e d cis b8 cis |
  % 15
  d4 cis b2. 
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
  d4 g fis cis |
  % 4
  s4 fis fis e |
  % 5
  e8 d d4 g fis |
  % 6
  fis2. d8 e |
  % 7
  fis4 fis fis fis8 e |
  % 8
  d4 g fis cis |
  % 9
  s4 fis fis e |
  % 10
  e8 d d4 g fis |
  % 11
  fis2. fis4 |
  % 12
  fis a a a |
  % 13
  b a a a8 b |
  % 14
  cis4 fis, g8 fis fis e |
  % 15
  fis4 fis8 e dis2. 
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
  b e8 d cis4 ais |
  % 4
  s4 cis d a |
  % 5
  a b cis8 d e4 |
  % 6
  d2. b8 cis |
  % 7
  d4 cis b ais |
  % 8
  b e8 d cis4 ais |
  % 9
  s4 cis d a |
  % 10
  a b cis8 d e4 |
  % 11
  d2. ais4 |
  % 12
  b cis d d |
  % 13
  d cis fis d |
  % 14
  ais b b8 ais b4 |
  % 15
  b ais fis2. 
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
  g8 fis e4 fis fis, |
  % 4
  s4 fis' b, cis |
  % 5
  d g8 fis e4 fis |
  % 6
  b,2. b4 |
  % 7
  b' ais b fis |
  % 8
  g8 fis e4 fis fis, |
  % 9
  s4 fis' b, cis |
  % 10
  d g8 fis e4 fis |
  % 11
  b,2. fis'4 |
  % 12
  b a8 g fis e d4 |
  % 13
  g a d, d |
  % 14
  cis b e8 fis g4 |
  % 15
  fis8 e fis4 b,2. 
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
