#!/usr/bin/env/python2.5
# coding: utf-8
"""Script para separar os tipos de erros do rameau."""

import sys,re

if len(sys.argv) != 3:
    print "Erro. Passe o arquivo com os dados e o diretório de resultados como parâmetro"
    sys.exit()

dir_res = sys.argv[2]

if sys.version < '2.5':
    def any(iter):
        for i in iter:
            if i:
                return True
        return False

def quebra(linha):
    linha = map(str.strip, linha.split('|'))
    linha[4] = linha[4].replace('(','').replace(')','').split()
    return linha

class Linha(object):
    def __init__(self, linha):
        self.coral, self.algoritmo, self.segmento, self.notas, self.gabarito, self.resultado = quebra(linha)

class Contagem(dict):
    def __init__(self):
        super(Contagem, self).__init__()
        self['gab'] = self['alg'] = self['amb'] = 0

class Tipo(Contagem):
    def __init__(self, nome, regexp):
        super(Tipo, self).__init__()
        self.nome = nome
        self.re = re.compile(regexp)

def preenche_contagem(algoritmo, algs, gab, modo):
    if modo != 'amb':
        file("%s%s-%s-%s.txt" % (dir_res, algoritmo, gab.nome, modo), 'a').write(l)
    if not algoritmo in algs:
        algs[algoritmo] = {}
    algoritmo = algs[algoritmo]
    if not gab.nome in algoritmo:
        algoritmo[gab.nome] = Contagem()
    algoritmo[gab.nome][modo] += 1
    gab[modo] += 1


tipos = map(lambda x: Tipo(*x), 
            [('maior',   r'^[A-Ga-g, 0, 0](b|#)?(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('maior7',  r'^[A-Ga-g, 0, 0](b|#)?7(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('maior7+', r'^[A-Ga-g, 0, 0](b|#)?7\+(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('menor',   r'^[A-Ga-g, 0, 0](b|#)?[Mm, 0, 0](/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('menor7',  r'^[A-Ga-g, 0, 0](b|#)?[Mm, 0, 0]7(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('dim',     r'^[A-Ga-g, 0, 0](b|#)?°(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('dim7',    r'^[A-Ga-g, 0, 0](b|#)?°7(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('hdim',    r'^[A-Ga-g, 0, 0](b|#)?(Ø|ø)7(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('aug',     r'^[A-Ga-g, 0, 0](b|#)?\+(7\+)?(/[A-Ga-g, 0, 0](#|b)?)?$'),
             ('mel',     r'—'),
             ('inc',     r'^[A-Ga-g, 0, 0](b|#)?!(7)?(/[A-Ga-g, 0, 0](#|b)?)?$')
             ])

linhas = file(sys.argv[1]).readlines()[3:]
algoritmos = {}


for l in linhas:
    usado = False
    t = Linha(l)
    for gab in tipos:
        if any(gab.re.match(x) for x in t.gabarito) and not gab.re.match(t.resultado):
            usado = True
            preenche_contagem(t.algoritmo, algoritmos, gab, 'gab')
        if gab.re.match(t.resultado) and not any(gab.re.match(x) for x in t.gabarito):
            usado = True
            preenche_contagem(t.algoritmo, algoritmos, gab, 'alg')
        if gab.re.match(t.resultado) and any(gab.re.match(x) for x in t.gabarito):
            usado = True
            preenche_contagem(t.algoritmo, algoritmos, gab, 'amb')
    if not usado:
        print l

print "Total:\n"
print "Tipo        | Gabarito | Algoritmo | ambos   "
for gab in sorted(tipos):
    print "%12s|%10s|%11s|%5s" % (gab.nome, gab['gab'], gab['alg'], gab['amb'])
print

for alg in algoritmos:
    print alg
    print "Tipo        | Gabarito | Algoritmo | ambos   "
    for tipo in sorted(algoritmos[alg].keys()):
        a = algoritmos[alg][tipo]
        print "%12s|%10s|%11s|%5s" % (tipo, a['gab'], a['alg'], a['amb'])
    print
        
