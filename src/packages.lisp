(in-package #:cl-user)

(defpackage #:rameau
  (:export #:acerta-times #:agrupa-inicio #:agrupa-por
  #:parse-acrescimos #:get-modo #:parse-fundamental
  #:%chord-interval-code #:qual-inversao? #:qual-intervalo-no-baixo?
  #:cifra->acorde #:get-intervalo-inversao-pop #:get-inversao-pop
  #:acorde->cifra #:read-pop-file #:7+ #:extract-cifra
  #:expande-cifra-setima #:expand-mel #:gera-gabarito-file
  #:ajusta-duracao #:algoritmo-pardo #:assoc-item #:avalia-segmento
  #:avalia-segmento-notas #:avalia-template #:code->interval
  #:code->note #:coloca-expressoes-em-sequencia
  #:compara-gabarito-pardo #:compara-gabarito-pardo-individual
  #:compara-notas #:concat #:corrige-exemplo #:count-subseq
  #:cria-nota #:cria-skip #:da-nota-modificada #:desempata-pardo
  #:dim7? #:dim7-res #:do-nothing #:do-the-parsing #:empty-octave
  #:exclude-repetition #:expande-multiplicacoes #:expmerge
  #:file-string #:fim-evento #:gera-gabarito-pardo #:%get-accidental
  #:get-accidentals #:get-exp #:get-flat #:get-interval-name
  #:get-interval-quantity #:get-sharp #:get-system-intervals
  #:get-system-item #:get-system-module #:get-system-notes
  #:group-and-count #:interval #:interval->code #:inversion #:last1
  #:lista-notas #:match-note-representation #:max-predicado
  #:menos-de-uma-quarta #:menos-mod-96 #:merge-exprs
  #:modificador-oitava #:module #:move-evento-no-tempo
  #:movimenta-sequencia #:no-op #:normal-form #:normaliza-notas
  #:note? #:%note->code #:note->code #:number-of-accidentals
  #:octave-from-string #:pardo #:parse-assignment #:parse-chord-dur
  #:parse-context-score #:parse-context-staff #:parse-context-voice
  #:parse-dur #:parse-dur-multiplica #:parse-dur-ponto #:parse-file
  #:parse-include #:parse-lilypond #:parse-music-block #:%parse-note
  #:parse-relative-block #:parse-score-block #:parse-simult
  #:parse-simultaneous #:parse-staff-block #:parse-string
  #:parse-times-block #:parse-variable-block #:parse-voice-block
  #:parse-voice-block-string #:prime-form #:print-accidentals
  #:print-interval #:print-note #:processa-gabarito #:process-ast
  #:process-trees #:pula #:redivide-segmentos #:relativiza
  #:repeat-string #:rest? #:retorna-n-segmentos #:root-weight #:rotate
  #:segmentos-minimos #:segment-to-template #:set-equal?
  #:set-form-list #:set-intervals #:set-inversion #:set-rotate
  #:set-symmetric? #:set-transpose #:set-transpose-to-0 #:smaller-sets
  #:smaller-sets-comparisson #:smallest-set #:sort-form-list
  #:sort-set #:string->symbol #:symbol->number #:template-prob
  #:transpoe #:transpose #:with-system #:make-evento #:evento-pitch
  #:evento-dur #:evento-octave #:evento-inicio #:evento-passagem?
  #:*notes* #:*rests* #:*tonal-system* #:*tonal-intervals*
  #:*tempered-intervals* #:*tempered-system* #:*systems* #:*system*
  #:*intervals-name* #:*intervals-quantity* #:*accidentals*)
  (:use #:cl #:yacc #:lisp-unit))
