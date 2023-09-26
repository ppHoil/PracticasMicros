
                    DATO1 		EQU	0X20
                    DATO2		EQU	0X21
                    DATO3		EQU	0X22
		    LUZ			EQU	0X23

                    ;INCLUDE     <C:\Users\joema\Escritorio\Micros\Practica 2\HEAD.ASM>; BANCO 1
		    INCLUDE	<C:\Users\ACER\Documents\1. UPIITA\5° Semestre\Microprocesadores\PRÁCTICAS\PRACTICA02\HEAD.INC>
				MOVLW		0X0F			;0X0F -> W 
			        MOVWF		TRISB			;PORTB.0-3 ENTRADAS
			        CLRF 		TRISC			;PORTC SALIDA
				MOVLW		0XFF			;0XFF -> W
			        MOVWF		TRISD			;PORTD Entrada
			        BCF 		STATUS, RP0		;BANCO 0

				CALL		DECIDEBUTTON
	
DECIDEBUTTON			BTFSC		PORTB,0       ; SE PRESIONO RB0
				GOTO		OTHER1
			        BTFSC		PORTB,RB1       ; SE PRESIONO RB1
			        GOTO		GRADOS45
			        BTFSC		PORTB,RB2       ; SE PRESIONO RB2
			        GOTO		GRADOS90
			        BTFSC		PORTB,RB3       ; SE PRESIONO RB3
			        GOTO		GRADOS135
			        GOTO		DECIDEBUTTON

;_________________OTHERS____________________________________________________________
				;PUSH_ANTIR	PORTB,0		;SE ESPERA A QUE SE PRESIONE Y SUELTE EL BOTON
OTHER1				MOVF		PORTD,W		;PORTD->W	;ANTES OTHER:
				MOVWF		DATO1           ;W->DATO1
				MOVWF		PORTC           ;W->PORTC
				
				PUSH_ANTIR	PORTB,0		;SE ESPERA A QUE SE PRESIONE Y SUELTE EL BOTON
				MOVF		PORTD,W		;PORTD->W
				MOVWF		DATO2           ;W->DATO2
				MOVWF		PORTC           ;W->PORTC
				
				PUSH_ANTIR	PORTB,0		;SE ESPERA A QUE SE PRESIONE Y SUELTE EL BOTON
				;CALL		LUCES
				GOTO		SUMA
;_________________OTHERS____________________________________________________________
				
;_________________45 GRADOS________________________________________________________
GRADOS45:			SUBT25MS
			        BTFSC		PORTB,RB1
			        GOTO		$-1
			        SUBT25MS
PWM45G:				BSF		PORTB,RB4
				SUBT2V		.1, .113	;1250us EN ALTO
				BCF		PORTB,RB4
				SUBT3V		.10, .17, .15	;18499us EN BAJO
				NOP
				GOTO		PWM45G
;_________________45 GRADOS________________________________________________________
				
				
;_________________90 GRADOS________________________________________________________
GRADOS90:			SUBT25MS
			        BTFSC		PORTB,RB1
			        GOTO		$-1
			        SUBT25MS
PWM90G:				BSF		PORTB,RB4
				SUBT3V		.21, .9, .1	;1500us EN ALTO
				BCF		PORTB,RB4
				SUBT3V		.11, .5, .43	;18500us EN BAJO	
				GOTO		PWM90G
;_________________90 GRADOS________________________________________________________
				
;_________________135 GRADOS________________________________________________________
GRADOS135:			SUBT25MS
			        BTFSC		PORTB,RB1
			        GOTO		$-1
			        SUBT25MS
PWM135G:			BSF		PORTB,RB4
				SUBT2V		.35, .7		;1750us EN ALTO	
				BCF		PORTB,RB4
				SUBT3V		.29, .3, .25	;18250us EN BAJO
				GOTO		PWM135G
;_________________135 GRADOS________________________________________________________

				
;*********************************************OPERACIONES*******************************************************************
;_____________________________SUMA___________________________________________________
SUMA:				MOVF		PORTD, W
				MOVWF		DATO2
				MOVF		DATO1,W			;DATO1->W
				ADDWF		DATO2,W			;DATO2+W->W
				MOVWF		DATO3			
				BTFSC		STATUS, C		;STATUS.C=0? ¿EXISTE ACARREO?
				CALL		PARPADEO
				MOVF		DATO3, W
				MOVWF		PORTC
				GOTO		RESTA
;_____________________________SUMA___________________________________________________	
				
;_________________RESTA_______________________________________
RESTA:				PUSH_ANTIR	PORTB,RB0
				BCF		PORTB, 7
				;CALL		SERIELUZ
				MOVF 		DATO2,W			;DATO2->W 
				SUBWF  		DATO1, W		;DATO1 - W -> W
				MOVWF		DATO3
				BTFSS		STATUS, C		;STATUS.C=1? ¿ES POSITIVO?
				SUBLW		0X00
				MOVWF		DATO3
				BTFSS		STATUS, C		;NEGATIVO CUANDO C=0
				CALL		PARPADEO		;¿NO HAY QUE ENCENDER RB7?-------------------------->
				MOVF		DATO3,W
				MOVWF		PORTC			;W -> PORTC
				GOTO		MULTIPLICACION			
;_________________RESTA__________________________________________________________
				
	
;_________________MULTIPLICACION_______________________________________
MULTIPLICACION:			MOVF		PORTD,W			;PORTD->W
				MOVWF		DATO2			;W->DATO2
				MOVF 		DATO2,W			;DATO2->W 
				IORWF  		DATO1, W		;DATO1 || W -> W
				BTFSC		STATUS, Z		;¿ES CERO?
				GOTO		FIN				;
START:				MOVF		DATO1,W			;DATO1->W
				ADDWF		DATO3,F			;DATO3=DATO3+W
				DECFSZ		DATO2,F			;DATO2 = DATO2-1 ¿ES CERO?
				GOTO		START			;NO ES IGUAL A 0
				MOVF 		DATO3,W			;SI ES IGUAL A 0
FIN:				MOVWF		PORTC			;W -> PORTC
				BTFSC		STATUS, C		;STATUS.C=0? ¿EXISTE ACARREO?
				GOTO		DESBORDE
				GOTO		DIVISION

DESBORDE:			CALL		PARPADEO
				MOVLW		0X00			;0X00->W
				MOVWF		PORTC			;W->PORTC
				GOTO		DIVISION
				;MULTIPLICACION:			PUSH_ANTIR	PORTB,RB0
;				BCF		PORTB, 7
;				;CALL		SERIELUZ
;				MOVF 		DATO2,W			;DATO2->W 
;				IORWF  		DATO1, W		;DATO1 || W -> W
;				BTFSC		STATUS, Z		;¿ES CERO?
;				GOTO		FIN				;
;START:				MOVF		DATO1,W			;DATO1->W
;				ADDWF		DATO3,F			;DATO3=DATO3+W
;				DECFSZ		DATO2,F			;DATO2 = DATO2-1 ¿ES CERO?
;				GOTO		START			;NO ES IGUAL A 0
;				MOVF 		DATO3,W			;SI ES IGUAL A 0
;FIN:				MOVWF		PORTC			;W -> PORTC
;				BTFSC		STATUS, C		;STATUS.C=0? ¿EXISTE ACARREO?
;				CALL		PARPADEO
;				GOTO		DIVISION
;_________________MULTIPLICACION_______________________________________
				
;_________________DIVISION_______________________________________
DIVISION:
				PUSH_ANTIR	PORTB,RB0
;				BTFSS		PORTB,RB0			;PORTB.0=1 -> SE PULSO EL BOTON
;				GOTO		DIVISION
				CLRF		DATO3
				BCF		PORTB, RB7		;PORTB.7 -> 0
				;CALL		SERIELUZ
				MOVF		PORTD,W			;PORTD->W
				MOVWF		DATO2			;W->DATO2
				MOVLW		0XFF
				ANDWF		DATO2,W			; DATO2 && W
				BTFSC		STATUS, Z		;¿ES CERO?
				GOTO		FINDIV
STARTDIV:			MOVF 		DATO2,W			;DATO2->W 
				SUBWF  		DATO1,F			;DATO1 - W -> W
				BTFSC		STATUS, Z		;¿Z ES 0?
				GOTO		NORESIDUO		;STATUS.Z=1? ¿ES POSITIVO?
				BTFSS		STATUS, C		;STATUS.C=1? ¿ES POSITIVO?
				GOTO		RESIDUO
				INCF		DATO3,F			;DATO3 = DATO3+1
				GOTO		STARTDIV

NORESIDUO:			INCF		DATO3,F			;DATO3 = DATO3+1
				MOVF 		DATO3,W			;DATO3->W
				MOVWF		PORTC
				GOTO 		$

RESIDUO:				
				BSF		PORTB, RB7		;PORTB.7 -> 1
				CALL		PARPADEO
				MOVF 		DATO3,W			;DATO3->W
				MOVWF		PORTC
				GOTO 		$

FINDIV:				BTFSC		STATUS, Z
				MOVLW		0XFF
				MOVWF		PORTC
				BTFSC		STATUS, Z
				BSF		PORTB, 7
				GOTO		$

;_________________DIVISION_______________________________________

		
;_____________________________PARPADEO___________________________________________________
PARPADEO:			BSF		PORTB,RB7
				MOVLW		.5
				MOVWF		LUZ
				MOVLW		0XFF
				MOVWF		PORTC
CICLOP:				CALL		SUBT500MS
				COMF		PORTC,F
				DECFSZ		LUZ,F
				GOTO		CICLOP
				RETURN			
;_____________________________PARPADEO___________________________________________________

SUBT500MS			SUBT3V		.79, .3, .253		;500000us	    ;------->  PODRIAMOS MEJORAR LA OPTIMIZACION DEL ESPACIO DE MEMORIA0us
				RETURN				

		    INCLUDE<C:\Users\ACER\Documents\1. UPIITA\5° Semestre\Microprocesadores\PRÁCTICAS\PRACTICA02\SERIE_LEDS.INC>
                    INCLUDE <C:\Users\ACER\Documents\1. UPIITA\5° Semestre\Microprocesadores\PRÁCTICAS\PRACTICA02\SUNTIME.INC>
		    ;SUBT25MS
		    END
            

