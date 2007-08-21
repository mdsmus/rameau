% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024842bs.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key f \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 a2 g f4 ais c4. d16 dis d2. |
  % 4
  c d4 |
  % 5
  ais2 c |
  % 6
  f,4 ais a2 |
  % 7
  g2. c4 |
  % 8
  a2 g |
  % 9
  f4 ais c4. d16 dis |
  % 10
  d2. c d4 ais2 c f,4 |
  % 13
  ais a2 g2. e'4 c2 a d4 |
  % 16
  cis d4. e16 f e2. a, d4 e f |
  % 19
  g c, ais a |
  % 20
  d ais g2. f |
  % 22
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''4 f2 f4 |
  % 2
  e f d g |
  % 3
  f f2. |
  % 4
  f a4 |
  % 5
  g2 g4 f |
  % 6
  f f8 g g4 f |
  % 7
  e2. a4 |
  % 8
  f2 f4 e |
  % 9
  f d g f |
  % 10
  f2. f a4 g2 g4 f f |
  % 13
  f8 g g4 f e2. g8 f g4 |
  % 15
  g g f f |
  % 16
  g a ais8 a g f |
  % 17
  g4. e8 f2. f4 g a |
  % 19
  g8 f g4 e c |
  % 20
  ais f' f e8 d |
  % 21
  e4 c2. |
  % 22
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  f'4 c2 c4. ais8 a4 ais2 |
  % 3
  a8 ais16 c c4 ais8 a ais4 |
  % 4
  a2. f'4 |
  % 5
  d2 c8 ais a4 |
  % 6
  a d8 c c2 |
  % 7
  c2. f4 |
  % 8
  c2 c4. ais8 |
  % 9
  a4 ais2 a8 ais16 c |
  % 10
  c4 ais8 a ais4 a2. f'4 d2 c8 ais a4 a |
  % 13
  d8 c c2 c2. c2 |
  % 15
  e4 c2 ais a4 d8 c ais4 |
  % 17
  a8 g a4 a2. ais4. g8 c4 |
  % 19
  c2 g4 f2 d'4 g, c |
  % 21
  ais a2. |
  % 22
  
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
  f8 g a4 f c2 d4 g8 f dis4 |
  % 3
  f ais,8 c d4 ais |
  % 4
  f'2. d4 |
  % 5
  g f e f8 e |
  % 6
  d c d e f4 f |
  % 7
  c2. f8 g |
  % 8
  a4 f c2 |
  % 9
  d4 g8 f dis4 f |
  % 10
  ais,8 c d4 ais f'2. d4 g |
  % 12
  f e f8 e d c |
  % 13
  d e f4 f c2. c8 d e4 |
  % 15
  c f8 e f4 ais |
  % 16
  e f d d |
  % 17
  cis8 b cis4 d2. ais'8 a g4 f |
  % 19
  e8 d e4 c f |
  % 20
  ais,2 c8 ais c2 f,2. |
  % 22
  
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
