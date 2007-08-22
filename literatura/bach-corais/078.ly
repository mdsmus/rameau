% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 078.mid
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
  s2. b''4 |
  % 2
  b b ais8 gis fis4 |
  % 3
  b cis d d |
  % 4
  e d cis cis |
  % 5
  d e fis8 e d4 |
  % 6
  g g fis8 e fis4 |
  % 7
  e2 d4 d |
  % 8
  cis b a fis8 g |
  % 9
  a4 a b a |
  % 10
  g2 fis4 fis' |
  % 11
  e d cis2 |
  % 12
  b1 |
  % 13
  
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
  g d8 e fis4 cis |
  % 3
  fis fis fis fis |
  % 4
  fis2 fis4 fis |
  % 5
  fis a a b8 a |
  % 6
  g4 a a d8 cis |
  % 7
  b4 a8 g fis4 fis |
  % 8
  e d e d8 e |
  % 9
  fis4 fis g fis |
  % 10
  fis8 dis e4 e d |
  % 11
  g fis fis4. e8 |
  % 12
  dis1 |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  e b cis8 b ais4 |
  % 3
  b ais b8 cis d4 |
  % 4
  cis b ais ais |
  % 5
  b cis d8 cis b cis |
  % 6
  d4 e e d |
  % 7
  d cis a b8 a |
  % 8
  g4 g8 fis e a a4 |
  % 9
  d d d c |
  % 10
  b4. ais16 b cis4 b |
  % 11
  b8 ais b4 b ais |
  % 12
  fis1 |
  % 13
  
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
  e,8 fis g4 fis fis8 e |
  % 3
  d4 fis b, b' |
  % 4
  ais b fis fis |
  % 5
  b a d, g8 a |
  % 6
  b4 cis d8 cis b a |
  % 7
  g4 a d, b |
  % 8
  e8 fis g4 cis, d |
  % 9
  d'8 c b a g fis e dis |
  % 10
  e2 ais,4 b |
  % 11
  cis d8 e fis4 fis, |
  % 12
  b1 |
  % 13
  
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
