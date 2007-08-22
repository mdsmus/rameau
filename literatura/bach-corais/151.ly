% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 151.mid
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
  b''4 b b d |
  % 2
  c c b2 |
  % 3
  b4 b a b |
  % 4
  c b a2 |
  % 5
  g1 |
  % 6
  b4 b b d |
  % 7
  c c b2 |
  % 8
  b4 b a b |
  % 9
  c b a2 |
  % 10
  g1 |
  % 11
  b4 b a a |
  % 12
  g g fis2 |
  % 13
  e'4 d c b |
  % 14
  a a g2 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''4 g8 a g4 g4. fis16 e fis4 g2 |
  % 3
  g4 g4. fis8 g4 |
  % 4
  a4. g4 fis16 e fis4 |
  % 5
  d1 |
  % 6
  g4 g8 a g4 g4. fis16 e fis4 g2 |
  % 8
  g4 g4. fis8 g4 |
  % 9
  a4. g4 fis16 e fis4 |
  % 10
  d1 |
  % 11
  g4 g g fis2 e4 dis2 |
  % 13
  e8 fis g4. fis8 g4. fis16 e fis4 d2 |
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
  d'4 e8 fis e4 d |
  % 2
  e8 c a d d2 |
  % 3
  d4 d d d |
  % 4
  e8 d d4 e8 a, d c |
  % 5
  b1 |
  % 6
  d4 e8 fis e4 d |
  % 7
  e8 c a d d2 |
  % 8
  d4 d d d |
  % 9
  e8 d d4 e8 a, d c |
  % 10
  b1 |
  % 11
  d4 d d4. c8 |
  % 12
  b4 b b2 |
  % 13
  g'8 a d,4 e8 c d4 |
  % 14
  e8 a, d c b2 |
  % 15
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  g'8 fis e dis e d c b |
  % 2
  a4 d g,2 |
  % 3
  g8 a b c d4 g4. fis8 g b, c4 d |
  % 5
  g,1 |
  % 6
  g'8 fis e dis e d c b |
  % 7
  a4 d g,2 |
  % 8
  g8 a b c d4 g4. fis8 g b, c4 d |
  % 10
  g,1 |
  % 11
  g8 a b c d e fis dis |
  % 12
  e fis g a b2 |
  % 13
  c,8 c'4 b8 a, a'4 g8 |
  % 14
  c,4 d g,2 |
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
