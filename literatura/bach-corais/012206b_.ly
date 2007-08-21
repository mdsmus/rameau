% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 012206b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key g \minor
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g g d'4. c8 ais4 d c |
  % 3
  ais a2. |
  % 4
  d4 d e f2 e4 d cis2 d2. |
  % 7
  d4 c a ais4. c8 d4 c ais |
  % 9
  a ais2. |
  % 10
  f'4 g f d4. c8 ais4 a g |
  % 12
  fis g2. |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 g8 a ais4 a2 g4 g fis |
  % 3
  g fis2. |
  % 4
  g8 a ais4 ais a2 g4 f e2 fis2. |
  % 7
  g4 dis d d |
  % 8
  g f g f |
  % 9
  f f2. |
  % 10
  ais4 ais a a2 g4 dis d |
  % 12
  d d2. |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 d d d2 d8 c ais4 c |
  % 3
  d d2. |
  % 4
  d4 g g f |
  % 5
  b, cis d a2 a2. |
  % 7
  ais4 a a g |
  % 8
  dis' d dis d |
  % 9
  c d2. |
  % 10
  d4 c c a |
  % 11
  d d c ais |
  % 12
  a b2. |
  % 13
  
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
  g'8 a ais4 a8 g fis2 g4 ais, a |
  % 3
  g d'2. |
  % 4
  ais'4 a8 g cis4 d |
  % 5
  d, e f8 g a4 |
  % 6
  a, d2. |
  % 7
  g,4 g' fis g4. a8 ais4 dis, f |
  % 9
  f, ais2. |
  % 10
  ais'4 dis, f fis2 g4 c, d |
  % 12
  d g,2. |
  % 13
  
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
  g'8 a ais4 a8 g fis2 g4 ais, a |
  % 3
  g d'2. |
  % 4
  ais'4 a8 g cis,4 d2 e4 f8 g a4 |
  % 6
  a, d,2. |
  % 7
  g4 g' fis g4. a8 ais4 dis, f |
  % 9
  f, ais2. |
  % 10
  ais'4 dis, f fis2 g4 c, d |
  % 12
  d, g2. |
  % 13
  
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
