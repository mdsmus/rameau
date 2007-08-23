% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 314.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b a8 g fis4 b |
  % 3
  a8 g fis4 g b |
  % 4
  b a8 g fis4 b |
  % 5
  a8 g fis4 g b |
  % 6
  cis dis e b8 cis |
  % 7
  d4 cis b cis |
  % 8
  d cis b b |
  % 9
  a8 g fis4 g a |
  % 10
  a b a8 g fis4 |
  % 11
  g g fis cis' |
  % 12
  d cis b fis |
  % 13
  b b ais2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  g e d g |
  % 3
  fis fis e gis |
  % 4
  e8*5 d8 d4 |
  % 5
  c c8 b b4 g' |
  % 6
  g fis e e |
  % 7
  fis fis fis fis |
  % 8
  fis fis4. d8 g fis |
  % 9
  e4 d8 c b4 e |
  % 10
  d d cis dis |
  % 11
  e e4. d8 fis4 |
  % 12
  fis g fis fis |
  % 13
  fis f fis2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. dis'4 |
  % 2
  e a, a d |
  % 3
  d c8 b b4 e |
  % 4
  e a, a f |
  % 5
  e fis e b' |
  % 6
  a b b b |
  % 7
  b ais8 e' d4 cis |
  % 8
  c8 b4 a8 b4 b |
  % 9
  c8 b a4 g g |
  % 10
  fis g8 fis e4 b' |
  % 11
  b b b cis |
  % 12
  b ais b8 cis d cis |
  % 13
  b4 cis cis2 |
  % 14
  
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
  s2. b'8 a |
  % 2
  g e cis4 d b8 g |
  % 3
  d'4 dis e e8 d |
  % 4
  c4 cis d gis, |
  % 5
  a dis, e e' |
  % 6
  a, a' gis g |
  % 7
  fis8 e fis4 b, ais |
  % 8
  b fis' g8 fis e d |
  % 9
  c4 d g, cis |
  % 10
  d g, a b |
  % 11
  e,8 fis g a b4 ais |
  % 12
  b e d8 cis b a |
  % 13
  gis4 cis fis,2 |
  % 14
  
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
