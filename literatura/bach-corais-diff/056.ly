% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 056.mid
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
  s2. e'8 fis |
  % 2
  g4 g a b2 e,4 a g |
  % 4
  fis2. a4 |
  % 5
  b8 cis d2 cis4 |
  % 6
  b a b8 cis d4 |
  % 7
  d2. a4 |
  % 8
  b8 cis d2 cis4 |
  % 9
  b a b8 cis d2 a8 g fis g a4 |
  % 11
  b2. e,8 fis |
  % 12
  g4 g8 a b c d2 b4 a8 g fis g |
  % 14
  a4 g fis2*7 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b'4 |
  % 2
  e e e fis2 e4 dis e |
  % 4
  dis2. d4 |
  % 5
  g fis8 g a4 e8 fis |
  % 6
  g4 fis8 e d4 g |
  % 7
  fis2. fis8 e |
  % 8
  d e fis2 fis8 e |
  % 9
  d e fis4 g d8 e |
  % 10
  fis2. e4 |
  % 11
  fis2. e8 dis |
  % 12
  e fis g4 fis8 e d c |
  % 13
  b c d e fis4. e8 |
  % 14
  dis4 e2 d8 cis |
  % 15
  d e fis2 gis8 ais |
  % 16
  b4*5 ais8 gis ais2 |
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
  s2. g'8 a |
  % 2
  b4 b a2 |
  % 3
  g8 a b4 a b |
  % 4
  b2. a4 |
  % 5
  e' a,4. b8 cis d |
  % 6
  e d cis4 b b |
  % 7
  a2. d8 e |
  % 8
  fis4 b,2 a4 |
  % 9
  b8 cis d4 g,8 a b4. cis8 d4 cis8 dis e4 |
  % 11
  dis2. b4 |
  % 12
  b b8 c d e fis4 |
  % 13
  g g, d'8 e fis2 e8 d cis4 fis, |
  % 15
  b8 fis b4. ais8 b cis |
  % 16
  d4*5 cis8 b cis2 |
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
  s2. e4 |
  % 2
  e e8 d cis4 dis |
  % 3
  e8 fis g4 fis e |
  % 4
  b2. fis'4 |
  % 5
  e d8 e fis g a4 |
  % 6
  e fis g8 a b cis |
  % 7
  d2. d,8 cis |
  % 8
  b4. cis8 d e fis4 |
  % 9
  g fis e b8 cis |
  % 10
  d e fis g a b c4 |
  % 11
  b2. g8 fis |
  % 12
  e4 e d8 c b a |
  % 13
  g a b c d4. c8 |
  % 14
  b4 c8 b ais2 |
  % 15
  b8 cis d e fis4. e8 |
  % 16
  d cis b ais b d cis b |
  % 17
  fis'1 |
  % 18
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. e,4 |
  % 2
  e' e8 d cis4 dis |
  % 3
  e8 fis g4 fis e |
  % 4
  b2. fis4 |
  % 5
  e d8 e fis g a4 |
  % 6
  e fis g8 a b cis |
  % 7
  d2. d8 cis |
  % 8
  b4. cis8 d e fis4 |
  % 9
  g fis e b8 cis |
  % 10
  d e fis g a b c4 |
  % 11
  b2. g8 fis |
  % 12
  e4 e d8 c b a |
  % 13
  g a b c d4. c8 |
  % 14
  b4 c8 b ais2 |
  % 15
  b8 cis d e fis4. e8 |
  % 16
  d cis b ais b d cis b |
  % 17
  fis'2 fis, |
  % 18
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
