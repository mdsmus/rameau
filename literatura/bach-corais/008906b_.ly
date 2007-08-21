% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 008906b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g a ais c |
  % 3
  d2. d4 |
  % 4
  d c ais c |
  % 5
  ais2. ais4 |
  % 6
  ais c d d |
  % 7
  c2 d4 d |
  % 8
  ais c d d |
  % 9
  c2 ais4 d |
  % 10
  f d d d |
  % 11
  c2 c4 c |
  % 12
  d c ais c8 ais |
  % 13
  a2 g1 
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
  d d d g |
  % 3
  fis2. fis4 |
  % 4
  g g8 fis g4 a |
  % 5
  f2. f4 |
  % 6
  g a ais ais |
  % 7
  ais a ais a |
  % 8
  g a8 g f4 f |
  % 9
  g f f ais |
  % 10
  c ais a g |
  % 11
  g f8 e f4 g |
  % 12
  fis fis g g |
  % 13
  g fis d1 
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
  ais a g8 ais dis4 |
  % 3
  a2. a4 |
  % 4
  ais c d dis |
  % 5
  d2. d4 |
  % 6
  d f f g |
  % 7
  g f f d |
  % 8
  d f ais, ais |
  % 9
  ais a d f |
  % 10
  f f8 g a a, ais4 |
  % 11
  ais a8 g a4 g |
  % 12
  a d d c8 d |
  % 13
  dis4 d8 c b1 
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
  s2. g4 |
  % 2
  g' fis g dis |
  % 3
  d2. c4 |
  % 4
  ais a g c |
  % 5
  d2. d4 |
  % 6
  g f ais8 a g f |
  % 7
  dis4 f ais, fis |
  % 8
  g8 g' f dis d c ais d |
  % 9
  dis c f4 ais, ais' |
  % 10
  a ais fis g |
  % 11
  e c f dis |
  % 12
  d8 c ais a g f' dis d |
  % 13
  c4 d g,1 
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
