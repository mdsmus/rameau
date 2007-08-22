% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 136.mid
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
  b d b a |
  % 3
  b cis d e |
  % 4
  d8 c b4 a g8 a |
  % 5
  b4 a g a |
  % 6
  b b a d |
  % 7
  d cis d b |
  % 8
  c b a g |
  % 9
  g fis g2 |
  % 10
  
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
  g a4. g4 fis8 |
  % 3
  g4 g fis a |
  % 4
  a4. g4 fis8 e d |
  % 5
  d4 d d fis |
  % 6
  g g g fis |
  % 7
  e e fis d |
  % 8
  e d8 g4 fis e8 |
  % 9
  d4 d d2 |
  % 10
  
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
  d d d d |
  % 3
  d e a, c |
  % 4
  d d e8 b4 a g fis8 b4 d |
  % 6
  d d d a8 d |
  % 7
  b g a4 a g |
  % 8
  g8 a b4 e8 b b4 |
  % 9
  b a b2 |
  % 10
  
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
  g fis g8 b d4 |
  % 3
  g8 fis e4 d a'8 g |
  % 4
  fis4 g cis,8 dis e fis |
  % 5
  g4 d g, d' |
  % 6
  g,8 a b cis d e fis b |
  % 7
  g e a a, d4 g8 f |
  % 8
  e fis g4 cis,8 dis e4 |
  % 9
  b8 c d4 g,2 |
  % 10
  
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
