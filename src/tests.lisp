(parse-file "/tmp/foo.ly")

(parse-string "{c d e f}")

(parse-string "<< { c d e f } >>")

(parse-string "<<
{ c d e f }
{ c d e f }
>>")

(parse-string "<<
{ c d e f }
{ c d e f }
{ c d e f }
>>")

(parse-string "<<
new Staff { c d e f }
new Staff { c d e f }
>>")

(parse-string "new Staff { c d e f }")

