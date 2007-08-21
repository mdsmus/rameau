% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 033300b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g8 a ais4 a8 g f4 |
  % 3
  ais a ais ais |
  % 4
  a g c ais |
  % 5
  a2 g4 g |
  % 6
  g8 a ais4 a8 g f4 |
  % 7
  ais a ais ais |
  % 8
  a g c ais |
  % 9
  a2 g4 d' |
  % 10
  ais c d c |
  % 11
  ais ais a ais |
  % 12
  ais a ais a |
  % 13
  g g fis ais |
  % 14
  a g c ais |
  % 15
  a2 g |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  dis f8 g f4 c |
  % 3
  f f f g4. fis8 g4. a4 g8 |
  % 5
  g fis16 e fis4 d d |
  % 6
  dis f8 g f4 c |
  % 7
  f f f g4. fis8 g4. a4 g8 |
  % 9
  g fis16 e fis4 d a'4. g4 f8 f4 f8. dis16 |
  % 11
  d8 e16 fis g4 fis g |
  % 12
  f4. dis8 d g4 fis8 |
  % 13
  g fis g g, d'4 g,8 g'4 fis8 g f dis4 d |
  % 15
  dis8 c a d16 c b2 |
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
  s2. ais'4 |
  % 2
  ais8 c d4 c8 ais a4 |
  % 3
  ais8 d c16 d dis4 d8 d4 |
  % 4
  dis8 d16 c ais8 b c dis d4 |
  % 5
  dis8 c a d16 c ais4 ais |
  % 6
  ais8 c d4 c8 ais a4 |
  % 7
  ais8 d c16 d dis4 d8 d4 |
  % 8
  dis8 d16 c ais8 b c dis d4 |
  % 9
  dis8 c a d16 c ais4 d |
  % 10
  d c4. ais4 a8 |
  % 11
  ais8. c16 d4 d d |
  % 12
  d c ais8 d dis d2 c8 a4 d |
  % 14
  d8. c16 ais8 a g a4 g fis16 e fis4 d2 |
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
  s2. g'8 f |
  % 2
  dis4 d8 dis f4. dis8 |
  % 3
  d ais f'4 ais, g |
  % 4
  c8 d dis d dis c g ais |
  % 5
  c a d4 g, g'8 f |
  % 6
  dis4 d8 dis f4. dis8 |
  % 7
  d ais f'4 ais, g |
  % 8
  c8 d dis d dis c g ais |
  % 9
  c a d4 g, fis' |
  % 10
  g a ais f |
  % 11
  g8. a16 ais8 g d4 g |
  % 12
  d8 dis f fis g ais, c d |
  % 13
  dis2 d4 g, |
  % 14
  d' dis4. fis,8 g ais |
  % 15
  c a d4 g,2 |
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
