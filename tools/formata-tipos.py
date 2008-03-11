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
    file("%s%s-%s-%s.txt" % (dir_res, algoritmo, gab.nome, modo), 'a').write(l)
    if not algoritmo in algs:
        algs[algoritmo] = {}
    algoritmo = algs[algoritmo]
    if not gab.nome in algoritmo:
        algoritmo[gab.nome] = Contagem()
    algoritmo[gab.nome][modo] += 1
    gab[modo] += 1

def precisao(gab, alg, amb):
    if alg + amb == 0:
        return "0.0"
    return "%2.1f" % (100.0 * amb / float(alg + amb))

def recall(gab, alg, amb):
    if gab + amb == 0:
        return "0.0"
    return "%2.1f" % (100.0 * amb / float(gab + amb))

def f_measure(gab, alg, amb):
    if alg + amb == 0 or gab + amb == 0:
        return "0.0"
    prec = float(precisao(gab, alg, amb))
    rec = float(recall(gab, alg, amb))
    if prec == 0.0 or rec == 0.0:
        return "0.0"
    return "%2.1f" % ((2 * (prec *rec ))/(prec+rec))

tipos = map(lambda x: Tipo(*x), 
            [('maior',   r'^[A-Ga-g](b|#)?(9)?(/[A-Ga-g](#|b)?)?$'),
             ('maior7',  r'^[A-Ga-g](b|#)?7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('maior7+', r'^[A-Ga-g](b|#)?7\+(9)?(/[A-Ga-g](#|b)?)?$'),
             ('menor',   r'^[A-Ga-g](b|#)?[Mm](9)?(/[A-Ga-g](#|b)?)?$'),
             ('menor7',  r'^[A-Ga-g](b|#)?[Mm]7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('dim',     r'^[A-Ga-g](b|#)?°(9)?(/[A-Ga-g](#|b)?)?$'),
             ('dim7',    r'^[A-Ga-g](b|#)?°7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('hdim',    r'^[A-Ga-g](b|#)?(Ø|ø)7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('aug',     r'^[A-Ga-g](b|#)?\+(7\+)?(9)?(/[A-Ga-g](#|b)?)?$'),
#             ('inc',     r'^[A-Ga-g, 0, 0](b|#)?!(7)?(9)?(/[A-Ga-g](#|b)?)?$'),
             ('mel',     r'—')
             ])

linhas = file(sys.argv[1]).readlines()[3:]
algoritmos = {}


for l in linhas:
    t = Linha(l)
    for gab in tipos:
        if gab.re.match(t.resultado) and any(gab.re.match(x) for x in t.gabarito):
            preenche_contagem(t.algoritmo, algoritmos, gab, 'amb')
            break
    else:
        usado = False
        for gab in tipos:
            if gab.re.match(t.resultado) and not any(gab.re.match(x) for x in t.gabarito):
                preenche_contagem(t.algoritmo, algoritmos, gab, 'alg')
                usado = True
                break
        for gab in tipos:
            if any(gab.re.match(x) for x in t.gabarito) and not gab.re.match(t.resultado):
                preenche_contagem(t.algoritmo, algoritmos, gab, 'gab')
                usado = True
        if not usado:
            print l

print "Total:\n"
print "Tipo        | Gabarito | Algoritmo | ambos   | Precisão |  Recall  | F-measure"
for gab in sorted(tipos):
    print "%12s|%10s|%11s|%9s|%9s%%|%9s%%|%9s%%" % (gab.nome, gab['gab'], gab['alg'], gab['amb'], 
                                                    precisao(gab['gab'], gab['alg'], gab['amb']),
                                                    recall(gab['gab'], gab['alg'], gab['amb']),
                                                    f_measure(gab['gab'],gab['alg'],gab['amb']))
print

for alg in algoritmos:
    print alg
    print "Tipo        | Gabarito | Algoritmo | ambos   | Precisão |  Recall  | F-measure"
    n = 0
    prec = rec = fm = 0.0
    algo = gab = amb = 0.0
    for tipo in sorted(algoritmos[alg].keys()):
        a = algoritmos[alg][tipo]
        print "%12s|%10s|%11s|%9s|%9s%%|%9s%%|%9s%%" % (tipo, a['gab'], a['alg'], a['amb'],
                                                        precisao(a['gab'], a['alg'], a['amb']),
                                                        recall(a['gab'], a['alg'], a['amb']),
                                                        f_measure(a['gab'],a['alg'],a['amb']))
        n += 1
        prec += float(precisao(a['gab'], a['alg'], a['amb']))
        rec += float(recall(a['gab'], a['alg'], a['amb']))
        fm += float(f_measure(a['gab'], a['alg'], a['amb']))
        gab += a['gab']
        algo += a['alg']
        amb += a['amb']
    print "%12s|%10s|%11s|%9s|%9s%%|%9s%%|%9s%%" % ('avg', '', '', '',"%2.1f" % (prec/n),"%2.1f" %(rec/n),
                                                    "%2.1f" % (fm/n))
    avg = Contagem()
    avg['alg'], avg['gab'], avg['amb'] = algo, gab, amb
    algoritmos[alg]['avg'] = avg
    
    print

algs = sorted(algoritmos.keys())

def print_tabela(func, nome):
    print "Tabela de %s:"  % nome
    print "#     ",
    for alg in algs:
        print "%9s" % alg[:8], 
    print
    i = 0
    for tipo in tipos + [Tipo('avg', '')]:
        print "#", tipo.nome
        print "%4s" % i,
        for alg in algs:
            a = algoritmos[alg][tipo.nome]
            print "%9s" % func(a['gab'], a['alg'], a['amb']),
        print
        i += 10
    

print_tabela(precisao, "precisão")
print_tabela(recall, "recall")
print_tabela(f_measure, "F-measure")

