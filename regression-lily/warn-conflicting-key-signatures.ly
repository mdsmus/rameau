\version "2.10.0"
%If you specify two different key sigs at one point, a
%warning is printed.

\score { 
\context Voice <<
 { \key cis \major cis4 \key bes \major bes4 }
 { \key cis \major fis4 \key es \major g4 }  
>>
}

