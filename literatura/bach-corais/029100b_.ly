% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 029100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f'4 |
  % 2
  f e f2 |
  % 3
  a4 c ais a |
  % 4
  g g g c, |
  % 5
  d8 e f4 f e |
  % 6
  f2 s4 f8 g |
  % 7
  a4 g a ais |
  % 8
  c2 g4 g |
  % 9
  g g g g |
  % 10
  a2 a4 f |
  % 11
  e d d cis |
  % 12
  d1 |
  % 13
  
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
  c c c2 |
  % 3
  f4 g f8 g g f4 e8 d4 c c |
  % 5
  ais c8 d c4 c |
  % 6
  c2 s4 c |
  % 7
  f g f f |
  % 8
  f2 e4 g8 f |
  % 9
  e4 d e e |
  % 10
  e8 d e cis d4 d8 c |
  % 11
  ais4 a ais a |
  % 12
  a1 |
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
  s2. a'4 |
  % 2
  a g16 a ais8 a2 |
  % 3
  c4 c d8 c c4 |
  % 4
  c g8 f4 e8 f4 |
  % 5
  f8 g a4 g8 a ais4 |
  % 6
  a2 s4 a8 ais |
  % 7
  c4 c c d |
  % 8
  c2 c4 d |
  % 9
  c b c c |
  % 10
  cis8 b a g f4 a |
  % 11
  g4. f8 e4. g8 |
  % 12
  fis1 |
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
  s2. d4 |
  % 2
  a8 ais c4 f,2 |
  % 3
  f'4. e8 d e f4 |
  % 4
  c b c a |
  % 5
  ais a8 ais c4 c, |
  % 6
  f2 s4 f |
  % 7
  f'4. e8 f e d4 |
  % 8
  a8 g a ais c4 b |
  % 9
  c8 e g f e d c ais |
  % 10
  a b cis a d4 d4. cis8 d f, g e a4 |
  % 12
  d,1 |
  % 13
  
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
