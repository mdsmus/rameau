% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 200.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 g a b |
  % 2
  c2 c4 g |
  % 3
  c ais a2 |
  % 4
  g g4 a |
  % 5
  ais c ais a |
  % 6
  g2 g4 c |
  % 7
  c b c2 |
  % 8
  c4 c d d |
  % 9
  c ais a2 |
  % 10
  g4 a ais a |
  % 11
  g2 ais4 c |
  % 12
  d dis8 d c2 |
  % 13
  d d4 c |
  % 14
  d c ais g |
  % 15
  a b c2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''4 g4. fis8 g4 |
  % 2
  g4. f4 e8 e4. fis8 g4 g fis |
  % 4
  d2 d8 dis4 d ais'8 a g fis g4 fis8 |
  % 6
  d2 e8 f g4 |
  % 7
  g g g2 |
  % 8
  a4 a8 g f g a2 ais8 g f2 |
  % 10
  e4 e8 fis g4. fis8 |
  % 11
  g2 d8 ais'4 a8 |
  % 12
  ais2 ais4 a |
  % 13
  ais2 ais4. a8 |
  % 14
  ais4 a g e |
  % 15
  f8 e d f e2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  e'4 d c d |
  % 2
  c8 ais a4 g c8 ais |
  % 3
  c4 d dis d8 c |
  % 4
  ais2 ais4 c |
  % 5
  ais8 g dis'4 d16*7 c16 |
  % 6
  ais2 c4. d8 |
  % 7
  e d16 c d8 f4 e16 d e4 |
  % 8
  f f f8 e d e |
  % 9
  f4. e8 c2 |
  % 10
  c4 c d dis8 d16 c |
  % 11
  ais2 ais8 d f4 |
  % 12
  f dis8 f g dis c f |
  % 13
  f2 f4 f |
  % 14
  f dis8 d d4 c |
  % 15
  c g g2 |
  % 16
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  c'4 b a g8 f |
  % 2
  e4 f c c'8 ais |
  % 3
  a4 g c, d |
  % 4
  g,2 g'4 fis |
  % 5
  g c, d d, |
  % 6
  g2 c8 d e f |
  % 7
  g4 g, c2 |
  % 8
  f8 g f e d e f g |
  % 9
  a f g c, f2 |
  % 10
  c'8 ais a4 g8 ais, c d |
  % 11
  dis2 g4 f |
  % 12
  ais8 a g f dis c f4 |
  % 13
  ais,2 ais'4 f |
  % 14
  ais8 a g fis g a ais c |
  % 15
  f,4 g c,2 |
  % 16
  
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
