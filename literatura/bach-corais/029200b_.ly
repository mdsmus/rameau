% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 029200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g a b |
  % 2
  c2 c |
  % 3
  e4 d c b |
  % 4
  a2 g |
  % 5
  g4 g a b |
  % 6
  c g g2 |
  % 7
  a4 g f e |
  % 8
  d d c2 |
  % 9
  c'4 d c b |
  % 10
  a2 g |
  % 11
  g4 g a b |
  % 12
  c g g2 |
  % 13
  a4 g f e |
  % 14
  d2 c |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 d e8 fis g4 |
  % 2
  g f2 e4 |
  % 3
  g fis8 g16 fis e8 a d, c16 d |
  % 4
  e8 c a d16 c b2 |
  % 5
  e4 e e8 fis g4 |
  % 6
  g8 f4 e16 d e2 |
  % 7
  f8 e d e16 d c8 b c2 c8 b g2 |
  % 9
  g'4 g4. fis8 g4 |
  % 10
  g fis g2 |
  % 11
  e8 f g4. f16 e f4 |
  % 12
  f8 e d4 c2 |
  % 13
  c8 f4 e d8 c4. b16 a b4 g2 |
  % 15
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  c'4 g c d |
  % 2
  c8 ais a4 g2 |
  % 3
  c8 b a b16 a g8 fis g8*5 fis8 d2 |
  % 5
  b'4 b c d |
  % 6
  c d8 g, c2 |
  % 7
  c4 b8 c16 b a8 d g, f16 g |
  % 8
  a8 f d g16 f e2 |
  % 9
  e'4 d g,8 a b c16 d |
  % 10
  e8 c a d16 c b2 |
  % 11
  c4 c c d |
  % 12
  g, g8. f16 e2 |
  % 13
  f4 g8 c16 ais a4 a |
  % 14
  a8 d, d g16 f e2 |
  % 15
  
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
  c4. b8 a4 g8 f |
  % 2
  e4 f c2 |
  % 3
  c'4. b4 a8 g a16 b |
  % 4
  c8 a d4 g,2 |
  % 5
  e8 e'4 d8 c4 b |
  % 6
  a b c2 |
  % 7
  f4. e4 d8 c d16 e |
  % 8
  f8 d g g, c2 |
  % 9
  c4. b8 e4 d |
  % 10
  c d g,2 |
  % 11
  c8 d e4 f8 e d4 |
  % 12
  c4. b8 c2 |
  % 13
  f4 c d a8 g |
  % 14
  f4 g c,2 |
  % 15
  
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
