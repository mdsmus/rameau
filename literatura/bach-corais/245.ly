% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 245.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  ais g f g8 a |
  % 3
  ais4 a g ais |
  % 4
  ais ais ais f |
  % 5
  g ais a a |
  % 6
  c c c8 ais16 a g8 a |
  % 7
  ais4 a g a |
  % 8
  ais g f g8 a |
  % 9
  ais4 a g2 |
  % 10
  
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
  d d d d8 fis |
  % 3
  g4. fis8 d4 g |
  % 4
  g g f8 dis4 d16 c |
  % 5
  d8 e16 f g4 f f |
  % 6
  f e8 fis g fis g d |
  % 7
  d g4 fis8 d4 fis |
  % 8
  g d d d8 fis |
  % 9
  g4. fis8 d2 |
  % 10
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'8 c |
  % 2
  ais4 ais a ais8 c |
  % 3
  d4 dis8 d16 c ais4 d |
  % 4
  d d d8 g, a ais4 a8 g c c4 c8 ais |
  % 6
  a g a4 g8 c ais a |
  % 7
  g d' dis d16 c ais4 d |
  % 8
  d ais a ais8 c |
  % 9
  d4 dis8 d16 c b2 |
  % 10
  
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
  s2. ais8 a |
  % 2
  g a ais c d c ais a |
  % 3
  g ais c d g,4 g' |
  % 4
  g,8 a ais c d dis f4 |
  % 5
  f e f f,8 g |
  % 6
  a ais c d dis4. fis,8 |
  % 7
  g ais c d g,4 d' |
  % 8
  g,8 a ais c d c ais a |
  % 9
  g ais c d g,2 |
  % 10
  
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
