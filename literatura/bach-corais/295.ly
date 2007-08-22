% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 295.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b a b g |
  % 3
  fis8 g16 a fis4 e e8 fis |
  % 4
  g4 a b a |
  % 5
  d cis b b |
  % 6
  e fis e b |
  % 7
  cis b a a8 b |
  % 8
  cis4 dis e d |
  % 9
  cis8 d16 e cis4 b2 |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. dis'4 |
  % 2
  e e fis e |
  % 3
  e dis b b |
  % 4
  e d d d8 e |
  % 5
  fis4 fis8. e16 dis4 e |
  % 6
  e d e f |
  % 7
  fis4. f8 fis4 fis8 gis |
  % 8
  a4 a b8 cis4 b8 |
  % 9
  b ais16 gis ais4 fis2 |
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
  s2. fis4 |
  % 2
  g a8 g fis4 b |
  % 3
  c b8 a g4 g8 a |
  % 4
  b4 a g fis |
  % 5
  b4. ais8 fis4 g |
  % 6
  a a8 b cis4 d |
  % 7
  cis g8 cis cis4 d |
  % 8
  e fis e8 cis d fis |
  % 9
  g cis, fis e dis2 |
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
  s2. b4 |
  % 2
  e c' dis, e |
  % 3
  a, b e, e |
  % 4
  e' fis g d8 cis |
  % 5
  b4 fis' b, e8 d |
  % 6
  cis4 d a' gis |
  % 7
  a8 b cis4 fis, d |
  % 8
  a' gis8 fis gis ais b4 |
  % 9
  e, fis b,2 |
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
