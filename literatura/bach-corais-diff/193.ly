% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 193.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s4 e'' c4. b8 |
  % 2
  a4 e' f e8 d |
  % 3
  c4 d e e |
  % 4
  s4 e c4. b8 |
  % 5
  a4 e' f e8 d |
  % 6
  c4 d e e |
  % 7
  s4 c d4. g,8 |
  % 8
  g2 s4 d' |
  % 9
  e4. c8 c2 |
  % 10
  s4 e f e |
  % 11
  d c b4. a8 |
  % 12
  gis e' d c b2 |
  % 13
  a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s4 a'' a g |
  % 2
  e a a gis |
  % 3
  e a gis gis |
  % 4
  s4 a a g |
  % 5
  e a a gis |
  % 6
  e a gis gis |
  % 7
  s4 a g f2 e4 s4 g |
  % 9
  g g f2 |
  % 10
  s4 g f8 a gis4 |
  % 11
  a8 d, e4 f e |
  % 12
  d a'2 gis4 |
  % 13
  e2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s4 c'8 d e4 e8. d16 |
  % 2
  c4 c b b |
  % 3
  a8 c b a b4 b |
  % 4
  s4 c8 d e4 e8. d16 |
  % 5
  c4 c b b |
  % 6
  a8 c b a b4 b |
  % 7
  s4 e d d |
  % 8
  c2 s4 d |
  % 9
  c c8 ais a2 |
  % 10
  s4 cis d4. c4 b a gis a8 |
  % 12
  b4 e e e8 d |
  % 13
  cis2. 
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
  s4 a a' e |
  % 2
  a, a' d, e |
  % 3
  a f e e |
  % 4
  s4 a, a' e |
  % 5
  a, a' d, e |
  % 6
  a f e e |
  % 7
  s4 a, b2 |
  % 8
  c s4 b |
  % 9
  c e f2 |
  % 10
  s4 e d e |
  % 11
  f e d c |
  % 12
  b a e' e, |
  % 13
  a2. 
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
