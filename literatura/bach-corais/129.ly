% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 129.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b b b e |
  % 3
  d4. c8 b4 b8 c |
  % 4
  d4 fis, g a |
  % 5
  b2. b4 |
  % 6
  b b b e |
  % 7
  d4. c8 b4 b8 c |
  % 8
  d4 fis, g a |
  % 9
  b2. a4 |
  % 10
  a a a a |
  % 11
  b2 a4 a |
  % 12
  b8 cis d4 d cis |
  % 13
  d2. d4 |
  % 14
  b b c d |
  % 15
  e2 b4 b |
  % 16
  a g8 fis fis4. e8 |
  % 17
  e1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  fis e8 dis e fis g2 fis4 d d |
  % 4
  d d8 c b4 e |
  % 5
  dis2. e4 |
  % 6
  fis e8 dis e fis g2 fis4 d d |
  % 8
  d d8 c b4 e |
  % 9
  dis2. e4 |
  % 10
  d d8 cis d e fis4 |
  % 11
  g2 fis4 a |
  % 12
  g a a4. g8 |
  % 13
  fis2. fis4 |
  % 14
  d g g f |
  % 15
  e2 e4 e |
  % 16
  e e e dis |
  % 17
  b1 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. g'4 |
  % 2
  fis8 g a4 g c8 b |
  % 3
  a g a4 g g |
  % 4
  a a g8 fis e4 |
  % 5
  fis2. g4 |
  % 6
  fis8 g a4 g c8 b |
  % 7
  a g a4 g g |
  % 8
  a a g8 fis e4 |
  % 9
  fis2. e4 |
  % 10
  fis8 e fis g a4 d |
  % 11
  d2 d4 d |
  % 12
  d d8 e fis4 e |
  % 13
  d2. a4 |
  % 14
  g d' e b2 a4 g b |
  % 16
  e, c' b8 g a4 |
  % 17
  gis1 |
  % 18
  
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
  s2. e4 |
  % 2
  dis b e8 d c4 |
  % 3
  d2 g,4 g' |
  % 4
  fis8 e d4 e8 d c4 |
  % 5
  b2. e4 |
  % 6
  dis b e8 d c4 |
  % 7
  d2 g,4 g' |
  % 8
  fis8 e d4 e8 d c4 |
  % 9
  b2. cis4 |
  % 10
  d d8 e fis4 d |
  % 11
  g,8 a b c d4 fis |
  % 12
  g fis8 g a4 a, |
  % 13
  d2. d4 |
  % 14
  g8 a g f e f e d |
  % 15
  c b c d e4 g, |
  % 16
  c b8 a b4 b |
  % 17
  e,1 |
  % 18
  
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
