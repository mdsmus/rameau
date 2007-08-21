% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000606b_.mid
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
  s2. g''8 a |
  % 2
  ais4 a8 g fis4 g8 a |
  % 3
  ais4 a g ais |
  % 4
  c c d ais |
  % 5
  c c d d |
  % 6
  dis d8 dis f dis d4 |
  % 7
  c8 ais c4 ais d |
  % 8
  ais c ais a |
  % 9
  g fis g 
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
  g8 f dis4 d d8 fis |
  % 3
  g4 fis d g |
  % 4
  f8 g a4 ais d, |
  % 5
  g8 ais a g fis4 g |
  % 6
  g8 a ais4 c ais |
  % 7
  a8 ais4 a8 f4 a |
  % 8
  g g8 fis g4 fis |
  % 9
  g8 dis d4 d 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'8 c |
  % 2
  d4 c8 ais a4 ais8 c |
  % 3
  d dis a d ais4 d |
  % 4
  c f f g |
  % 5
  g c,8 d16 dis a4 ais |
  % 6
  c f, f f' |
  % 7
  dis8 d dis c d4 d |
  % 8
  d c d d8 c |
  % 9
  ais4 a8 b16 c b4 
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
  g' c, d8 c' ais a |
  % 3
  g c, d4 g, g' |
  % 4
  a f ais8 a g f |
  % 5
  dis d dis4 d g |
  % 6
  c, ais a ais |
  % 7
  f' f ais, fis' |
  % 8
  g8 g, a4 ais8 c d4 |
  % 9
  dis8 c d4 g, 
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
