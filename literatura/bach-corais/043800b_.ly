% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043800b_.mid
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
  c' c8 ais a4 g |
  % 3
  a b c c |
  % 4
  a c ais c |
  % 5
  a g f c' |
  % 6
  d d a c |
  % 7
  ais ais a f' |
  % 8
  e d c4. d8 |
  % 9
  ais a g4 f2 |
  % 10
  
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
  f8 g a g4 f e8 |
  % 3
  f e d4 e g4. f8 g a4 g16 f g4. f4 e8 c4 f |
  % 6
  f f c4. a'4 g16 fis g4. fis8 a4 |
  % 8
  a8 g f g a g f4 |
  % 9
  f4. e8 c2 |
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
  s2. a'8 ais |
  % 2
  c d e4 c c |
  % 3
  c g g c |
  % 4
  c4. e8 f d c4 |
  % 5
  c c8 ais a4 a |
  % 6
  ais f8 g a4 f'8 dis |
  % 7
  d4 d d d |
  % 8
  c d8 e f4 a, |
  % 9
  ais4. c16 ais a2 |
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
  s2. f8 g |
  % 2
  a ais c4 f, c |
  % 3
  f g c, e |
  % 4
  f e8 c d g e c |
  % 5
  f4 c f, f' |
  % 6
  ais,8 c d e f g a fis |
  % 7
  g a ais c d4 d, |
  % 8
  a' ais f8 e d4 |
  % 9
  g c, f2 |
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
