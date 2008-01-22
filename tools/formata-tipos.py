#!/usr/bin/env/python2.5
# coding: utf-8
"""Script para separar os tipos de erros do rameau."""

import sys,re,os

if len(sys.argv) != 2:
    print "Erro. Passe o arquivo com os dados como parâmetro"
    sys.exit()

pass

tipos = [['maior',   re.compile(r'^[A-Ga-g, 0, 0](b|#)?(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['maior7',  re.compile(r'^[A-Ga-g, 0, 0](b|#)?7(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['maior7+', re.compile(r'^[A-Ga-g, 0, 0](b|#)?7\+(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['menor',   re.compile(r'^[A-Ga-g, 0, 0](b|#)?[Mm, 0, 0](/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['menor7',  re.compile(r'^[A-Ga-g, 0, 0](b|#)?[Mm, 0, 0]7(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['dim',     re.compile(r'^[A-Ga-g, 0, 0](b|#)?°(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['dim7',    re.compile(r'^[A-Ga-g, 0, 0](b|#)?°7(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['hdim',    re.compile(r'^[A-Ga-g, 0, 0](b|#)?(Ø|ø)7(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['aug',     re.compile(r'^[A-Ga-g, 0, 0](b|#)?\+(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0],
         ['mel',     re.compile(r'—'), 0, 0, 0],
         ['inc',     re.compile(r'^[A-Ga-g, 0, 0](b|#)?!(/[A-Ga-g, 0, 0](#|b)?)?$'), 0, 0, 0]
         ]

linhas = file(sys.argv[1]).readlines()[3:]
usados = [0]*len(linhas) #

os.system("if [ -d resultados ] ; then true; else mkdir resultados ; fi")

i = 0
for l in linhas:
    for gab in tipos:
        t = map(str.strip, l.split('|'))
        if gab[1].match(t[4]) and not gab[1].match(t[5]):
            file("resultados/%s-%s-gab.txt" % (t[1], gab[0]), 'a').write(l)
            usados[i] += 1
            gab[2] += 1
        if gab[1].match(t[5]) and not gab[1].match(t[4]):
            file("resultados/%s-%s-alg.txt" % (t[1], gab[0]), 'a').write(l)
            usados[i] += 1
            gab[3] += 1
        if gab[1].match(t[5]) and gab[1].match(t[4]):
            usados[i] += 1
            gab[4] += 1
    i += 1

for i in xrange(len(usados)):
    if usados[i] == 0:
        print linhas[i]

print     "Tipo        | Gabarito | Algoritmo | ambos   "
for gab in tipos:
    print "%12s|%10s|%11s|%5s" % (gab[0], gab[2], gab[3], gab[4])
