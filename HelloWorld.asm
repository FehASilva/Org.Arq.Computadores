; Hello World - Escreve mensagem armazenada na memoria na tela

; ------- TABELA DE CORES -------
; adicione ao caracter para Selecionar a cor correspondente

; 0 branco							0000 0000
; 256 marrom							0001 0000
; 512 verde							0010 0000
; 768 oliva							0011 0000
; 1024 azul marinho						0100 0000
; 1280 roxo							0101 0000
; 1536 teal							0110 0000
; 1792 prata							0111 0000
; 2048 cinza							1000 0000
; 2304 vermelho							1001 0000
; 2560 lima							1010 0000
; 2816 amarelo							1011 0000
; 3072 azul							1100 0000
; 3328 rosa							1101 0000
; 3584 aqua							1110 0000
; 3840 branco							1111 0000

jmp main

mensagem : var #13
static mensagem + #0, #'H'
static mensagem + #1, #'e'
static mensagem + #2, #'l'
static mensagem + #3, #'l'
static mensagem + #4, #'o'
static mensagem + #5, #' '
static mensagem + #6, #'W'
static mensagem + #7, #'o'
static mensagem + #8, #'r'
static mensagem + #9, #'l'
static mensagem + #10, #'d'
static mensagem + #11, #'!'
static mensagem + #12, #'\0'

;---- Inicio do Programa Principal -----

main:
	loadn r0, #3			; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #mensagem	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #512			; Seleciona a COR da Mensagem
	call Imprimestr   ;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	halt
	
;---- Fim do Programa Principal -----
	
;---- Inicio das Subrotinas -----
	
Imprimestr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r2 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1
	cmp r4, r3
	jeq ImprimestrSai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;---- Fim das Subrotinas -----
