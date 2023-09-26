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
			
				;PUSH_ANTIR	PORTB, 0
				CALL		P_ANTIR	
				MOVF		PORTD,W		;CARGAMOS DATO1
				MOVWF		DATO1           
				MOVWF		PORTC 
				
				;PUSH_ANTIR	PORTB, 0
				CALL		P_ANTIR	
				MOVF		PORTD,W		;CARGAMOS DATO2
				MOVWF		DATO2           
				MOVWF		PORTC 
				
				;PUSH_ANTIR	PORTB, 0
				CALL		P_ANTIR	
				MOVF		PORTD,W		;CARGAMOS DATO3
				MOVWF		DATO3           
				MOVWF		PORTC 
				
				;PUSH_ANTIR	PORTB, 0	
				CALL		P_ANTIR	
REPITE				MOVLW		0XFF		;ENCENDEMOS TODOS LOS LEDS
				MOVWF		PORTC
				BSF		PORTB, 7
				CALL		TIEMPOPROF
				
				COMF		PORTC, F
				BCF		PORTB, 7
				CALL		TIEMPOPROF
				GOTO		REPITE
				
TIEMPOPROF			SUBT3V		DATO1, DATO2, DATO3							
				RETURN
		
P_ANTIR				BTFSS		PORTB,0
				GOTO		$-1
				;CALL		SUBT25MS
				BTFSC		PORTB, 0
				GOTO		$-1
				;CALL		SUBT25MS
				RETURN
SUBT25MS
				SUBT3V		.3,.47,.25
				RETURN
				
		    INCLUDE<C:\Users\ACER\Documents\1. UPIITA\5° Semestre\Microprocesadores\PRÁCTICAS\PRACTICA02\SERIE_LEDS.INC>
                    INCLUDE <C:\Users\ACER\Documents\1. UPIITA\5° Semestre\Microprocesadores\PRÁCTICAS\PRACTICA02\SUNTIME.INC>
		    ;SUBT25MS
		    END


