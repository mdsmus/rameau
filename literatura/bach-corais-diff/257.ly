% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 257.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key bes \major
  
  \tempo 4 = 120 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 ais''4 ais2 a4 g a |
  % 3
  ais c2. |
  % 4
  ais2 ais4 ais2 c4 a g |
  % 6
  f ais2. |
  % 7
  a2 a4 ais2 ais4 c2 |
  % 9
  d4 c2. |
  % 10
  c2 d4 dis2 d4 c d8 c |
  % 12
  ais4. c8 c4. ais8 |
  % 13
  ais2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 f'4 g2 f4 dis f |
  % 3
  f g f2 |
  % 4
  f f4 f2 g4 f2 |
  % 6
  f4 f e8 d e4 |
  % 7
  f2 fis4 g2 g4 dis2 |
  % 9
  d4 e f8 e g f |
  % 10
  f2 a4 ais |
  % 11
  c f, g a |
  % 12
  d,8 dis f4 g f |
  % 13
  f2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 d'4 d2 d8 c ais4 c |
  % 3
  ais ais2 a4 |
  % 4
  d2 d4 d2 c4 c2 |
  % 6
  c4 d c ais |
  % 7
  c2 d4 d2 dis4 a2 |
  % 9
  ais4 ais a8 g ais a |
  % 10
  a2 d4 d |
  % 11
  c ais ais a |
  % 12
  ais ais2 a4 |
  % 13
  d2. 
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
  s2 ais'4 g2 d4 dis2 |
  % 3
  d4 dis f2 |
  % 4
  ais, ais'4 d,2 e4 f g |
  % 6
  a g2. |
  % 7
  f2 d4 g2 dis4 c2 |
  % 9
  ais4 c2. |
  % 10
  f2 fis4 g |
  % 11
  a ais e fis |
  % 12
  g d dis f |
  % 13
  ais,2. 
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2 d'4 d2 d4 g c, |
  % 3
  d c4. d8 dis4 |
  % 4
  d2 d4 d2 c4 c2 |
  % 6
  c4 d e8 f g4 |
  % 7
  c,2 d4 d2 dis4 dis c |
  % 9
  f c4*5 c'4 ais |
  % 11
  f ais g d |
  % 12
  g f c8 d dis4 |
  % 13
  d2. 
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
