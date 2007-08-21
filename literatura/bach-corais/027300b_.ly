% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 027300b_.mid
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
  g ais a g |
  % 3
  ais c d d |
  % 4
  d d8 dis f dis d4 |
  % 5
  c c ais ais |
  % 6
  ais d c a |
  % 7
  ais c d d |
  % 8
  d d c c |
  % 9
  ais4. a16 g f4 f |
  % 10
  ais8 c d4 c d |
  % 11
  ais a g2 |
  % 12
  
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
  d8 e f g f dis d4 |
  % 3
  g8 f dis f f4 f |
  % 4
  f g a ais4. a16 g a4 f g |
  % 6
  g8 a ais4 ais8 a16 g f4 |
  % 7
  f f f f |
  % 8
  f f f8. dis16 d2 e4 d d |
  % 10
  g8 a ais4 ais a4. g4 fis8 d2 |
  % 12
  
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
  ais d8 c c4 ais8 a |
  % 3
  g16 a ais4 a8 ais4 ais8 c |
  % 4
  d c ais4 c ais8 d |
  % 5
  g4 f8 dis d4 d |
  % 6
  dis f f c |
  % 7
  ais4. a8 ais4 ais |
  % 8
  ais ais4. a8 a4. g8 g a16 ais a4 ais8 c |
  % 10
  d c ais a g4 d' |
  % 11
  d8 dis a d ais2 |
  % 12
  
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
  g' d8 e f fis g f |
  % 3
  dis d c f ais,4 ais |
  % 4
  ais'8 a g4 f g8 f |
  % 5
  dis4 f ais, g'8 f |
  % 6
  dis d c ais f'4. dis8 |
  % 7
  d ais f'4 ais, ais |
  % 8
  ais8 c d dis f4 fis8 d |
  % 9
  g4 cis, d ais8 a |
  % 10
  g4 g'8 f e4 fis |
  % 11
  g8 c, d4 g,2 |
  % 12
  
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
