% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006906ba.mid
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
  s2. d'4 |
  % 2
  g a b c |
  % 3
  d4. c8 b4 e |
  % 4
  d c b c |
  % 5
  a2 g4 d |
  % 6
  g a b c |
  % 7
  d4. c8 b4 e |
  % 8
  d c b c |
  % 9
  a2 g4 d' |
  % 10
  e e a, a |
  % 11
  d d g, b |
  % 12
  a g fis g |
  % 13
  e2 d4 d' |
  % 14
  c b a b |
  % 15
  a2 g |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b'4 |
  % 2
  d d d g |
  % 3
  g fis d c8 b |
  % 4
  a4 e' d e |
  % 5
  d2 d4 b |
  % 6
  d d d g |
  % 7
  g fis d c8 b |
  % 8
  a4 e' d e |
  % 9
  d2 d4 g |
  % 10
  g a8 g fis4 fis |
  % 11
  g4. f8 e4 d |
  % 12
  cis b a b |
  % 13
  a2 a4 g |
  % 14
  g8 a b c d4 d |
  % 15
  d2 d |
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
  s2. g'4 |
  % 2
  b a g g8 a |
  % 3
  b4 a g g |
  % 4
  fis g8 a b fis g4 |
  % 5
  g fis d g |
  % 6
  b a g g8 a |
  % 7
  b4 a g g |
  % 8
  fis g8 a b fis g4 |
  % 9
  g fis d b' |
  % 10
  c8 b a4 d d |
  % 11
  d8 c b d c4 b8 g |
  % 12
  e4 d d8 fis e d |
  % 13
  d4 cis fis d |
  % 14
  e d8 e fis4 g |
  % 15
  g fis g2 |
  % 16
  
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
  b d g, c |
  % 4
  d e8 fis g4 c, |
  % 5
  d2 g,4 g |
  % 6
  g' fis g e |
  % 7
  b d g, c |
  % 8
  d e8 fis g4 c, |
  % 9
  d2 g,4 g' |
  % 10
  c, cis d c |
  % 11
  b b c g |
  % 12
  a b8 cis d4 g, |
  % 13
  a2 d,4 b' |
  % 14
  e8 fis g4 d8 c b g |
  % 15
  d2 g |
  % 16
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. g'4 |
  % 2
  b a g g8 a |
  % 3
  b4 a g g |
  % 4
  fis g8 a b fis g4 |
  % 5
  g fis b g |
  % 6
  b a g g8 a |
  % 7
  b4 a g g |
  % 8
  fis g8 a b fis g4 |
  % 9
  g fis b b |
  % 10
  c8 b a4 d d |
  % 11
  d8 c b d c4 b8 g |
  % 12
  e4 d d8 fis e d |
  % 13
  d4 cis fis d |
  % 14
  e d8 e fis4 g |
  % 15
  g fis b2 |
  % 16
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
