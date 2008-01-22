#!/usr/bin/env/python2.5
# coding: utf-8
"""Script para separar os tipos de erros do rameau."""

import sys,re,os

if len(sys.argv) != 2:
    print "Erro. Passe o arquivo com os dados como parâmetro"
    sys.exit()

pass

tipos = [('maior',   re.compile(r'^[A-Ga-g](b|#)?(/[A-Ga-g](#|b)?)?$')),
         ('maior7',  re.compile(r'^[A-Ga-g](b|#)?7(/[A-Ga-g](#|b)?)?$')),
         ('maior7+', re.compile(r'^[A-Ga-g](b|#)?7\+(/[A-Ga-g](#|b)?)?$')),
         ('menor',   re.compile(r'^[A-Ga-g](b|#)?[Mm](/[A-Ga-g](#|b)?)?$')),
         ('menor7',  re.compile(r'^[A-Ga-g](b|#)?[Mm]7(/[A-Ga-g](#|b)?)?$')),
         ('dim',     re.compile(r'^[A-Ga-g](b|#)?°(/[A-Ga-g](#|b)?)?$')),
         ('dim7',    re.compile(r'^[A-Ga-g](b|#)?°7(/[A-Ga-g](#|b)?)?$')),
         ('hdim',    re.compile(r'^[A-Ga-g](b|#)?(Ø|ø)7(/[A-Ga-g](#|b)?)?$')),
         ('aug',     re.compile(r'^[A-Ga-g](b|#)?\+(/[A-Ga-g](#|b)?)?$')),
         ('mel',     re.compile(r'—')),
         ('inc',     re.compile(r'^[A-Ga-g](b|#)?!(/[A-Ga-g](#|b)?)?$'))
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
        if gab[1].match(t[5]) and not gab[1].match(t[4]):
            file("resultados/%s-%s-alg.txt" % (t[1], gab[0]), 'a').write(l)
            usados[i] += 1
        if gab[1].match(t[5]) and gab[1].match(t[4]):
            usados[i] += 1
    i += 1

for i in xrange(len(usados)):
    if usados[i] == 0:
        print linhas[i]

