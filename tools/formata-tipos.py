#!/usr/bin/env/python2.5
# coding: utf-8
"""Script para separar os tipos de erros do rameau."""

import sys,re

if len(sys.argv) != 2:
    print "Erro. Passe o arquivo com os dados como parâmetro"
    sys.exit()

def preenche_contagem(algoritmo, algs, tipo, modo):
    if not algoritmo in algs:
        algs[algoritmo] = {}
    algoritmo = algs[algoritmo]
    if not tipo in algoritmo:
        algoritmo[tipo] = [0, 0, 0]
    algoritmo[tipo][modo] += 1



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
usados = [0]*len(linhas) 
algoritmos = {}


i = 0
for l in linhas:
    for gab in tipos:
        t = map(str.strip, l.split('|'))
        if gab[1].match(t[4]) and not gab[1].match(t[5]):
            file("resultados/%s-%s-gab.txt" % (t[1], gab[0]), 'a').write(l)
            usados[i] += 1
            gab[2] += 1
            preenche_contagem(t[1], algoritmos, gab[0], 0)
        if gab[1].match(t[5]) and not gab[1].match(t[4]):
            file("resultados/%s-%s-alg.txt" % (t[1], gab[0]), 'a').write(l)
            usados[i] += 1
            gab[3] += 1
            preenche_contagem(t[1], algoritmos, gab[0], 1)
        if gab[1].match(t[5]) and gab[1].match(t[4]):
            usados[i] += 1
            gab[4] += 1
            preenche_contagem(t[1], algoritmos, gab[0], 2)
    i += 1

for i in xrange(len(usados)):
    if usados[i] == 0:
        print linhas[i]

print "Total:\n"
print "Tipo        | Gabarito | Algoritmo | ambos   "
for gab in sorted(tipos):
    print "%12s|%10s|%11s|%5s" % (gab[0], gab[2], gab[3], gab[4])
print

for alg in algoritmos:
    print alg
    print "Tipo        | Gabarito | Algoritmo | ambos   "
    for tipo in sorted(algoritmos[alg].keys()):
        a = algoritmos[alg][tipo]
        print "%12s|%10s|%11s|%5s" % (tipo, a[0], a[1], a[2])
        
