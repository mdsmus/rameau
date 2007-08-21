% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 038700b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  d c f g |
  % 3
  a4. gis8 a4 b |
  % 4
  c b c a |
  % 5
  b8 d4 cis8 d4 d |
  % 6
  c a f d |
  % 7
  e d cis e |
  % 8
  g8 f e4 f d |
  % 9
  e4. e8 d2 |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  a8 b c4 d e |
  % 3
  e e e g |
  % 4
  g g g4. f16 e |
  % 5
  d4 e fis g8 f |
  % 6
  e4 c c ais |
  % 7
  b8 a b4 a cis |
  % 8
  d a a ais |
  % 9
  b8 d4 cis8 a2 |
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
  s2. f4 |
  % 2
  f g a8 f c'4. b16 a b8 d c4 d |
  % 4
  e f8 d c4 c8 d16 c |
  % 5
  b8 a g a a4 d |
  % 6
  g,4. f8 f4 f |
  % 7
  g f8 e e4 a |
  % 8
  g4. g8 f4 f |
  % 9
  g8 ais a8. g16 fis2 |
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
  s2. d8 e |
  % 2
  f4. e8 d4 c8 b |
  % 3
  a4 e' a, g'8 f |
  % 4
  e c d f e c f d |
  % 5
  g f e a d,4 b |
  % 6
  c8 e f4 a,8 f ais a |
  % 7
  g4 gis a a |
  % 8
  b cis d8 c ais a |
  % 9
  g4 a d,2 |
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
