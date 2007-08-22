% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 238.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  e'4 e b' b8 c |
  % 2
  d4 b g a8 b |
  % 3
  c2 b |
  % 4
  a4 a g a |
  % 5
  b a g fis |
  % 6
  e2 d |
  % 7
  g4 fis g8 a b4 |
  % 8
  a8 g fis4 e2 |
  % 9
  fis4 e8 fis g4 fis |
  % 10
  e1 |
  % 11
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  b'4 b e8 fis g4 |
  % 2
  a8 fis g fis e4 fis8 g4 fis16 e fis4 g2 |
  % 4
  g4. fis8 fis e d a' |
  % 5
  a g4 fis8 e4 a,8 d |
  % 6
  d cis16 b cis4 a2 |
  % 7
  e'4 fis e e |
  % 8
  e dis e2 |
  % 9
  dis4 e8 dis e4. d8 |
  % 10
  b1 |
  % 11
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 g8 a b4 e |
  % 2
  d d c4. d8 |
  % 3
  c d16 e d4 d2 |
  % 4
  e4 d8. c16 b4 d |
  % 5
  d d4. cis8 d a |
  % 6
  b g e a16 g fis2 |
  % 7
  b4 b b b |
  % 8
  c c8 b16 a g2 |
  % 9
  b4. a8 b16*7 a16 |
  % 10
  gis1 |
  % 11
  
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
  e4. fis8 g4 e |
  % 2
  fis8 d g4 c8 b a g |
  % 3
  a4 d, g2 |
  % 4
  cis,4 d e fis |
  % 5
  g d e fis |
  % 6
  g8 e a a, d2 |
  % 7
  e4. dis8 e4 g, |
  % 8
  a b c2 |
  % 9
  b8 a g fis e4 b' |
  % 10
  e1 |
  % 11
  
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
