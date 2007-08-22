% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 213.mid
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
  a''4 d c ais8 a |
  % 2
  ais4 a g a8 ais |
  % 3
  g2 f |
  % 4
  a8 ais c4 b4. cis8 |
  % 5
  d4 c8 d e4 d8 c |
  % 6
  b2 a |
  % 7
  s4 a g e |
  % 8
  f2 e |
  % 9
  d4 e f g |
  % 10
  a b cis d |
  % 11
  d cis d2 |
  % 12
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 g g f4. e8 f4. e8 f4 |
  % 3
  f e c2 |
  % 4
  f4 g8 a g4 g |
  % 5
  a8 b a4 a a |
  % 6
  a gis e2 |
  % 7
  s4 cis d e |
  % 8
  e d cis2 |
  % 9
  d4 a d c |
  % 10
  c f e d8 e |
  % 11
  f e16 d e4 fis2 |
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
  d'4 d e d |
  % 2
  d8 ais c4 c c |
  % 3
  d8 ais g c a2 |
  % 4
  c8 d e d d4 e |
  % 5
  d8 b e4 e f |
  % 6
  b,8 e4 d8 cis2 |
  % 7
  s4 e, d a' |
  % 8
  a2 a |
  % 9
  a4 a a8 ais a g |
  % 10
  f a g f g4 a8 ais |
  % 11
  a4 a a2 |
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
  d4 c8 ais a4 d |
  % 2
  g, a8 ais c4 f |
  % 3
  ais, c f,2 |
  % 4
  f'4 e8 fis g f e4 |
  % 5
  fis8 gis a4 c, d |
  % 6
  e e, a2 |
  % 7
  s4 a b cis |
  % 8
  d d, a'2 |
  % 9
  f'4 cis d e |
  % 10
  f e8 d e4 f8 g |
  % 11
  a4 a, d2 |
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
