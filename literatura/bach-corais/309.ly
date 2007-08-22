% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 309.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key aes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. dis''4 |
  % 2
  f dis8 cis c cis dis4 |
  % 3
  cis8 c cis4 c ais |
  % 4
  c cis dis cis8 c |
  % 5
  ais gis ais4 gis dis' |
  % 6
  f dis8 cis c cis dis4 |
  % 7
  cis8 c cis4 c ais |
  % 8
  c cis dis cis8 c |
  % 9
  ais gis ais4 gis gis |
  % 10
  ais c cis8 c ais4 |
  % 11
  c ais gis gis8 ais |
  % 12
  c4 cis dis f |
  % 13
  c d dis c8 cis |
  % 14
  dis4 f dis8 cis c4 |
  % 15
  cis2 c4 f |
  % 16
  f f ais, dis |
  % 17
  cis c ais cis |
  % 18
  c ais gis ais8 gis |
  % 19
  fis4 f dis dis |
  % 20
  gis ais c4. cis8 |
  % 21
  dis4 cis8 c ais4 c8 cis |
  % 22
  ais2 gis4 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  gis g gis g |
  % 3
  f8 gis4 g8 gis4 ais |
  % 4
  gis gis gis gis |
  % 5
  gis g dis gis |
  % 6
  gis g gis g |
  % 7
  f8 gis4 g8 gis4 ais |
  % 8
  gis gis gis gis |
  % 9
  gis g dis dis |
  % 10
  dis8 f g4 f f8 dis |
  % 11
  dis4 cis c f |
  % 12
  dis f fis f8 g |
  % 13
  gis g gis ais g4 dis |
  % 14
  gis gis ais c |
  % 15
  c8 a ais4 a c |
  % 16
  ais f8 cis dis f fis4 |
  % 17
  f dis cis ais' |
  % 18
  dis,8 f fis4 f8 dis f4. dis4 d8 dis4 dis8 cis |
  % 20
  c ais gis fis gis4 gis' |
  % 21
  g gis gis gis2 g4 dis 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  cis8 c ais4 f' ais,8 c |
  % 3
  cis f dis4 dis dis |
  % 4
  dis gis,8 ais c gis f'4 |
  % 5
  ais,8 c cis4 c c |
  % 6
  cis8 c ais4 f' ais,8 c |
  % 7
  cis f dis4 dis dis |
  % 8
  dis gis,8 ais c gis f'4 |
  % 9
  ais,8 c cis4 c c |
  % 10
  ais dis gis, ais4. gis4 g8 gis4 gis |
  % 12
  gis gis gis gis |
  % 13
  gis8 ais16 ais ais4 ais gis |
  % 14
  gis8 dis' cis c ais4 f' |
  % 15
  f2 f4 f8 dis |
  % 16
  cis c ais4. a8 ais c |
  % 17
  a ais4 a8 ais4 f8 g |
  % 18
  gis4 dis'8 cis b4 ais |
  % 19
  ais gis g g |
  % 20
  gis dis' dis f |
  % 21
  dis2 f8 dis cis4 |
  % 22
  dis8 f dis cis c4 
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
  s2. gis'4 |
  % 2
  cis, dis f g8 gis |
  % 3
  ais4 dis, gis g |
  % 4
  gis8 g f4 c cis |
  % 5
  dis2 gis,4 gis' |
  % 6
  cis, dis f g8 gis |
  % 7
  ais4 dis, gis g8 s8 |
  % 8
  gis g f4 c cis |
  % 9
  dis2 gis,4 gis' |
  % 10
  g f8 dis f4 g |
  % 11
  gis dis gis, cis |
  % 12
  gis'8 fis f dis cis c cis dis |
  % 13
  f4 ais, dis gis8 ais |
  % 14
  c4 cis g a |
  % 15
  ais ais, f' a, |
  % 16
  ais8 c cis ais fis'4 f8 dis |
  % 17
  f4 f, ais ais |
  % 18
  c8 d dis2 d4 |
  % 19
  dis ais dis c |
  % 20
  f dis gis8 g f4 |
  % 21
  c8 ais gis4 cis8 c ais4 |
  % 22
  dis8 cis dis4 gis, 
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
