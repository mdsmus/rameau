% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 167.mid
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
  s2. g''4 |
  % 2
  g g g a |
  % 3
  b2 s4 b |
  % 4
  b d g,8 a b4 |
  % 5
  a2 g4 b |
  % 6
  a b g a |
  % 7
  fis2 s4 g |
  % 8
  g g a g |
  % 9
  fis2 e4 fis |
  % 10
  fis fis fis g |
  % 11
  a2 s4 a |
  % 12
  a b c c |
  % 13
  b2 s4 b |
  % 14
  b d c b |
  % 15
  a2 s4 a |
  % 16
  b a g fis |
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
  d e d e8 fis |
  % 3
  g2 s4 g |
  % 4
  g g8 fis e fis g4 |
  % 5
  g fis d g |
  % 6
  fis fis4. e4 fis8 |
  % 7
  dis2 s4 e |
  % 8
  e d e8 dis e2 dis4 b d |
  % 10
  d e d cis |
  % 11
  d2 s4 fis |
  % 12
  fis g g fis |
  % 13
  g2 s4 g |
  % 14
  g g4. fis8 g4 |
  % 15
  fis2 s4 fis4. e8 fis4. e4 dis8 |
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
  s2. b'4 |
  % 2
  b8 a g a b4 c |
  % 3
  d2 s4 d |
  % 4
  e d c d4. a8 d c b4 d |
  % 6
  d dis b c |
  % 7
  b2 s4 b |
  % 8
  c g c cis |
  % 9
  fis,8 b4 a8 g4 b |
  % 10
  b cis4. b8 a g |
  % 11
  fis2 s4 d' |
  % 12
  d d e d |
  % 13
  d2 s4 d |
  % 14
  e d e8 d d4 |
  % 15
  d2 s4 d8 c |
  % 16
  b2. b8. a16 |
  % 17
  g1 |
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
  b c b a |
  % 3
  g2 s4 g'8 fis |
  % 4
  e4 b c b8 c |
  % 5
  d2 g,4 g' |
  % 6
  d8 c b4 e a, |
  % 7
  b2 s4 e8 d |
  % 8
  c d c b a4 ais |
  % 9
  b2 e4 b8 cis |
  % 10
  d4 ais b e |
  % 11
  d2 s4 d |
  % 12
  d'8 c b4 a d, |
  % 13
  g2 s4 g8 fis |
  % 14
  e d c b a4 g |
  % 15
  d'2 s4 d |
  % 16
  dis8 cis dis b e4 b |
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
