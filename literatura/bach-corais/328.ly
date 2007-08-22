% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 328.mid
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
  b''4 a8 g a4 d |
  % 2
  b g a2 |
  % 3
  g4 g g g |
  % 4
  a b a2 |
  % 5
  g1 |
  % 6
  b4 a8 g a4 d |
  % 7
  b g a2 |
  % 8
  g4 g g g |
  % 9
  a b a2 |
  % 10
  g1 |
  % 11
  d4 d e fis |
  % 12
  g a8 g fis e d4 |
  % 13
  g g g g |
  % 14
  a b a2 |
  % 15
  g1 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d fis |
  % 2
  d d8 e fis2 |
  % 3
  e4 f e d |
  % 4
  e8 fis g4 g fis |
  % 5
  d1 |
  % 6
  d4 d d fis |
  % 7
  d d8 e fis2 |
  % 8
  e4 f e d |
  % 9
  e8 fis g4 g fis |
  % 10
  d1 |
  % 11
  b4 a b8 cis d4 |
  % 12
  e e d a |
  % 13
  d8 b c d e4 e |
  % 14
  e8 fis g4. e8 fis4 |
  % 15
  d1 |
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
  g'8 a b4 a a |
  % 2
  b8 c d4 d2 |
  % 3
  b4 b c g |
  % 4
  c d e8 c a d16 c |
  % 5
  b1 |
  % 6
  g8 a b4 a a |
  % 7
  b8 c d4 d2 |
  % 8
  b4 b c g |
  % 9
  c d e8 c a d16 c |
  % 10
  b1 |
  % 11
  g4 a g a |
  % 12
  b a a8 g fis4 |
  % 13
  g4. f8 e fis g a16 b |
  % 14
  c4 d d4. c8 |
  % 15
  b1 |
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
  g4 g'4. fis8 e d |
  % 2
  g a b g d2 |
  % 3
  e,8 e'4 d8 c, c'4 b8 |
  % 4
  a4 g8 b c a d4 |
  % 5
  g,1 |
  % 6
  g4 g'4. fis8 e d |
  % 7
  g a b g d2 |
  % 8
  e,8 e'4 d8 c, c'4 b8 |
  % 9
  a4 g8 b c a d4 |
  % 10
  g,1 |
  % 11
  g8 g'4 fis8 e4 d2 cis4 d d |
  % 13
  b8 g a b c d c b |
  % 14
  a4 g d'2 |
  % 15
  g,1 |
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
