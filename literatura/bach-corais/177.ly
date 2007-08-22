% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 177.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. cis''4 |
  % 2
  cis8 d e4 cis a |
  % 3
  b cis d cis |
  % 4
  b a a4. b8 |
  % 5
  cis4 cis b8 a b4 |
  % 6
  a2. cis4 |
  % 7
  b cis a fis |
  % 8
  gis a b cis |
  % 9
  a a a4. b8 |
  % 10
  cis4 cis b8 a b4 |
  % 11
  a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  a b a a |
  % 3
  g8 fis e4 fis e |
  % 4
  e8 d cis4 fis2 |
  % 5
  e4 e e4. d8 |
  % 6
  cis2. a'4 |
  % 7
  gis gis fis8 e dis4 |
  % 8
  e4. dis8 e4 f |
  % 9
  cis fis e fis8 gis |
  % 10
  a4 e e4. d8 |
  % 11
  cis2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. e'4 |
  % 2
  e e e e8 d |
  % 3
  d4 a a a |
  % 4
  gis a d2 |
  % 5
  cis8 b a4 a gis |
  % 6
  e2. e'4 |
  % 7
  e8 d cis4 cis b |
  % 8
  b a gis gis |
  % 9
  a d cis8 d cis b |
  % 10
  a4 a a gis |
  % 11
  e2. 
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
  s2. a4 |
  % 2
  a' gis a fis |
  % 3
  g a d, a |
  % 4
  e' fis8 e d e fis gis |
  % 5
  a4 cis,8 d e4 e |
  % 6
  a,2. a4 |
  % 7
  e' f fis b8 a |
  % 8
  gis4 fis e cis |
  % 9
  fis8 e fis gis a b a gis |
  % 10
  fis4 cis8 d e4 e |
  % 11
  a,2. 
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
