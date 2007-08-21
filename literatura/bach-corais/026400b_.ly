% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 026400b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  g a b a |
  % 3
  g2 s4 a |
  % 4
  b c b a |
  % 5
  g2 s4 b |
  % 6
  d d c b |
  % 7
  a2 s4 b |
  % 8
  g c b a |
  % 9
  g2 a4 a |
  % 10
  b c b a |
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
  s2. b'4 |
  % 2
  e8 g4 fis8 g fis16 e fis4 |
  % 3
  d2 s4 fis |
  % 4
  g g8 a4 g fis8 |
  % 5
  d2 s4 g |
  % 6
  g g4. fis8 g2 fis4 s4 fis4. e8 g a4 g fis8 |
  % 9
  g4. fis16 e fis4 fis |
  % 10
  g g g4. fis8 |
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
  s2. g'4 |
  % 2
  b d d d8 c |
  % 3
  b2 s4 d |
  % 4
  d e d4. d16 c |
  % 5
  b2 s4 d |
  % 6
  d b c d |
  % 7
  d2 s4 b |
  % 8
  b e8 d d4. d16 c |
  % 9
  b8 a b cis d4 d |
  % 10
  d c8 e d4 d8. c16 |
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
  e d g d |
  % 3
  g,2 s4 d' |
  % 4
  g c, d d, |
  % 5
  g2 s4 g |
  % 6
  b g a b8 c |
  % 7
  d2 s4 dis |
  % 8
  e4. fis8 g4 d |
  % 9
  e2 d4 d |
  % 10
  g e8 c d4 d, |
  % 11
  g1 |
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
