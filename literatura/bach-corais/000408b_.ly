% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000408b_.mid
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
  d cis b b |
  % 4
  g a b a8 g |
  % 5
  fis e fis4 e b' |
  % 6
  ais b8 cis d4 e |
  % 7
  d cis b b |
  % 8
  g a b a8 g |
  % 9
  fis e fis4 e s4 |
  % 10
  e8 fis g4 a e8 fis |
  % 11
  g4 a b b |
  % 12
  e dis e fis8 e |
  % 13
  d4 cis b cis |
  % 14
  d b8 cis d4 a |
  % 15
  g fis e2 |
  % 16
  b'4 a g2 |
  % 17
  fis e |
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
  fis fis fis fis |
  % 3
  fis fis8 e dis4 fis |
  % 4
  e d d8 dis e4 |
  % 5
  e dis b g' |
  % 6
  fis fis fis fis |
  % 7
  fis fis8 e dis4 fis |
  % 8
  e d d8 dis e4 |
  % 9
  e dis b s4 |
  % 10
  b e e4. dis8 |
  % 11
  e4 d d g8 a |
  % 12
  b4 a b fis |
  % 13
  fis fis8 e d4 e |
  % 14
  fis d g fis |
  % 15
  fis8 e e dis e2 |
  % 16
  d8 e fis4. dis8 e2 dis4 b2 |
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
  cis4 d8 ais b4 cis |
  % 3
  b ais fis b |
  % 4
  b8 c b a g a b4 |
  % 5
  c fis,8 a g4 e'8 d |
  % 6
  cis4 d8 ais b4 cis |
  % 7
  b ais fis b |
  % 8
  b8 c b a g a b4 |
  % 9
  c fis,8 a g4 s4 |
  % 10
  g8 a b4 a8 b c4 |
  % 11
  b a g d' |
  % 12
  g fis e8 d cis4 |
  % 13
  b ais fis g |
  % 14
  a g g d'8 c |
  % 15
  b4 a g2 |
  % 16
  g4 fis8 b b4 c2 b8 a gis2 |
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
  fis8 e d cis b4 ais |
  % 3
  b fis b dis |
  % 4
  e fis g8 fis e4 |
  % 5
  a,8 b16 c b4 e, e' |
  % 6
  fis8 e d cis b4 ais |
  % 7
  b fis b dis |
  % 8
  e fis g8 fis e4 |
  % 9
  a,8 b16 c b4 e, s4 |
  % 10
  e'4. d8 c b a4 |
  % 11
  e' fis g g8 fis |
  % 12
  e4 fis gis ais |
  % 13
  b fis b, e |
  % 14
  d g b,8 c d4 |
  % 15
  e b c2 |
  % 16
  g'4 dis e c |
  % 17
  a b e,2 |
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
