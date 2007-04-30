(event 'coral-2
       :key '(a maior)
       :time 4/4
       (event 'periodo-1
              (event 'frase-1
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "a4 a a f#8 g# a4 b8 a g#4 f#")
                     
                     (event 'contralto
                            :relative c'
                            :notes "c#8 d e4 a, d c# b e d#")

                     (event 'tenor
                            :relative c
                            :notes "a8 b c# d e4 a, a8 g# f#4 g#8 a b4")

                     (event 'baixo
                            :relative c,
                            :notes "a4' a8, b c#4 d8 e f# e d#4 e b"))

              (event 'frase-2
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "f#4 g# a b e8, f# g# a f#4 e")
                     
                     (event 'contralto
                            :relative c'
                            :notes "d#4 e f# f#8 d# e4 e8 f# d#4 b")

                     (event 'tenor
                            :relative c
                            :notes "b4 b d# g#8, a b c# b4 b8 a g#")

                     (event 'baixo
                            :relative c,
                            :notes "b8' a g# a g f# e f# g# a b4 b, e"))

              (event 'frase-3
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "b4 c# c# a8 b c#4 d c# b")
                     
                     (event 'contralto
                            :relative c'
                            :notes "g#4 a c#, f#8 g# a#4 b e8, f# g#4")

                     (event 'tenor
                            :relative c
                            :notes "e4 e8 f# g4 c#8, d e4 f#8 g# a4 e")

                     (event 'baixo
                            :relative c,
                            :notes "e4 a8 g# f# e# f# e d c# b4 c#8 d e4"))

              (event 'frase-4
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "a4 b c# b a a g# a")
                     
                     (event 'contralto
                            :relative c'
                            :notes "f#4 e8 d c# d# e d c4 f# e e")

                     (event 'tenor
                            :relative c
                            :notes "c#4 b e8, f# g#4 a b8 c# d4 c#")

                     (event 'baixo
                            :relative c,
                            :notes "f#4 g# a e f#8 e d#4 e a,"))
              
              