
\header {

  texidoc = "the @code{endSpanners} music function inserts 
end span events at the end of a note."
  
}

\version "2.11.15"
\paper{
  ragged-right = ##T
}
\relative
<< {   c'4 c c c }
   \\
   {
     \override TextSpanner #'bound-details #'left #'text = "x" 
     \endSpanners c,2\<\startTextSpan c2

   }
 >>
   
