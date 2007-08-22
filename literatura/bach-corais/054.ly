% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 054.mid
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
  d' d d d |
  % 3
  e d8 c b4 a |
  % 4
  b8 cis d4 e e |
  % 5
  d2 s4 d |
  % 6
  d d d b8 c |
  % 7
  d4 c8 b a4 d |
  % 8
  c b a a |
  % 9
  g8 a b c d4 d |
  % 10
  c b8 a b4 a |
  % 11
  g1 |
  % 12
  
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
  d8 e fis4 g g |
  % 3
  g fis g a |
  % 4
  g fis e8 fis g4 |
  % 5
  fis2 s4 a |
  % 6
  g fis g g |
  % 7
  g a8 g fis4 fis |
  % 8
  g8 a4 g e8 fis4 |
  % 9
  g2 fis4 g |
  % 10
  g g g fis |
  % 11
  d1 |
  % 12
  
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
  a d8 c b c d4 |
  % 3
  c8 b a d d4 d |
  % 4
  g, a b cis |
  % 5
  a2 s4 d8 c |
  % 6
  b4 c d e |
  % 7
  d e a, b |
  % 8
  b8 a b c d4 c |
  % 9
  b e d b |
  % 10
  c8 d e4 d d8 c |
  % 11
  b1 |
  % 12
  
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
  s2. g'4 |
  % 2
  fis d g8 a b4 |
  % 3
  c, d g fis |
  % 4
  e d g a |
  % 5
  d,2 s4 fis |
  % 6
  g a b e, |
  % 7
  b c d b |
  % 8
  e8 fis g4 d dis |
  % 9
  e8 fis g a b4 g |
  % 10
  e d8 c d4 d |
  % 11
  g,1 |
  % 12
  
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
