% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000306b_.mid
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
  s2. a''4 |
  % 2
  a a fis8 gis a4 |
  % 3
  b8 a gis4 fis fis |
  % 4
  gis a b e,8 fis |
  % 5
  gis a fis4 e b' |
  % 6
  cis cis a8 b cis4 |
  % 7
  d cis b a |
  % 8
  b cis b a |
  % 9
  a gis a 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. cis'8 d |
  % 2
  e4 a, d cis |
  % 3
  b e dis dis |
  % 4
  e fis fis8 dis e4 |
  % 5
  e8 fis dis4 b gis' |
  % 6
  a cis, fis8 gis ais4 |
  % 7
  b e,8 fis gis4 fis |
  % 8
  e8 d cis dis e d cis4 |
  % 9
  fis e e 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 b |
  % 2
  cis d e4 a, a8 gis |
  % 3
  fis4 gis8 a b4 b |
  % 4
  b dis gis,8 a b cis |
  % 5
  b4 b8 a gis4 e' |
  % 6
  e8 fis gis4 cis,8 d e4 |
  % 7
  fis8 gis a4 e cis |
  % 8
  b e,8 fis gis4 a |
  % 9
  b8 cis d4 cis 
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
  s2. a'4 |
  % 2
  a,8 b cis4 d8 e fis e |
  % 3
  dis4 e b b'8 a |
  % 4
  gis a gis fis e fis gis a |
  % 5
  b4 b, e e |
  % 6
  a8 gis fis f fis e d cis |
  % 7
  b4 cis8 d e4 fis |
  % 8
  gis a e fis8 e |
  % 9
  dis4 e a, 
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
