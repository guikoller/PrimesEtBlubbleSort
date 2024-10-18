; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>

RANDOM_LIST		EQU		0x20000A00
PRIME_LIST		EQU 	0x20000B00
; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>

; -------------------------------------------------------------------------------
; Função main()
Start  
; Comece o código aqui <======================================================

    LDR R0, =RANDOM_LIST; ;ponteiro para lista original
	LDR R1, =PRIME_LIST; ; ponteiro para lista de primos
	MOV R2, #20;		;TAM
	
loadlist
	MOV R3, #193;
	STRB R3, [R0], #4;
	
	MOV R3, #63;
	STRB R3, [R0], #4;
	
	MOV R3, #176;
	STRB R3, [R0], #4;
	
	MOV R3, #127;
	STRB R3, [R0], #4;
	
	MOV R3, #43;
	STRB R3, [R0], #4;
	
	MOV R3, #13;
	STRB R3, [R0], #4;
	
	MOV R3, #211;
	STRB R3, [R0], #4;
	
	MOV R3, #3;
	STRB R3, [R0], #4;
	
	MOV R3, #203;
	STRB R3, [R0], #4;
	
	MOV R3, #5;
	STRB R3, [R0], #4;
	
	MOV R3, #21;
	STRB R3, [R0], #4;
	
	MOV R3, #7;
	STRB R3, [R0], #4;
	
	MOV R3, #206;
	STRB R3, [R0], #4;
	
	MOV R3, #245;
	STRB R3, [R0], #4;
	
	MOV R3, #157;
	STRB R3, [R0], #4;
	
	MOV R3, #237;
	STRB R3, [R0], #4;
	
	MOV R3, #241;
	STRB R3, [R0], #4;
	
	MOV R3, #105;
	STRB R3, [R0], #4;
	
	MOV R3, #252;
	STRB R3, [R0], #4;
	
	MOV R3, #19;
	STRB R3, [R0], #4;
	
find_primes
	LDR R0, =RANDOM_LIST;
	MOV R4, #0;COUNT PRIMOS
	MOV R9,#0;
	
check_prime_loop
	LDRB R5, [R0], #4;
	;B next_num
	
	
	MOV R6, #2; ;inicia o divisor com 2
check_prime
	UDIV R7, R5, R6; ; R7=R5/R6
	MLS R8, R7, R6, R5; ;resto = r5 - (r6*r7)
	
	CMP R8, #0;
	BEQ next_num
	
	ADD R6, R6, #1;
	CMP R6, R5;
	IT LT
		BLT check_prime
		
	;;Numero é primo: salvar na lista
	STRB R5, [R1], #4;
	ADD R4, R4, #1;
	
next_num
	ADD R9, R9, #1; incrementa indice
	CMP R2, R9; compara com o tamanho da lista
	IT GT
		BGT check_prime_loop
	

	
	
	NOP;
	
	ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
