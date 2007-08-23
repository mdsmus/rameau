% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 028.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  b''4 b a d |
  % 2
  cis8 b cis4 b2 |
  % 3
  b8 cis d4 e d |
  % 4
  e fis d2 |
  % 5
  d4 e fis8 e d4 |
  % 6
  e8 d cis4 b2 |
  % 7
  b4 b a d |
  % 8
  cis8 b cis4 b2 |
  % 9
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'4 e fis fis8 g16 a |
  % 2
  g8 fis e4 d2 |
  % 3
  fis4 fis8 gis a4 a8 b |
  % 4
  cis4 d8 fis, g2 |
  % 5
  a4 a a8 ais b4 |
  % 6
  cis8 b ais4 fis2 |
  % 7
  fis4 f fis8 gis a b |
  % 8
  fis b4 ais8 fis2 |
  % 9
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  d'4 cis8 b cis4 b |
  % 2
  b4. ais8 fis2 |
  % 3
  d'8 cis b4 cis d |
  % 4
  g, a8 b16 c b2 |
  % 5
  a4 e' d8 cis b4 |
  % 6
  g' cis,8 fis d2 |
  % 7
  d4 cis8 b cis4 fis |
  % 8
  e8 d cis16 d e8 dis2 |
  % 9
  
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
  b'8 a g4 fis8 e d b |
  % 2
  e d e fis b,2 |
  % 3
  b4 b' a8 g fis4 |
  % 4
  e d g2 |
  % 5
  fis8 e d cis d4 g8 fis |
  % 6
  e4 fis b,2 |
  % 7
  b'8 a gis4 fis8 e fis gis |
  % 8
  ais b fis4 b,2 |
  % 9
  
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
