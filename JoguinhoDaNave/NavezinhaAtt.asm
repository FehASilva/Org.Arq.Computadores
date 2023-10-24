jmp main

; alocar variaveis
mensagem : string "Joguinho da Nave!"	; String titulo do jogo
posNave: var #1							; Contem a posicao atual da Nave

main:
	loadn r0, #0		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #mensagem	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #512		; Seleciona a COR da Mensagem
	
	call Imprimestr   ;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"


	Loadn R0, #40			
	store posNave, R0		; Zera Posicao Atual da Nave

	loadn r7, #0    ; Contador
	loadn r1, #0 	; Resto 0 do MOD

loop: 	
		; Nave
		loadn r0, #10
		mod r0, r7, r0
		cmp r0, r1
		ceq Atualisa_Nave
		
		call Delay		 ; Aguarda um momento
		; Check Criterio de parada e Break

		inc r7	; count++
		jmp loop

		
fim:
	halt

	
Imprimestr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

Imprimestr_Loop:	
	loadi r4, r1
	cmp r4, r3
	jeq Imprimestr_Sai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp Imprimestr_Loop
	
Imprimestr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

Atualisa_Nave:
		push r0
		push r1

		load r0, posNave
		loadn r1, #' '  ; Espaco em branco para Apagar a Nave
		outchar r1, r0	 ; Apaga a nave
		
		inc R0			 ; Recalcula a posicao
		loadn r1, #1200 ; Criterio de Parada
		cmp r0, r1
		jne Atualisa_Nave_Skip
		loadn r0, #40

Atualisa_Nave_Skip:
		store posNave, r0
		
		loadn r1, #'O'  ; Char Nave
		outchar r1, r0   ; Desenha a Nave
		
		pop r1
		pop r0
		rts

;********************************************************
;                       DELAY
;********************************************************		

Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	push R0
	push R1
	
	loadn R1, #15   ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn R0, #3000	; b
   	Delay_volta1: 
			dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
			jnz Delay_volta1	
		dec R1
		jnz Delay_volta2
	
	pop R1
	pop R0
	
	rts							;return
;-------------------------------
