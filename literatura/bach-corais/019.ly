% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 019.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g fis ais |
  % 3
  a g fis fis |
  % 4
  fis fis g e |
  % 5
  fis fis g a |
  % 6
  a c a f |
  % 7
  g a ais ais |
  % 8
  a g fis fis |
  % 9
  fis fis g e |
  % 10
  fis fis g2 |
  % 11
  
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
  d d8 cis d4 g8 f |
  % 3
  dis d e4 d d |
  % 4
  c d d c |
  % 5
  c8 dis d4 d f |
  % 6
  f g f f |
  % 7
  dis8 d c dis d4 g4. fis8 g g, d'4 d |
  % 9
  c8 d dis d d4 e |
  % 10
  d d d2 |
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
  s2. ais'4 |
  % 2
  ais8 a g4 a d |
  % 3
  c ais8 a a4 a |
  % 4
  a a g g |
  % 5
  a8 c c ais16 a ais4 c |
  % 6
  c c c ais |
  % 7
  ais a8 c ais4 d |
  % 8
  d4. c8 a4 a |
  % 9
  a a g16*5 a16 ais8 |
  % 10
  a g a16 ais c8 c b4. |
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
  s2. g'4 |
  % 2
  g8 f dis4 d8 c ais g |
  % 3
  c4 cis d d8 dis4 d c8 c b c ais |
  % 5
  a4 d g, f' |
  % 6
  f8 g f e f dis4 d8 |
  % 7
  dis e f fis g4 g, |
  % 8
  d' dis d d |
  % 9
  a8 ais c4 ais8 b c cis |
  % 10
  d4 d, g2 |
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
