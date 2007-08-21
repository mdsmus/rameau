% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 005708b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  ais''4 ais f' d4. c8 ais4 a ais8 a |
  % 3
  g f ais4 c d8 dis |
  % 4
  c2 ais4 ais |
  % 5
  ais f' d4. c8 |
  % 6
  ais4 a ais8 a g f |
  % 7
  ais4 c d8 dis c2 ais4 f' dis8 d |
  % 9
  c ais g'8*5 s8 |
  % 10
  d4 dis f f |
  % 11
  g8 f dis d c8*5 s8 f,4 g a |
  % 13
  ais c d8 dis c2 ais8*5 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 f f f4. f8 g4 c, c |
  % 3
  c f g8 a ais c |
  % 4
  a2 f4 f |
  % 5
  f f f4. f8 |
  % 6
  g4 c, c c |
  % 7
  f g8 a ais c a2 f4 ais a |
  % 9
  f ais8*5 s8 |
  % 10
  ais4 ais a8 g f4 |
  % 11
  ais g a8*5 s8 f4 c c |
  % 13
  ais f' f f4. dis8 d8*5 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  d'4 d c ais4. c8 d e f4 f |
  % 3
  a, ais dis, f |
  % 4
  f' dis d d |
  % 5
  d c ais4. c8 |
  % 6
  d e f4 f a, |
  % 7
  ais dis, f f' |
  % 8
  dis d d dis |
  % 9
  f dis8*5 s8 |
  % 10
  f4 g c, c |
  % 11
  ais ais f'8*5 s8 ais,4 a8 g dis'4 |
  % 13
  d c ais ais |
  % 14
  a f8*5 
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
  ais'4 ais a ais4. a8 g4 f c |
  % 3
  dis d c ais |
  % 4
  f'2 ais,4 ais' |
  % 5
  ais a ais4. a8 |
  % 6
  g4 f c dis |
  % 7
  d c ais f'2 ais,4 ais c |
  % 9
  d dis8*5 s8 |
  % 10
  ais'4 a8 g f dis d4 |
  % 11
  d dis f8*5 s8 d4 e fis |
  % 13
  g a ais f2 ais,8*5 
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
