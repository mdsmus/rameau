% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 127.mid
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
  s2. g''4 |
  % 2
  g g g g |
  % 3
  g8 a b4 c c |
  % 4
  d d c g |
  % 5
  g8 a b4 c c |
  % 6
  d d c g |
  % 7
  a g f g |
  % 8
  a b c2 |
  % 9
  ais8 a g a ais4 a |
  % 10
  g g g1 
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
  e f e e |
  % 3
  d4. e16 f e4 f8 g |
  % 4
  a g f4 f4. e8 |
  % 5
  d4 g8 f e4 f |
  % 6
  f f f e |
  % 7
  e8 f e4 d e |
  % 8
  f f8 e e2 |
  % 9
  fis4 g8 d d4 f |
  % 10
  f e d1 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  c d d c |
  % 3
  b8 a g4 g a8 c |
  % 4
  f4 a,8 b c4 c |
  % 5
  b8 a g4 g a |
  % 6
  a d g, c8 ais |
  % 7
  a4 ais8 a a4 c |
  % 8
  c8 d d4 c2 |
  % 9
  d8 c ais a g4 a |
  % 10
  d4. c8 c b16 a b2. 
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
  s2. g'8 f |
  % 2
  e d c b c d e f |
  % 3
  g4 g, c f8 e |
  % 4
  d e f g a b c4 |
  % 5
  g8 f e d c4 f8 e |
  % 6
  d c4 b8 c d e d |
  % 7
  cis d4 cis8 d4 c8 b |
  % 8
  a a'4 gis8 a2 |
  % 9
  d,4 e8 fis g4 d8 c |
  % 10
  b g c4 g1 
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
