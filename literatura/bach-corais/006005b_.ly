% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006005b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''2 b4 cis |
  % 2
  dis2 s4 dis |
  % 3
  e b b d |
  % 4
  cis2. b4 |
  % 5
  cis8 dis e4 e dis |
  % 6
  e2 a, |
  % 7
  b4 cis dis2 |
  % 8
  s4 dis e b |
  % 9
  b d cis2 |
  % 10
  s4 b cis8 dis e4 |
  % 11
  e dis e2 |
  % 12
  s4 b b b |
  % 13
  cis b d cis |
  % 14
  cis2 b |
  % 15
  s4 b b b |
  % 16
  cis b d cis |
  % 17
  cis2 b |
  % 18
  s4 e cis b |
  % 19
  a2 s4 e' |
  % 20
  cis b a2 |
  % 21
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'2 e4 d8 cis |
  % 2
  gis'2 s4 gis |
  % 3
  gis4. a8 gis fis gis e |
  % 4
  a2. gis4 |
  % 5
  a8 b cis4 b a16 gis a8 |
  % 6
  gis2 e |
  % 7
  e4 e fis2 |
  % 8
  s4 fis8 gis16 a gis8 fis gis a |
  % 9
  b4 gis a2 |
  % 10
  s4 fis g8 a b4 |
  % 11
  b8 a16 gis a8 fis gis2 |
  % 12
  s4 gis8 a b a b gis |
  % 13
  a4 b a a |
  % 14
  a8 gis a fis gis2 |
  % 15
  s4 fis b, b' |
  % 16
  ais a gis a |
  % 17
  a8 fis dis4 e2 |
  % 18
  s4 e e fis8 gis |
  % 19
  fis2 s4 b |
  % 20
  a gis e2 |
  % 21
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  cis'2 b4 fis' |
  % 2
  fis2 s4 c |
  % 3
  cis8 dis e4 e e |
  % 4
  e2. e4 |
  % 5
  e8 fis g4 fis b, |
  % 6
  b2 cis |
  % 7
  b4 a a2 |
  % 8
  s4 b b e |
  % 9
  e e e2 |
  % 10
  s4 dis e8 fis g4 |
  % 11
  fis b, b2 |
  % 12
  s4 e e e |
  % 13
  e e fis e |
  % 14
  e dis e2 |
  % 15
  s4 dis e f |
  % 16
  e d e fis |
  % 17
  e8 a, fis4 gis2 |
  % 18
  s4 b a a8 gis |
  % 19
  cis2 s4 e |
  % 20
  e d16 cis d8 cis2 |
  % 21
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  a'2 gis4 ais |
  % 2
  c2 s4 gis |
  % 3
  cis8 b16 a gis8 fis e d cis b |
  % 4
  a2. e'4 |
  % 5
  a ais b b, |
  % 6
  e2 a |
  % 7
  gis4 g fis2 |
  % 8
  s4 b, e4. fis8 |
  % 9
  gis4 fis8 e a2 |
  % 10
  s4 a g8 fis e4 |
  % 11
  b' b, e2 |
  % 12
  s4 e8 fis gis fis gis e |
  % 13
  a b a gis fis gis a a, |
  % 14
  e'2 e |
  % 15
  s4 a gis g |
  % 16
  fis f e dis |
  % 17
  e2 e |
  % 18
  s4 gis a8 cis, dis f |
  % 19
  fis2 s4 gis |
  % 20
  a e a,2 |
  % 21
  
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
