% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 047.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 92 
  
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
  f g a a8 b |
  % 6
  c4 d8 e f4 e |
  % 7
  d cis d d |
  % 8
  e d c b |
  % 9
  a gis a d |
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
  e d cis d8 e |
  % 3
  f4 cis a f' |
  % 4
  e d e f |
  % 5
  f e8 d e4 e |
  % 6
  a g f g |
  % 7
  f8 e e4 f f |
  % 8
  e b' e, e8 d |
  % 9
  c d e4 e g |
  % 10
  g f g f |
  % 11
  f e c d |
  % 12
  d e d d |
  % 13
  d cis a2 |
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
  a a g d' |
  % 3
  d a f d' |
  % 4
  a ais c c |
  % 5
  d8 cis d4 cis c |
  % 6
  c8 a b cis d c ais4 |
  % 7
  b a a b4. a4 gis8 a4 gis |
  % 9
  a b c b |
  % 10
  c d e d |
  % 11
  d8 c ais4 a a |
  % 12
  g8 f e4 a g8 a |
  % 13
  b4 e,8 f16 g fis2 |
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
  cis d e f8 g |
  % 3
  a4 a, d d |
  % 4
  c ais a8 c f4 |
  % 5
  ais ais a a8 g |
  % 6
  f4. e8 d4 g |
  % 7
  gis a d, g |
  % 8
  c, b a e' |
  % 9
  f e a, g'8 f |
  % 10
  e4 d c d8 c |
  % 11
  ais4 c f, fis' |
  % 12
  g cis, d8 c ais a |
  % 13
  gis4 a d2 |
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
