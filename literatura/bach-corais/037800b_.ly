% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 037800b_.mid
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
  s2. g''4 |
  % 2
  g d g a |
  % 3
  b2 s4 d |
  % 4
  e d c4. d8 |
  % 5
  b2 s4 d |
  % 6
  c b a g |
  % 7
  a2 s4 b |
  % 8
  g c b a |
  % 9
  g2 s4 b8 c |
  % 10
  d4 d c b |
  % 11
  a2 s4 b |
  % 12
  g g a b |
  % 13
  c2 b4 d |
  % 14
  c a b c |
  % 15
  d2 s4 g, |
  % 16
  a b c b |
  % 17
  a2 g |
  % 18
  
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
  d a d e8 fis |
  % 3
  g2 s4 g4. fis8 g4. fis16 e fis4 |
  % 5
  g2 s4 g4. fis8 g4. fis8 g g, |
  % 7
  d'2 s4 fis |
  % 8
  fis8 e16 fis g8 a4 g8 g fis |
  % 9
  d2 s4 g |
  % 10
  g g g8 fis g4 |
  % 11
  g fis s4 fis |
  % 12
  e d e e |
  % 13
  e2 e4 d8 f |
  % 14
  e g4 fis8 g4 g |
  % 15
  g2 s4 e4. fis8 g4. fis8 g4 |
  % 17
  g8 fis16 e fis4 d2 |
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
  s2. b'8 a |
  % 2
  g4 fis g c |
  % 3
  d2 s4 d |
  % 4
  c d e8 d16 c d4 |
  % 5
  d2 s4 b |
  % 6
  c d d4. cis8 |
  % 7
  fis2 s4 b, |
  % 8
  b e8 d d4 d8. c16 |
  % 9
  b2 s4 d |
  % 10
  d8 c b4 c d |
  % 11
  d2 s4 b |
  % 12
  b8 c d4 c b4. a16 gis a4 a8 gis g4 |
  % 14
  g d' d e |
  % 15
  d2 s4 b |
  % 16
  c8 d d e16 d c4 d |
  % 17
  e d8. c16 b2 |
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
  s2. g8 a |
  % 2
  b c d c b4 a |
  % 3
  g2 s4 b |
  % 4
  c4. b8 a4 d, |
  % 5
  g2 s4 g |
  % 6
  a b8 c d4 e |
  % 7
  d2 s4 dis |
  % 8
  e4. fis8 g4 d |
  % 9
  g,2 s4 g8 a |
  % 10
  b4. e8 a,4 b8 c |
  % 11
  d2 s4 dis |
  % 12
  e8 d c b c b a gis |
  % 13
  a b c d e4 b |
  % 14
  c d g8 fis e4 |
  % 15
  b2 s4 e8 d |
  % 16
  c4 b8 e a,4 b8 g |
  % 17
  c4 d g,2 |
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
