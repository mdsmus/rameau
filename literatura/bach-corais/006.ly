% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f'4 |
  % 2
  a g a ais |
  % 3
  c2 a4 d |
  % 4
  c ais a g |
  % 5
  a2 s4 c |
  % 6
  d e f e |
  % 7
  d2 c4 a |
  % 8
  ais a g g |
  % 9
  f2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'4 |
  % 2
  f g f f |
  % 3
  e8 f g e f4 f |
  % 4
  f4. e8 f4. e8 |
  % 5
  f2 s4 a4. g4 c16 ais a4 a |
  % 7
  a g g f4. e8 f4 f e |
  % 9
  c2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  c c c d |
  % 3
  g, c c ais |
  % 4
  c d8 ais c4 c |
  % 5
  c2 s4 f |
  % 6
  f e4. d8 c2 b4 e c |
  % 8
  ais c cis c8. ais16 |
  % 9
  a2. 
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
  s2. f,4 |
  % 2
  f' e dis d |
  % 3
  c8 d e c f4 ais, |
  % 4
  a g f8 a c4 |
  % 5
  f,2 s4 a' |
  % 6
  b, c d8 f a g |
  % 7
  f d g4 c, f, |
  % 8
  g a ais c |
  % 9
  f,2. 
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
