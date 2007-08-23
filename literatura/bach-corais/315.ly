% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 315.mid
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
  b e d c16 b c8 |
  % 3
  b2. b8 c |
  % 4
  d4 g, a b |
  % 5
  a2 g4 b |
  % 6
  b e d c16 b c8 |
  % 7
  b2. b8 c |
  % 8
  d4 g, a b |
  % 9
  a2 g4 a |
  % 10
  a b c8 e d c |
  % 11
  b2. b4 |
  % 12
  a d8 e16 fis e4 d8 cis |
  % 13
  d2. d4 |
  % 14
  d b c d |
  % 15
  e2. a,4 |
  % 16
  b8 c16 d c8 b b4 a8 g |
  % 17
  g1 |
  % 18
  
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
  fis g8 fis g4 fis |
  % 3
  g2. g4 |
  % 4
  g8 fis e fis16 g fis4 g4. e8 fis4 d g |
  % 6
  fis g8 fis g4 fis |
  % 7
  g2. g4 |
  % 8
  g8 fis e fis16 g fis4 g4. e8 fis4 d e |
  % 10
  d fis g a |
  % 11
  g2. g8 fis |
  % 12
  e d16 cis d4 g8 b a g |
  % 13
  fis2. a4 |
  % 14
  g g g g |
  % 15
  g2. fis4 |
  % 16
  g g g fis |
  % 17
  d1 |
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
  s2. g'8 a |
  % 2
  b4. a8 b e d4 |
  % 3
  d2. d8 c |
  % 4
  b a g4 d' d |
  % 5
  d4. c8 b4 g8 a |
  % 6
  b4. a8 b e d4 |
  % 7
  d2. d8 c |
  % 8
  b a g4 d' d |
  % 9
  d4. c8 b4 cis |
  % 10
  d d c8 b a d |
  % 11
  d2. d4 |
  % 12
  cis8 a g fis b g' fis e |
  % 13
  d2. fis4 |
  % 14
  g d e f |
  % 15
  e2. d4 |
  % 16
  d d8 e d4 c |
  % 17
  b1 |
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
  s2. e4. d4 c8 b c d4 |
  % 3
  g,2. g8 a |
  % 4
  b4 c4. b8 a g |
  % 5
  d'2 g,4 e'4. d4 c8 b c d4 |
  % 7
  g,2. g8 a |
  % 8
  b4 c4. b8 a g |
  % 9
  d'2 g,4 g'4. fis8 e d e4 fis |
  % 11
  g2. g,4 |
  % 12
  g'8 fis b a g e a4 |
  % 13
  d,2. d'8 c |
  % 14
  b a g f e d c b |
  % 15
  c2. d4 |
  % 16
  g,8 a b c d4 d |
  % 17
  g,1 |
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
