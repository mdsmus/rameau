% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 148.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b8 c d4 b g |
  % 3
  a b c b |
  % 4
  a g g4. a8 |
  % 5
  b4 b a8 g a4 |
  % 6
  g2. b4 |
  % 7
  b8 c d4 b g |
  % 8
  a b c b |
  % 9
  a g g4. a8 |
  % 10
  b4 b a8 g a4 |
  % 11
  g2. b4 |
  % 12
  a b g e |
  % 13
  fis g a b |
  % 14
  g g g4. a8 |
  % 15
  b4 b a8 g a4 |
  % 16
  g2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  g a g g |
  % 3
  f8 e d4 e d4. c8 b4 e2 |
  % 5
  d4 d d4. c8 |
  % 6
  b2. g'4 |
  % 7
  g a g g |
  % 8
  f8 e d4 e d4. c8 b4 e2 |
  % 10
  d4 d d4. c8 |
  % 11
  b2. g'4 |
  % 12
  fis fis e8 d cis4 |
  % 13
  d4. cis8 d4 dis |
  % 14
  b e d e8 fis |
  % 15
  g4 d d4. c8 |
  % 16
  b2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  d d d d8 c |
  % 3
  c4 g g g |
  % 4
  fis g c2 |
  % 5
  b8 a g4 g fis |
  % 6
  d2. d'4 |
  % 7
  d d d d8 c |
  % 8
  c4 g g g |
  % 9
  fis g c2 |
  % 10
  b8 a g4 g fis |
  % 11
  d2. d'4 |
  % 12
  d8 c b4 b a |
  % 13
  a g fis fis |
  % 14
  g c b8 c b a |
  % 15
  g4 g2 fis4 |
  % 16
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
  s2. g4 |
  % 2
  g' fis g e |
  % 3
  f g c, g |
  % 4
  d' e8 d c d e fis |
  % 5
  g4 b,8 c d4 d |
  % 6
  g,2. g4 |
  % 7
  g' fis g e |
  % 8
  f g c, g |
  % 9
  d' e8 d c d e fis |
  % 10
  g4 b,8 c d4 d |
  % 11
  g,2. g4 |
  % 12
  d' dis e a8 g |
  % 13
  fis4 e d b |
  % 14
  e8 d e fis g a g fis |
  % 15
  e4 b8 c d2 |
  % 16
  g,2. 
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
