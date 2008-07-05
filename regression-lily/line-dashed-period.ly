\header {

  texidoc = "The period of a dashed line is adjusted such that it
starts and ends on a full dash. "

}

\version "2.11.13"

\layout {
  indent = 0.0\mm
  ragged-right = ##T
}

\relative <<
  \new Staff {
    \override DynamicTextSpanner #'dash-fraction = ##f
    \setTextCresc
    c1_\< c c1\!
  }
  \new Staff {
    \override DynamicTextSpanner #'dash-period = #3
    \override DynamicTextSpanner #'dash-fraction = #0.3
    \setTextCresc
    c1^\< c c1\!
  }
>>
