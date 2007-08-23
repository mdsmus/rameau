% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 187.mid
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
  s2. g''4 |
  % 2
  a g f g |
  % 3
  c d c c |
  % 4
  g b c d |
  % 5
  e e d d |
  % 6
  e8 d c4 a g |
  % 7
  b cis d g, |
  % 8
  c a f a |
  % 9
  g2 g |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 e |
  % 2
  f4. e4 d16 c b8 e4 c8 g' f e4 c8 d |
  % 4
  e4 f g g |
  % 5
  g4. fis8 g4 g |
  % 6
  g g4. f4 e8 |
  % 7
  g4 g a e |
  % 8
  e8 d e4. d16 e f2 e4 d2 |
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
  s2. b'4 |
  % 2
  c c a g8 c16 b |
  % 3
  c8 f b,4 g a |
  % 4
  b8 c d4 e d4. c16 b c8 a b4 b |
  % 6
  c8 b c4 c c |
  % 7
  d e f b, |
  % 8
  a a a8 ais c4 |
  % 9
  d4. c4 b4. |
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
  s2. g'4 |
  % 2
  f c d e |
  % 3
  a, g c f |
  % 4
  e d c4. b8 |
  % 5
  c4 c, g' g' |
  % 6
  c, e f c' |
  % 7
  g8 f e4 d e |
  % 8
  a,8 b c4 d a |
  % 9
  b c g2 |
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
