% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 130.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  \skip 1*8 
  \time 2/4 
  \skip 2 |
  % 10
  
  \time 4/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  b''2 d |
  % 2
  b4 b b b |
  % 3
  c2 b |
  % 4
  a a |
  % 5
  g1 |
  % 6
  b2 d |
  % 7
  a4 a a a |
  % 8
  a a a a |
  % 9
  e2 g |
  % 10
  fis e1 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'2 d |
  % 2
  d4 dis e fis |
  % 3
  e d2 d4 |
  % 4
  e2 d |
  % 5
  d1 |
  % 6
  d |
  % 7
  d1*2 e2 e |
  % 10
  dis b1 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'2 a |
  % 2
  b4 a g fis |
  % 3
  g a2 g4 |
  % 4
  g2 fis |
  % 5
  b1 |
  % 6
  g |
  % 7
  fis1*2 a2 b2. a4 g1 
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
  e2 fis |
  % 2
  g4 fis e dis |
  % 3
  e fis g e |
  % 4
  c a d2 |
  % 5
  g,1 |
  % 6
  g'2 b, |
  % 7
  d1*2 c2 b4 a |
  % 10
  b2 e,1 
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
