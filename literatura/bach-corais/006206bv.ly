% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006206bv.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''4 a g c |
  % 2
  b8 a b4 a2 |
  % 3
  a8 b c4 d c |
  % 4
  d e c2 |
  % 5
  c4 d e8 d c4 |
  % 6
  d8 c b4 a2 |
  % 7
  a4 a g c |
  % 8
  b8 a b4 a2 |
  % 9
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 d e e |
  % 2
  e8 fis gis4 e2 |
  % 3
  e8 gis a4 d, g |
  % 4
  f e8 f16 g f2 |
  % 5
  f4 f e e |
  % 6
  d8 a' gis4 e2 |
  % 7
  dis8 e fis4 e e |
  % 8
  f8 c d4 cis2 |
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
  c'4 b8 a b a g a |
  % 2
  b c d4 c2 |
  % 3
  c8 d e f b, a g a |
  % 4
  b4 c8 g a2 |
  % 5
  a4 b8 c b4 a |
  % 6
  a e'8 d c2 |
  % 7
  fis,4 b b a |
  % 8
  a4. gis8 e2 |
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
  a'8 g f4 e4. fis8 |
  % 2
  gis a e4 a,2 |
  % 3
  a4 a' g8 f e4 |
  % 4
  d c f2 |
  % 5
  f8 e d4 gis a8 g |
  % 6
  f d e4 a,2 |
  % 7
  b8 cis dis b e d c a |
  % 8
  d e16 f e4 a,2 |
  % 9
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  a'8 g f4 e4. fis8 |
  % 2
  gis a e e, a2 |
  % 3
  a4 a' g8 f e4 |
  % 4
  d c f2 |
  % 5
  f8 e d4 gis, a8 g |
  % 6
  f d e4 a2 |
  % 7
  b8 cis dis b e d c a |
  % 8
  d e16 f e4 a,2 |
  % 9
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
