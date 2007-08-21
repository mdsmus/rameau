% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024446b_.mid
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
  b b ais fis |
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
  cis b a8 g fis g |
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
  s2. a''4 |
  % 2
  g gis fis cis |
  % 3
  b fis' fis b |
  % 4
  cis b ais fis |
  % 5
  fis a a b8 a |
  % 6
  g a b4 b b |
  % 7
  e,8 fis g4 fis b |
  % 8
  e, d e d8 e |
  % 9
  fis4 fis g fis |
  % 10
  fis8 dis e4 dis b' |
  % 11
  b8 ais b4. gis8 ais4 |
  % 12
  fis1 |
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
  s2. fis'4 |
  % 2
  e d cis ais |
  % 3
  e' e d8 e fis4 |
  % 4
  g fis fis ais, |
  % 5
  b cis d8 cis b4 |
  % 6
  b e d8 cis d4 |
  % 7
  d cis a fis |
  % 8
  gis8 ais b4 e, a |
  % 9
  d d d8 e fis4 |
  % 10
  b,2 b4 d |
  % 11
  cis fis, fis'4. e8 |
  % 12
  dis1 |
  % 13
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. dis4 |
  % 2
  e f fis fis |
  % 3
  gis ais b b |
  % 4
  ais b fis fis |
  % 5
  b a d, g8 fis |
  % 6
  e fis g a b4 a8 gis |
  % 7
  a2 d,4 d |
  % 8
  e8 fis g4 cis, d |
  % 9
  d'8 c b a g fis e dis |
  % 10
  e2 b4 b |
  % 11
  cis d8 e fis2 |
  % 12
  b,1 |
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
