% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004803b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. ais''4 |
  % 2
  a g f f |
  % 3
  g a ais c |
  % 4
  ais a g a8 ais |
  % 5
  g2 f4 ais |
  % 6
  a ais c c |
  % 7
  d8 c ais4 c f, |
  % 8
  g a ais8 c d4 |
  % 9
  c ais c2 |
  % 10
  ais1 |
  % 11
  ais |
  % 12
  
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
  f e c c |
  % 3
  f fis g a |
  % 4
  g f c c |
  % 5
  c2 c4 d |
  % 6
  dis f f f |
  % 7
  f8 dis cis4 c f |
  % 8
  f e d4. g8 |
  % 9
  a4 ais2 gis fis f8 dis |
  % 11
  f1 |
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
  s2. d'4 |
  % 2
  c c8 ais a4 a |
  % 3
  ais dis d d |
  % 4
  d d e f |
  % 5
  f8 e16 d e4 a, f |
  % 6
  c' d a a |
  % 7
  gis g dis' dis |
  % 8
  d g f f |
  % 9
  dis d g f2. dis d8 c d2 |
  % 12
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. ais4 |
  % 2
  f' c f, dis' |
  % 3
  cis c g' fis |
  % 4
  g d'8 c ais a g f |
  % 5
  c'4 c, f d |
  % 6
  c ais f' f |
  % 7
  ais, dis gis, a |
  % 8
  b cis d4. e8 |
  % 9
  fis4 g8 f e4 f8 dis |
  % 10
  d4 dis8 f fis gis ais4 |
  % 11
  ais,1 |
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
