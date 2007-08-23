% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 331.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b cis d e |
  % 3
  fis2. fis4 |
  % 4
  fis e d e |
  % 5
  cis2. cis4 |
  % 6
  d e fis fis |
  % 7
  e2 fis4 fis |
  % 8
  d e fis fis |
  % 9
  e2 d4 fis |
  % 10
  a fis fis fis |
  % 11
  e2 e4 e |
  % 12
  fis e d e8 d |
  % 13
  cis2 b2. 
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
  g fis fis g |
  % 3
  cis,2. fis4 |
  % 4
  gis ais b cis |
  % 5
  ais2. ais4 |
  % 6
  b e, d a' |
  % 7
  a2 ais4 fis |
  % 8
  fis8 gis a4 a a |
  % 9
  b a a a |
  % 10
  a d cis b |
  % 11
  b2 e,4 b' |
  % 12
  cis cis fis, g |
  % 13
  g fis fis2. 
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
  e e d cis8 b |
  % 3
  ais2. a4 |
  % 4
  b cis d g |
  % 5
  fis2. fis,4 |
  % 6
  fis a a4. b8 |
  % 7
  cis2 cis4 cis |
  % 8
  b cis d d |
  % 9
  d cis d d |
  % 10
  e fis,8 d' e cis d4 |
  % 11
  d2 cis4 b |
  % 12
  fis' ais, b b |
  % 13
  e8 d cis4 dis2. 
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
  s2. b'4 |
  % 2
  e ais, b8 a g4 |
  % 3
  fis2. e4 |
  % 4
  d cis b e |
  % 5
  fis2. fis4 |
  % 6
  b, cis d8 e fis g |
  % 7
  a b a g fis gis ais fis |
  % 8
  b4 a8 g fis e d fis |
  % 9
  g e a a, d4 d' |
  % 10
  cis d ais b8 a |
  % 11
  gis fis gis e a4 g |
  % 12
  fis8 e d cis b' a g fis |
  % 13
  e cis fis fis, b2. 
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
  s2. b'''8 a |
  % 2
  g e cis fis b, fis' b16 ais b8 |
  % 3
  fis2. fis4 |
  % 4
  b8 e, d cis fis d cis b |
  % 5
  fis'2. fis8 e |
  % 6
  d b' a g fis e d d' |
  % 7
  cis d cis b ais b cis a |
  % 8
  a d, cis b a g' fis d' |
  % 9
  b g e a fis4 a4. e8 fis a cis e, d fis |
  % 11
  b a b gis a4 b |
  % 12
  ais8 b cis ais d fis, b16*5 d16 cis b ais4 b2. 
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s2. b4 |
  % 2
  e ais, b8 a g4 |
  % 3
  fis2. e'4 |
  % 4
  d cis b e |
  % 5
  fis2. fis4 |
  % 6
  b, cis d8 e fis g |
  % 7
  a b a g fis gis ais fis |
  % 8
  b4 a8 g fis e d fis |
  % 9
  g e a a, d4 d' |
  % 10
  cis d ais b8 a |
  % 11
  gis fis gis e a4 g |
  % 12
  fis8 e d cis b a g fis |
  % 13
  e cis fis4 b2. 
}

trackG = <<

  \clef bass
  
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
    \context Staff=trackG \trackG
  >>
}
