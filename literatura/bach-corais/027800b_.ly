% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 027800b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  ais b8 cis d4 e |
  % 3
  d cis b b8 a |
  % 4
  g4 a b8 a g4 |
  % 5
  fis8 e fis4 e b' |
  % 6
  ais b8 cis d4 e |
  % 7
  d cis b b8 a |
  % 8
  g4 a b8 a g4 |
  % 9
  fis8 e fis4 e s4 |
  % 10
  e8 fis g4 a e8 fis |
  % 11
  g4 a b b |
  % 12
  e d e fis8 e |
  % 13
  d4 cis b cis |
  % 14
  d8 c b c d4 a |
  % 15
  g fis e2 |
  % 16
  b'4 a g fis |
  % 17
  e1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  fis4. ais8 b ais16 b cis4. b4 ais8 fis4 fis |
  % 4
  fis8 e4 dis16 cis b8 dis e4 |
  % 5
  e8 dis16 cis dis4 b g' |
  % 6
  fis4. ais8 b ais16 b cis4. b4 ais8 fis4 fis |
  % 8
  fis8 e4 dis16 cis b8 dis e4 |
  % 9
  e8 dis16 cis dis4 b s4 |
  % 10
  b e e4. b8 |
  % 11
  b c16 d e4 dis fis |
  % 12
  b a b8 gis cis4 |
  % 13
  c8 b4 ais8 fis4 g |
  % 14
  fis d d2 |
  % 15
  e4. d8 cis2 |
  % 16
  dis8 e e fis b, e4 dis8 |
  % 17
  b1 |
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
  s2. e'8 d |
  % 2
  cis4 d8 e fis g4 fis8 |
  % 3
  fis b, cis16 d e8 e dis b4 |
  % 4
  b8 c4 b16 a b4 b |
  % 5
  b4. a8 g4 e'8 d |
  % 6
  cis4 d8 e fis g4 fis8 |
  % 7
  fis b, cis16 d e8 e dis b4 |
  % 8
  b8 c4 b16 a b4 b |
  % 9
  b4. a8 g4 s4 |
  % 10
  g8 a b4 e, a |
  % 11
  g8 a16 b c4 fis, dis' |
  % 12
  e8 fis16 g a8 fis b, e cis b16 ais |
  % 13
  b8 d g fis d4 e |
  % 14
  a, b8 a g4. fis8 |
  % 15
  b4 a a2 |
  % 16
  b4 cis8 dis e g, c b16 a |
  % 17
  gis1 |
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
  e d8 cis b b'4 ais8 |
  % 3
  b g e fis b,4 dis |
  % 4
  e fis g8 fis g a |
  % 5
  b4 b, e e |
  % 6
  e d8 cis b b'4 ais8 |
  % 7
  b g e fis b,4 dis |
  % 8
  e fis g8 fis g a |
  % 9
  b4 b, e s4 |
  % 10
  e4. d8 c b cis dis |
  % 11
  e d c4 b b'8 a |
  % 12
  g fis16 e fis8 a gis cis ais fis |
  % 13
  b g e fis b,4 e |
  % 14
  d g,8 a b c d4. cis8 d fis a2 |
  % 16
  a8 g4 fis8 e c a b |
  % 17
  e1 |
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
