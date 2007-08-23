% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 301.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. ais''4 |
  % 2
  ais g8 a ais c d4 |
  % 3
  c c ais ais |
  % 4
  a g8 a ais4 c8 ais |
  % 5
  a2 g4 ais |
  % 6
  ais g8 a ais c d4 |
  % 7
  c c ais ais |
  % 8
  a g8 a ais4 c8 ais |
  % 9
  a2 g4 c |
  % 10
  d d a8 ais c4 |
  % 11
  ais ais a ais |
  % 12
  c g8 a ais4 a |
  % 13
  g g f ais |
  % 14
  a g8 a ais4 c8 ais |
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
  s2. g''4 |
  % 2
  f dis d d |
  % 3
  dis dis16 d dis8 d4 d |
  % 4
  d8 c' ais a g4 g8 f |
  % 5
  dis4 d8 c ais4 g' |
  % 6
  f dis d d |
  % 7
  dis dis16 d dis8 d4 d |
  % 8
  d8 c' ais a g4 g8 f |
  % 9
  dis4 d8 c ais4 f' |
  % 10
  f f c4. a'8 |
  % 11
  a g16 fis g4 f g |
  % 12
  g8 f dis4 d8 e f4 |
  % 13
  f e c d |
  % 14
  c8 d e fis g4 g |
  % 15
  g fis d2 |
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
  s2. d'4 |
  % 2
  d8 c ais4 ais f |
  % 3
  g a f g |
  % 4
  fis8 dis' d c ais a g4 |
  % 5
  g fis g d' |
  % 6
  d8 c ais4 ais f |
  % 7
  g a f g |
  % 8
  fis8 dis' d c ais a g4 |
  % 9
  g fis g f |
  % 10
  ais ais f' fis8 a, |
  % 11
  ais c d4 d d |
  % 12
  g, c ais c |
  % 13
  c8 g c ais a4 f8 g |
  % 14
  a ais c4 d c8 d |
  % 15
  dis a d c b2 |
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
  s2. g'4 |
  % 2
  d dis8 f g a ais4 |
  % 3
  dis, f ais, g |
  % 4
  d' e8 fis g f dis d |
  % 5
  c4 d g, g' |
  % 6
  d dis8 f g a ais4 |
  % 7
  dis, f ais, g |
  % 8
  d' e8 fis g f dis d |
  % 9
  c4 d g, a |
  % 10
  ais8 c d dis f g a fis |
  % 11
  g a ais c d4 g,8 f |
  % 12
  dis d c4 g a8 ais |
  % 13
  c ais c4 f, d'8 e |
  % 14
  f4 c g'8 f dis d |
  % 15
  c4 d g,2 |
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
