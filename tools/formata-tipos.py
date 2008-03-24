#!/usr/bin/env/python2.5
# coding: utf-8
"""Script para separar os tipos de erros do rameau."""

import sys,re,os

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
    try:
        linha = map(str.strip, linha.split('|'))
        linha[4] = linha[4].replace('(','').replace(')','').split()
    except IndexError:
        print "Erro: linha errada"
        print "linha:", linha
        sys.exit(-1)
    return linha

class Linha(object):
    def __init__(self, linha):
        self.coral, self.algoritmo, self.segmento, self.notas, self.gabarito, self.resultado = quebra(linha)

class Contagem(dict):
    def __init__(self, valores=()):
        super(Contagem, self).__init__(valores)
        self['gab'] = self['alg'] = self['amb'] = 0

class Tipo(Contagem):
    def __init__(self, nome, regexp):
        super(Tipo, self).__init__()
        self.nome = nome
        self.re = re.compile(regexp)

class Algoritmo(object):
    def __init__(self, nome, tipos):
        self.nome = nome
        self.contagem = dict([(t.nome, Contagem()) for t in tipos])
        self.ida = dict([(t.nome, dict([(i.nome, 0) for i in tipos])) for t in tipos])
        self.vinda = dict([(t.nome, dict([(i.nome, 0) for i in tipos])) for t in tipos])


def preenche_contagem(algoritmo, algs, gab, modo, gabo, res):
    file("%s%s-%s-%s.txt" % (dir_res, algoritmo, gab.nome, tipo(res)), 'a').write(l)
    assert algoritmo in algs, "Algoritmo %s não encontrado" % algoritmo
    algoritmo = algs[algoritmo]
    contagem = algoritmo.contagem
    assert gab.nome in contagem
    contagem[gab.nome][modo] += 1
    gab[modo] += 1
    try:
        for i in gabo:
            algoritmo.ida[tipo(i)][tipo(res)] += 1
    except KeyError:
        print "gab", gab.nome, tipo(i), i, "res", tipo(res), res, "algoritmo", algoritmo.nome, algoritmo.ida.get("nct", None)
        sys.exit(1)
    

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
            [('M',   r'^[A-Ga-g](b|#)*(9)?(/[A-Ga-g](#|b)?)?$'),
             ('M7',  r'^[A-Ga-g](b|#)*7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('M7+', r'^[A-Ga-g](b|#)*(m)?7\+(9)?(/[A-Ga-g](#|b)?)?$'),
             ('m',   r'^[A-Ga-g](b|#)*[Mm](9)?(/[A-Ga-g](#|b)?)?$'),
             ('m7',  r'^[A-Ga-g](b|#)*[Mm]7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('°',     r'^[A-Ga-g](b|#)*°(9)?(/[A-Ga-g](#|b)?)?$'),
             ('°7',    r'^[A-Ga-g](b|#)*°7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('ø7',    r'^[A-Ga-g](b|#)*(Ø|ø)7(9)?(/[A-Ga-g](#|b)?)?$'),
             ('aug',     r'^[A-Ga-g](b|#)*\+(7\+|7)?(9)?(/[A-Ga-g](#|b)?)?$'),
             ('inc',     r'^[A-Ga-g, 0, 0](b|#)*!(7)?(9)?(/[A-Ga-g](#|b)?)?$'),
             ('aug6',     r'(Al\+6|It\+6|Fr\+6)'),
             ('nct',     r'—')
             ])

def tipo(res):
    for t in tipos:
        if t.re.match(res):
            return t.nome

entrada = file(sys.argv[1])

if not entrada.readline().startswith("Algoritmos:"):
    print "Algo errado no rameau. Parando."
    sys.exit(-1)

alg_names = []

for l in entrada:
    if not l.startswith("- "):
        break
    alg_names.append(l[2:].strip())

algoritmos = dict([(nome, Algoritmo(nome, tipos)) for nome in alg_names])

out = sys.stdout

for l in entrada:
    t = Linha(l)
    for gab in tipos:
        if gab.re.match(t.resultado) and any(gab.re.match(x) for x in t.gabarito):
            preenche_contagem(t.algoritmo, algoritmos, gab, 'amb', t.gabarito, t.resultado)
            break
    else:
        usado = False
        for gab in tipos:
            if gab.re.match(t.resultado) and not any(gab.re.match(x) for x in t.gabarito):
                preenche_contagem(t.algoritmo, algoritmos, gab, 'alg', t.gabarito, t.resultado)
                usado = True
                break
        for gab in tipos:
            if any(gab.re.match(x) for x in t.gabarito) and not gab.re.match(t.resultado):
                preenche_contagem(t.algoritmo, algoritmos, gab, 'gab', t.gabarito, t.resultado)
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
    for tipo in sorted(algoritmos[alg].contagem.keys()):
        a = algoritmos[alg].contagem[tipo]
        a['prec'] = precisao(a['gab'], a['alg'], a['amb'])
        a['rec']  = recall(a['gab'], a['alg'], a['amb'])
        a['fm']   = f_measure(a['gab'],a['alg'],a['amb'])
        print "%12s|%10s|%11s|%9s|%9s%%|%9s%%|%9s%%" % (tipo, a['gab'], a['alg'], a['amb'],
                                                        a['prec'], a['rec'], a['fm'])
        n += 1
        prec += float(a['prec'])
        rec += float(a['rec'])
        fm += float(a['fm'])
    print "%12s|%10s|%11s|%9s|%9s%%|%9s%%|%9s%%" % ('avg', '', '', '',"%2.1f" % (prec/n),"%2.1f" %(rec/n),
                                                    "%2.1f" % (fm/n))
    avg = Contagem()
    avg['prec'], avg['rec'], avg['fm'] = prec/n, rec/n, fm/n
    algoritmos[alg].contagem['avg'] = avg
    
    print


sys.stdout = file(dir_res + "tabelas.tex", 'w')

def print_tabela(chave, nome):
    print r"\begin{table}"
    print r"\centering"
    print r"\begin{tabular}{l|" + "r"*(1+len(algoritmos)) + "}"
    print "       &",
    algs = sorted(algoritmos.keys())
    for alg in algs:
        print "%11s" % alg[:8], "&",
    print r" \\ \hline"
    for tipo in tipos + [Tipo('avg', '')]:
        print "%4s" % tipo.nome, "&",
        for alg in algs:
            a = algoritmos[alg].contagem[tipo.nome]
            print "$%6s$" % ("%2.1f" % float(a[chave])), "&",
        print r" \\"
    print r"\end{tabular}"
    print r"\caption{Tabela de %s:}" % nome
    print r"\end{table}"
    print r'\clearpage'



def print_tabela_algoritmo_erro(algoritmo, total):
    print r"\begin{table}"
    print r"\centering"
    print r"\begin{tabular}{l||" + "r|"*(1+len(tipos)) + "}"
    print "%5s" % "",
    for t in tipos:
        print "&", "%5s" % t.nome,
    print r"\\  \hline \hline"
    for t in tipos:
        print "%5s" % t.nome,
        soma = float(sum(algoritmo.ida[t.nome].values()))  or 1.0
        for i in tipos:
            i = i.nome
            total.ida[t.nome][i] += algoritmo.ida[t.nome][i]
            print "& $",
            if algoritmo.ida[t.nome][i] != 0:
                print "%3s" % (algoritmo.ida[t.nome][i]), 
            else:
                print "   ",
            print "$",
        print r"\\ \hline"
    print r"\end{tabular}"
    print r"\caption{Classificacoes de %s:}" % algoritmo.nome
    print r"\end{table}"
    print r'\clearpage'


print r"""
\documentclass{article}
\usepackage{amsmath}
\usepackage[utf8x]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[english]{babel}
\usepackage{times}
\usepackage{color}
\usepackage[displaymath,textmath,sections,graphics,floats,auctex]{preview}


\title{Tabelas de resultados do Rameau}
\author{Rameau}

\twocolumn

\begin{document}

\maketitle

"""

print_tabela('prec', "precisão")
print_tabela('rec', "recall")
print_tabela('fm', "F-measure")

total = Algoritmo("total", tipos)
for a in algoritmos.values():
    print_tabela_algoritmo_erro(a, total)

print_tabela_algoritmo_erro(total, Algoritmo("", tipos))
            
print r"\end{document}"
sys.stdout = out

#print file(dir_res + "resultados.txt").read()

os.system("cd " + dir_res + " &&  " + "latex -interaction batchmode " +  "tabelas.tex > /dev/null" + " && " + "xdvi " +  "tabelas.dvi")
