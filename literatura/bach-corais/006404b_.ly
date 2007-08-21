% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006404b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  fis d a' a |
  % 3
  b2. b4 |
  % 4
  e, e a g |
  % 5
  fis d s4 a' |
  % 6
  b b a g |
  % 7
  fis2. e4 |
  % 8
  fis gis a4. b8 |
  % 9
  gis2 a4 a |
  % 10
  a a d c |
  % 11
  b2. b4 |
  % 12
  b b e d |
  % 13
  cis2. a4 |
  % 14
  b a b cis |
  % 15
  d2. a4 |
  % 16
  a g8 fis e4 e |
  % 17
  d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  d fis8 e d4 a'8 fis |
  % 3
  g2. d4 |
  % 4
  cis8 d cis b a4 e' |
  % 5
  d a s4 d |
  % 6
  d g fis e |
  % 7
  a,2. cis4 |
  % 8
  d e e4. fis8 |
  % 9
  e2 e4 e |
  % 10
  fis8 e fis g a g a fis |
  % 11
  g2. fis4 |
  % 12
  e e e e |
  % 13
  e2. d4 |
  % 14
  g a g b8 ais |
  % 15
  b2. a8 g |
  % 16
  fis4 e8 d d4 cis |
  % 17
  a2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  a a a d |
  % 3
  d2. g,4 |
  % 4
  g4. fis8 e4 a |
  % 5
  a fis s4 a |
  % 6
  g8 a b4 cis8 d d cis |
  % 7
  d2. cis4 |
  % 8
  a b a4. d8 |
  % 9
  b2 cis4 cis |
  % 10
  d d d d |
  % 11
  d2. b8 a |
  % 12
  gis fis gis a b a b gis |
  % 13
  a2. d4 |
  % 14
  d d d e |
  % 15
  fis2. e4 |
  % 16
  d a a8 b a g |
  % 17
  fis2. 
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
  s2. cis4 |
  % 2
  d8 cis d e fis e fis d |
  % 3
  g2. g,4 |
  % 4
  a8 g a b cis b cis a |
  % 5
  d4 d s4 fis |
  % 6
  g e a a, |
  % 7
  d2. a4 |
  % 8
  d8 cis d b cis b cis d |
  % 9
  e4 e, a a |
  % 10
  d8 cis d e fis e fis d |
  % 11
  g2. dis4 |
  % 12
  e8 dis e fis gis fis gis e |
  % 13
  a2. fis4 |
  % 14
  g8 a g fis g fis g e |
  % 15
  b'2. cis,4 |
  % 16
  d8 e fis g a4 a, |
  % 17
  d2. 
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
  s2. a'8 a, |
  % 2
  d, cis d e fis e fis d |
  % 3
  g fis g a b a b g |
  % 4
  a g a b cis b cis a |
  % 5
  d cis d e fis e fis d |
  % 6
  g fis g e a g a a, |
  % 7
  d cis d e fis g a a, |
  % 8
  d cis d b cis b cis d |
  % 9
  e d e e, a4 a |
  % 10
  d8 cis d e fis e fis d |
  % 11
  g fis g a b a b dis, |
  % 12
  e dis e fis gis fis gis e |
  % 13
  a gis a b a g fis d |
  % 14
  g a g fis g fis g e |
  % 15
  b a b g d' b cis a |
  % 16
  d e fis g a4 a, |
  % 17
  d,2. 
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
