% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 232.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  f g a d |
  % 3
  c4. b8 a b c4 |
  % 4
  b2 a4 d |
  % 5
  d d cis e |
  % 6
  d a ais a8 g |
  % 7
  g2 f4 f |
  % 8
  e e d a' |
  % 9
  c c g8 a ais4 |
  % 10
  a a c d |
  % 11
  a c a g8 f |
  % 12
  e4. d8 d2 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  d4. e8 f4 a |
  % 3
  a gis a8 gis a4 |
  % 4
  a8 gis16 fis gis4 e a |
  % 5
  a8 g b4 a a8 g |
  % 6
  f4 f g f |
  % 7
  f8 e16 d e4 c d |
  % 8
  d cis a f'4. e8 f4 e f8 g |
  % 10
  f4 f f f |
  % 11
  f g4. f16 e d4 |
  % 12
  d cis a2 |
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
  s2. f4 |
  % 2
  a ais d f |
  % 3
  e e8. d16 c8 d e f |
  % 4
  b, e4 d8 cis4 d |
  % 5
  d8 e f4 e a, |
  % 6
  a d4. c8 c4 |
  % 7
  d8 ais g c16 ais a4 ais |
  % 8
  ais a8 g f4 d' |
  % 9
  c c c8 a d c |
  % 10
  c4 d c4. ais8 |
  % 11
  c4 c c ais4. g8 e a16 g fis2 |
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
  d g, d d' |
  % 3
  a' e f c8 d |
  % 4
  e4 e, a f' |
  % 5
  ais a8 gis a4 cis, |
  % 6
  d8 e f4. e8 f4 |
  % 7
  ais, c f, ais |
  % 8
  g a d, d' |
  % 9
  a8 g a ais c4 d8 e |
  % 10
  f4 d a ais |
  % 11
  f e f ais |
  % 12
  g a d,2 |
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
