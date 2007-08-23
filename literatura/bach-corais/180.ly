% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 180.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  c a ais a |
  % 3
  g g f a |
  % 4
  b c d c |
  % 5
  b2 a4 e |
  % 6
  f f g g |
  % 7
  a a f d |
  % 8
  e f g f |
  % 9
  e2 d |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  g g8 f f e f4 |
  % 3
  f f8 e c4 a' |
  % 4
  a8 gis a4 a8 gis a4 |
  % 5
  a gis e cis |
  % 6
  d d d8 b cis d |
  % 7
  e d e cis d4 a8 b |
  % 8
  c4 c cis d |
  % 9
  d cis a2 |
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
  s2. d'4 |
  % 2
  c c ais c |
  % 3
  d c8. ais16 a4 c |
  % 4
  f e d e |
  % 5
  f e8 d cis4 a |
  % 6
  a a g ais |
  % 7
  a a a f |
  % 8
  g a8 f ais g a4 |
  % 9
  a8 e a g fis2 |
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
  s2. d4 |
  % 2
  e f g a |
  % 3
  ais c f, f8 e |
  % 4
  d4 c b a |
  % 5
  d e a, a |
  % 6
  d,8 d'4 c8 b e4 d8 |
  % 7
  cis b cis a d4 d |
  % 8
  c8 ais a4 e f8 g |
  % 9
  a2 d |
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
