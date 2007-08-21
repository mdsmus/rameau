% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 028200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key g \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 g''4 b2 a4 b2 |
  % 3
  c4 d2. |
  % 4
  b2 s4 e1. d c8*7 b8 c4 |
  % 9
  s4 b e8 c a4 |
  % 10
  b2 d4 e2 fis4 g2 |
  % 12
  fis4 e2. |
  % 13
  d2 b4 a2 g4 g2 |
  % 15
  fis4 g2. |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 d'4 g2 fis4 g2 |
  % 3
  g4 g4. fis16 e fis4 |
  % 4
  d2 s1 f4*9 e2. fis4 fis |
  % 9
  s4 g8 fis e4 fis8 e |
  % 10
  dis2 g4 g2 a4 b2 |
  % 12
  a4 b8 a g4. a16 g |
  % 13
  fis2 g4 g |
  % 14
  fis e e d2 d2. |
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
  s2 b'4 d2 d4 d2 |
  % 3
  c4 b4. a16 g a4 |
  % 4
  g2 s4*7 gis1. a1 a4 |
  % 9
  s4 g8 b b a16 b c4 |
  % 10
  fis,2 d'4 c2 c4 d2 |
  % 12
  d4 d4. cis16 b cis4 |
  % 13
  a2 e'4 e |
  % 14
  b b c8 b a b |
  % 15
  c4 b2. |
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
  s2 g'4 g2 d4 g fis |
  % 3
  e b8 c d4 d |
  % 4
  g,2 s2*5 c8*9 b8 c a d4 d |
  % 9
  s4 e8 d c4 c |
  % 10
  b2 b'4 b2 a4 g b |
  % 12
  d g,8 fis e4 a |
  % 13
  d,2 e8 d cis4 |
  % 14
  dis e c d2 g,2. |
  % 16
  
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
