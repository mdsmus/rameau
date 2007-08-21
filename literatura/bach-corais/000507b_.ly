% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000507b_.mid
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
  a2. a4 |
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
  d c ais c |
  % 13
  a2 g4 
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
  dis e8 fis g4 g |
  % 3
  fis2. fis4 |
  % 4
  g g8 fis g4 a |
  % 5
  fis2. fis4 |
  % 6
  g a ais ais |
  % 7
  ais a8 g a4 fis |
  % 8
  d c f g |
  % 9
  g f8 dis d4 f |
  % 10
  f f8 g a4 g |
  % 11
  g8 f g e f4 f8 dis |
  % 12
  d4 e8 fis g4 g |
  % 13
  g fis d 
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
  c c d dis |
  % 3
  a2. a4 |
  % 4
  ais c d dis |
  % 5
  d2. d4 |
  % 6
  d dis f f |
  % 7
  g f8 dis d4 a |
  % 8
  ais f'8 dis d c ais4 |
  % 9
  ais a f ais |
  % 10
  c d d8 c ais4 |
  % 11
  ais8 a ais g a4 a |
  % 12
  ais a g8 ais dis4 |
  % 13
  d8 c16 ais c4 b 
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
  c8 ais a4 g8 f dis4 |
  % 3
  d2. c4 |
  % 4
  ais a g c |
  % 5
  d2. d4 |
  % 6
  g f8 dis d c ais4 |
  % 7
  dis f fis d |
  % 8
  g a ais8 a g f |
  % 9
  dis4 f ais, ais' |
  % 10
  a ais fis g8 f |
  % 11
  e4 c f f |
  % 12
  ais, c8 d dis4 d8 c |
  % 13
  d2 g,4 
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
