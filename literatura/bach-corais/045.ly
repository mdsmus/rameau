% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 045.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b b fis' e |
  % 3
  fis8 e d4 cis b8 cis |
  % 4
  d4 cis d8 e fis4 |
  % 5
  e d cis d8 cis |
  % 6
  b4 b e4. d8 |
  % 7
  cis d16 e d8 cis b2 |
  % 8
  a4 a d cis |
  % 9
  d8 e fis4 e d |
  % 10
  cis b8 cis d4 cis |
  % 11
  d8 e fis4 e d |
  % 12
  cis fis fis fis |
  % 13
  e4. d8 cis4 d8 e |
  % 14
  cis2 b |
  % 15
  
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
  g g fis8 gis ais b |
  % 3
  cis4 b ais b8 ais |
  % 4
  b4 fis fis fis |
  % 5
  b8 cis fis, gis ais4 b |
  % 6
  fis e8 fis gis2 |
  % 7
  a4 a a gis |
  % 8
  e fis b cis8 ais |
  % 9
  b4 b b8 cis fis,4 |
  % 10
  fis fis e e |
  % 11
  fis8 g a4 g fis |
  % 12
  fis fis8 e d fis b a |
  % 13
  g fis e2 d8 g |
  % 14
  g4 fis8 e dis2 |
  % 15
  
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
  e e d g |
  % 3
  fis fis fis fis8 e |
  % 4
  fis4 fis8 e d cis b d |
  % 5
  d cis d b cis4 fis8 e |
  % 6
  d cis b4 b cis8 d |
  % 7
  e4 a, fis' e8 d |
  % 8
  cis4 d8 e fis4 fis |
  % 9
  fis8 e d4 d8 cis cis b |
  % 10
  ais4 d8 cis b gis a4 |
  % 11
  a d d8 cis cis b |
  % 12
  ais4 cis cis b |
  % 13
  b2 a8 g' fis b, |
  % 14
  b4 ais fis2 |
  % 15
  
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
  e8 fis g a b d cis b |
  % 3
  ais fis b b, fis'4 d8 cis |
  % 4
  b b' ais fis b cis d b |
  % 5
  gis ais b b, fis'4 b, |
  % 6
  b'8 a gis fis e d cis b |
  % 7
  a cis fis e d b e e, |
  % 8
  a4 d8 cis b b' ais fis |
  % 9
  b cis d b gis ais b b, |
  % 10
  fis'4 b8 a gis e a g |
  % 11
  fis e d cis b ais b4 |
  % 12
  fis ais b8 cis d dis |
  % 13
  e fis g gis a ais b g |
  % 14
  e cis fis fis, b2 |
  % 15
  
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
