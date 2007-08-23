% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 155.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''2 g4 d'2 d4 c2 |
  % 3
  ais4 a2 a4 |
  % 4
  d2 f4 dis2 d4 c2 |
  % 6
  c4 ais2. |
  % 7
  a2 ais4 c2 c4 ais2 |
  % 9
  c4 a2 a4 |
  % 10
  d2 d4 c2 ais4 a2 |
  % 12
  a4 g2. |
  % 13
  ais2 ais4 ais2 ais4 dis2 |
  % 15
  d4 c2 c4 |
  % 16
  c2 d4 ais2 c4 a2 |
  % 18
  a4 g2 g 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'2 d4 d8 e |
  % 2
  fis4 g a2 |
  % 3
  a8 g g4 fis8 e fis4 |
  % 4
  f2 c'4 ais |
  % 5
  c4. ais8 ais2 |
  % 6
  a4 f2. |
  % 7
  fis2 g |
  % 8
  fis8 g a2 g8 fis |
  % 9
  g2 fis8 e fis4 |
  % 10
  fis8 g a4 g2 |
  % 11
  fis4 g g2 |
  % 12
  fis4 d2. |
  % 13
  g2 g4 g2 ais4 ais a |
  % 15
  ais2 a8 g a4 |
  % 16
  a2 a4 g2 g4 g2 |
  % 18
  fis4 d2 d 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'2 ais4 a |
  % 2
  d8 c ais4 dis d |
  % 3
  d d2 d4 |
  % 4
  f2 f4 g |
  % 5
  f f g f4. dis8 d2. |
  % 7
  d2 d4 dis2 e8 d d2 |
  % 9
  dis4 d2 d4 |
  % 10
  a d8 c ais4 c |
  % 11
  d d dis8 d c dis |
  % 12
  d c ais2. |
  % 13
  d2 d4 dis2 f4 dis c |
  % 15
  f f2 f4 |
  % 16
  f2 fis4 d2 c8 d dis d c dis |
  % 18
  d c b2 b4 |
  % 19
  ais 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  g'8 a ais4 g fis8 e |
  % 2
  d4 g2 fis4 |
  % 3
  g d2 d4 |
  % 4
  ais ais' a g |
  % 5
  a ais dis, f |
  % 6
  f, ais2. |
  % 7
  d4 c ais a |
  % 8
  g fis g g' |
  % 9
  c, d2 d4 |
  % 10
  d8 e fis4 g a |
  % 11
  d, g c, a |
  % 12
  d g,2. |
  % 13
  g4 g' f dis, |
  % 14
  dis' d c, c' |
  % 15
  ais f2 f'4 |
  % 16
  f dis d g |
  % 17
  f dis8 d c4 a |
  % 18
  d g,2 g 
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
