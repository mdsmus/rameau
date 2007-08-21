% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 042300b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d''4 c ais a |
  % 2
  ais a8 g fis4 d |
  % 3
  d' d dis c |
  % 4
  d c8 ais a2 |
  % 5
  d4 c ais a |
  % 6
  ais a8 g fis4 d |
  % 7
  d' d dis c |
  % 8
  d c ais2 |
  % 9
  d4 dis f d |
  % 10
  dis d d8 c c4 |
  % 11
  c d dis d |
  % 12
  c4. ais8 a4 f |
  % 13
  d' a ais a |
  % 14
  ais c d2 |
  % 15
  d4 d c ais |
  % 16
  a4. g8 g2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''8 a16 ais a4. g4 fis8 |
  % 2
  d g16 f f4 d a |
  % 3
  ais8 c d4 g, g' |
  % 4
  a4. g8 fis2 |
  % 5
  fis4 g8 a4 g fis8 |
  % 6
  g f e4 d a |
  % 7
  ais8 d f4 g4. f8 |
  % 8
  f4 f8. dis16 d2 |
  % 9
  f4 g f g8 f |
  % 10
  dis c f4 f f |
  % 11
  f f g8 fis g4 |
  % 12
  g8 fis g4 f c |
  % 13
  a'8 g a4. g4 fis8 |
  % 14
  g4 g fis2 |
  % 15
  g4 g4. fis8 g4. fis16 e fis4 d2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'8 c16 d dis8 d d16*7 c16 |
  % 2
  ais8 d c ais a4 fis |
  % 3
  g g'8 f dis16 d c4 ais8 |
  % 4
  a d d4 d2 |
  % 5
  a4 g8 d' d4 d |
  % 6
  d e8 a, a4 fis |
  % 7
  f8 ais d c ais4 c4. ais4 a8 f2 |
  % 9
  d'8 c ais4. a8 ais4. a8 ais4. a8 a4 |
  % 11
  a ais4. a8 ais4 |
  % 12
  c c c a |
  % 13
  a d d d |
  % 14
  d dis a2 |
  % 15
  ais4 d dis8 d e4 |
  % 16
  a,8 d d8. c16 ais2 |
  % 17
  
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
  g'4. fis8 g4 d |
  % 2
  g, c d d, |
  % 3
  g8 a ais g c d dis4 |
  % 4
  fis, g d'2 |
  % 5
  d4 e8 fis g4 d |
  % 6
  g cis, d d, |
  % 7
  ais' ais'8 a g4 a |
  % 8
  ais f ais,2 |
  % 9
  ais'8 a g4 d g |
  % 10
  c, d8 dis f4 f, |
  % 11
  f'8 dis d4 c g'8 f |
  % 12
  dis4 e f f, |
  % 13
  fis'8 e fis d g4 d |
  % 14
  g8 f dis4 d2 |
  % 15
  g4 ais, c cis |
  % 16
  d d, g2 |
  % 17
  
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
