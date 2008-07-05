%% regression test for fret diagram markups


\version "2.10.0"

\paper {

  %% stretch to prevent diagrams from colliding.
  line-width = 18.0 \cm
}


<<
  \chords {s2 c c c d}
  
  \new Voice =mel {

    %% A chord for ukelele
    a'2 ^\markup
    \override #'(string-count . 4) {
      \override #'(dot-color . white) {
        \fret-diagram #"4-2-2;3-1-1;2-o;1-o;"}}

    %% C major for guitar, barred on third fret
    c' ^\markup 
    \override #'(number-type . roman-lower) {  % lower-case roman numeral fret label
      \override #'(size . 1.1) {                  % 110% of default size
	\override #'(finger-code . below-string) {  % string labels below strings
          \override #'(barre-type . straight) {       % straight barre
	    \fret-diagram-verbose #'((mute 6) (place-fret 5 3 1) (place-fret 4 5 2) (place-fret 3 5 3) (place-fret 2 5 4) (place-fret 1 3 1) (barre 5 1 3)) }}}}
    %% C major for guitar, barred on third fret
    c' ^\markup 
    \override #'(number-type . arabic) {  % lower-case roman numeral fret label
      \override #'(dot-color . white) {     % white dots
	\override #'(finger-code . in-dot) {  % string labels in dots
          \override #'(barre-type . curved) {       % straight barre
	    \fret-diagram-verbose #'((mute 6) (place-fret 5 3 1) (place-fret 4 5 2) (place-fret 3 5 3) (place-fret 2 5 4) (place-fret 1 3 1) (barre 5 1 3)) }}}}
    %% C major for guitar, barred on third fret
    c' ^\markup 
    \override #'(number-type . roman-upper) {  % upper-case roman numeral fret label
      \override #'(label-dir . -1) {            % label fret at left side of diagram
	\override #'(finger-code . in-dot) {        % string labels in dots
          \override #'(barre-type . curved) {         % curved barre
	    \fret-diagram-verbose #'((mute 6) (place-fret 5 3 1) (place-fret 4 5 2) (place-fret 3 5 3) (place-fret 2 5 4) (place-fret 1 3 1) (barre 5 1 3)) }}}}

    %% simple D chord

    d' ^\markup 
    \override #'(finger-code . below-string) {
      \override #'(dot-radius . 0.35) {
	\override #'(dot-position . 0.5) {
	  \override #'(fret-count . 5) {
	    \fret-diagram-terse #"x;x;o;2-1;3-2;2-3;" }}}}

  }
>>
