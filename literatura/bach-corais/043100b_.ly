% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043100b_.mid
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
  f g a g8 a |
  % 3
  ais4 a g4. g8 |
  % 4
  f2 s4 a |
  % 5
  ais a g f |
  % 6
  e f g c |
  % 7
  ais a g8 f e4 |
  % 8
  f d c a' |
  % 9
  ais a g f |
  % 10
  a g f2 |
  % 11
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'4. b8 c4. d8 e4 |
  % 3
  f8 g4 f e16 d e4 |
  % 4
  c2 s4 f4. g4 f e8 d4 |
  % 6
  g, c c e8 fis |
  % 7
  g e f e d4. c4 d16 c b4 g f'8 dis |
  % 9
  d e f4. e4 d16 e |
  % 10
  f4. e8 c2 |
  % 11
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 g |
  % 2
  f4 c'8 ais a ais c4 |
  % 3
  f,8 c' c4 d8 ais g c16 ais |
  % 4
  a2 s4 c |
  % 5
  d8 c c4 d8 c4 b8 |
  % 6
  c4 f, e a |
  % 7
  d8 cis d4 g, g |
  % 8
  a g8 f e4 c' |
  % 9
  ais c16*7 ais16 a8 ais |
  % 10
  c4 c8. ais16 a2 |
  % 11
  
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
  s2. f8 e |
  % 2
  d4 e8 c f4 c |
  % 3
  d8 e f4 ais, c |
  % 4
  f,2 s4 f'8 dis |
  % 5
  d e f4 b,8 c d4 |
  % 6
  c8 ais a f c'4 a |
  % 7
  g d'8 c b4 c |
  % 8
  f, g c f, |
  % 9
  g a8 ais c4 d |
  % 10
  a8 ais c4 f,2 |
  % 11
  
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
