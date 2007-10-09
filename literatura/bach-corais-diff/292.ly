% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 292.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a f g a |
  % 3
  f e d a' |
  % 4
  a g c a |
  % 5
  f g a a |
  % 6
  c d8 e f4 e |
  % 7
  d cis d d |
  % 8
  e d c b |
  % 9
  a b a d |
  % 10
  c b c a |
  % 11
  a g f a |
  % 12
  ais a8 g f4 g |
  % 13
  f e d2 |
  % 14
  
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
  e d d d |
  % 3
  d cis a f' |
  % 4
  f g8 f e4 f |
  % 5
  d d cis d |
  % 6
  e g a g |
  % 7
  f8 g a4 a g |
  % 8
  g fis8 gis a4 e |
  % 9
  e8 a a gis e4 d |
  % 10
  e f g f |
  % 11
  f e c d |
  % 12
  d cis d e |
  % 13
  cis8 d4 cis8 a2 |
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
  s2. d'4 |
  % 2
  a a ais a |
  % 3
  ais e f d' |
  % 4
  c c c c |
  % 5
  ais d, e f |
  % 6
  a ais c ais8 c |
  % 7
  d4 e f b, |
  % 8
  c8 b a4 d d |
  % 9
  c d c g |
  % 10
  g d' c c |
  % 11
  d g, a a |
  % 12
  g8 f e4 ais8*5 a8 g a fis2 |
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
  s2. d4 |
  % 2
  cis d ais' f |
  % 3
  g a d, d8 e |
  % 4
  f4 e a f |
  % 5
  ais ais, a d |
  % 6
  a' g f g8 a |
  % 7
  ais4 a d, g |
  % 8
  c, d8 e fis4 gis |
  % 9
  a e a, b |
  % 10
  c d e f |
  % 11
  ais, c f, fis |
  % 12
  g a ais a8 g |
  % 13
  a4 a d2 |
  % 14
  
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
  s2. f'4 |
  % 2
  e d d d |
  % 3
  d cis a f' |
  % 4
  f g8 f e4 f |
  % 5
  d g e d |
  % 6
  e g a g |
  % 7
  f8 g a4 a g |
  % 8
  g fis8 gis a4 e |
  % 9
  e8 a a gis e4 d |
  % 10
  e f g f |
  % 11
  f e c d |
  % 12
  d cis d e4. d4 cis8 a2 |
  % 14
  
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s2. d'4 |
  % 2
  a a ais a |
  % 3
  ais8 a g4 f d' |
  % 4
  c c c c |
  % 5
  ais d cis f, |
  % 6
  a ais c ais8 c |
  % 7
  d4 e f b, |
  % 8
  c8 b a4 d d |
  % 9
  c d c g |
  % 10
  g d' c c |
  % 11
  d g, a a |
  % 12
  d a d8 c ais4 |
  % 13
  ais8 a g a fis2 |
  % 14
  
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
