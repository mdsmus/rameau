% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 016806b_.mid
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
  b ais b cis |
  % 3
  d cis b b |
  % 4
  cis cis fis e |
  % 5
  d2 cis4 b |
  % 6
  b ais b cis |
  % 7
  d cis b b |
  % 8
  cis cis fis e |
  % 9
  d2 cis4 fis |
  % 10
  e d cis e |
  % 11
  d cis b d |
  % 12
  cis b a8 gis fis gis |
  % 13
  a4 b cis cis |
  % 14
  d e fis4. e8 |
  % 15
  d4 e8 d cis2 |
  % 16
  b1 |
  % 17
  
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
  e8 fis g4 fis g |
  % 3
  fis fis8 e d4 e |
  % 4
  e8 fis g4 fis cis' |
  % 5
  cis8 ais b4 ais fis |
  % 6
  e8 fis g4 fis g |
  % 7
  fis fis8 e d4 e |
  % 8
  e8 fis g4 fis cis' |
  % 9
  cis8 ais b4 ais a |
  % 10
  a8 gis a b a4 g8 fis |
  % 11
  fis4 fis fis fis8 gis |
  % 12
  a4 gis fis cis |
  % 13
  fis gis a a8 g |
  % 14
  fis b a g fis2. e8 fis g4 fis8 e |
  % 16
  dis1 |
  % 17
  
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
  cis8 d e4 d8 cis b ais |
  % 3
  b cis ais4 b gis |
  % 4
  a e' d8 e fis4 |
  % 5
  fis4. f8 fis4 d |
  % 6
  cis8 d e4 d8 cis b ais |
  % 7
  b cis ais4 b gis |
  % 8
  a e' d8 e fis4 |
  % 9
  fis4. f8 fis4 fis |
  % 10
  b, fis'8 e e d cis4 |
  % 11
  cis8 b b ais d4 b |
  % 12
  e d8 cis cis b a gis |
  % 13
  fis a d4 e e |
  % 14
  d8 g fis e d4 cis4. fis,8 b2 ais4 |
  % 16
  fis1 |
  % 17
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. b'4 |
  % 2
  cis cis, d e |
  % 3
  fis8 e fis4 b, e |
  % 4
  a, a' d8 cis b ais |
  % 5
  b4 b, fis' b |
  % 6
  cis cis, d e |
  % 7
  fis8 e fis4 b, e |
  % 8
  a, a' d8 cis b ais |
  % 9
  b4 b, fis' d |
  % 10
  e fis8 gis a4 ais |
  % 11
  b fis b, b' |
  % 12
  a8 gis fis f fis4. e8 |
  % 13
  d cis b4 a a' |
  % 14
  b cis d8 cis b ais |
  % 15
  b a g fis e4 fis |
  % 16
  b,1 |
  % 17
  
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
