% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 048.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  <a'' e c a >4 <b e, b gis >4 <c e, a, >4 <a, c' e, a,, >4*0/1024 |
  % 2
  <c' e, a, >4 <d g, b, g >4 <e g, c, >4 <c, e' g, c,, >4*0/1024 |
  % 3
  c8 <d b >8 <c a >8 <b g >8 <c' a, fis >8 <b b, gis >8 <b c, >8 
  <a e >8 |
  % 4
  <a f d, >4 e8 <a d, >8 <a e cis a, >2 |
  % 5
  <cis, a >8 <d b >8 <e cis >8 a, d c ais a |
  % 6
  g e a' g g e <d' fis, a, d, >4 |
  % 7
  <b, g >8 <c a >8 <d b >8 g, c b a g |
  % 8
  f d g' f f d <c' e, g, c, >4 |
  % 9
  <c f, a, f >4 e,,8 d gis e d'' c |
  % 10
  <b fis a, dis, >4 e,8 d d b <a' cis, e, a, >4 |
  % 11
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


\score {
  <<
    \context Staff=trackB \trackB
  >>
}
