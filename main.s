; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>

RANDOM_LIST		EQU		0x20000A00
PRIME_LIST		EQU 	0x20000B00
; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>

; -------------------------------------------------------------------------------
; Fun��o main()
Start  
; Comece o c�digo aqui <======================================================

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
		
	;;Numero � primo: salvar na lista
	STRB R5, [R1], #4;
	ADD R4, R4, #1; ;Numero de primos
	
next_num
	ADD R9, R9, #1; incrementa indice
	CMP R2, R9; compara com o tamanho da lista
	IT GT
		BGT check_prime_loop

; Bubble Sort
bubble_sort
    LDR R0, =PRIME_LIST; ;primeira posi��o do array
    SUB R4, R4, #1; ;decrementa 1 do tamanho do array

main_loop
    MOV R5, #0; ; contador do loop principal
    MOV R10, #0; ; flag swapped
    
loop
    LDRB R2, [R0]; ; valor atual
    LDRB R3, [R0, #4]; ;pr�ximo valor
    CMP R2, R3;
    IT GT
        BGT swap;

    ADD R0, R0, #4; ; avan�a na lista
    ADD R5, R5, #1;
    CMP R5, R4;
    BLT loop;

    CMP R10, #0; ; check swap
    BEQ SORTED;

	LDR R0, =PRIME_LIST; ;Reinicia Array
    B main_loop; 

swap
    STRB R2, [R0, #4]; ; Trocar os valores
    STRB R3, [R0];
    MOV R10, #1; ; Sinalizar que houve troca
	B loop;

SORTED
	
	NOP;
	
	ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo
