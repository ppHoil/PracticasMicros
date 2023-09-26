;INSTITUTO POLITECNICO NACIONAL
;UNIDAD PROFECIONAL INTERDISCIPLINARIA EN INGENIRIA Y TECNOLOGIAS AVANZADAS
;UO, UC E I
;27 DE SEPTIEMBRE 2023
;HOIL ROSAS JOSE ANGEL
;
;
;M. EN C. DAVID ARTURO GUTIERREZ BEGOVICH
;PRACTICA 2
                    DATO1 		EQU	0X20
                    DATO2		EQU	0X21
                    DATO3		EQU	0X22
					LUZ			EQU	0X23

                    INCLUDE     <C:\Users\joema\Escritorio\Micros\Practica 2\HEAD.ASM>; BANCO 1
                    MOVLW		0X0F			;0X0F -> W 
			        MOVWF		TRISB			;PORTB.0-3 ENTRADAS
			        CLRF 		TRISC			;PORTC SALIDA
                    MOVLW		0XFF			;0XFF -> W
			        MOVWF		TRISD			;PORTD Entrada
			        BCF 		STATUS, RP0		;BANCO 0

                    CALL        DECIDEBUTTON


DECIDEBUTTON:       BTFSC		PORTB,RB0       ; SE PRESIONO RB0
                    GOTO		OTHER
			        BTFSC		PORTB,RB1       ; SE PRESIONO RB1
			        GOTO		GRADOS45
			        BTFSS		PORTB,RB2       ; SE PRESIONO RB2
			        GOTO		GRADOS90
			        BTFSC		PORTB,RB3       ; SE PRESIONO RB3
			        GOTO		DECIDEBUTTON
			        GOTO		GRADOS135

;_________________45 GRADOS________________________________________________________
GRADOS45:           CALL		T25MS
			        BTFSC		PORTB,RB1
			        GOTO		$-1
			        CALL		T25MS
PWM45G:             BSF         PORTB,RB4
					SUBT3V		
                    BCF         PORTB,RB4
					SUBT2V		
					NOP
					GOTO		PWM45G
;_________________45 GRADOS________________________________________________________

;_________________90 GRADOS________________________________________________________
GRADOS90:           CALL		T25MS
			        BTFSC		PORTB,RB1
			        GOTO		$-1
			        CALL		T25MS
PWM90G:             BSF         PORTB,RB4
					SUBT3V		
                    BCF         PORTB,RB4
					SUBT2V		
					NOP
					GOTO		PWM90G
;_________________90 GRADOS________________________________________________________

;_________________135 GRADOS________________________________________________________
GRADO135S:          CALL		T25MS
			        BTFSC		PORTB,RB1
			        GOTO		$-1
			        CALL		T25MS
PWM135G:            BSF         PORTB,RB4
					SUBT3V		
                    BCF         PORTB,RB4
					SUBT2V		
					NOP
					GOTO		PWM135G
;_________________135 GRADOS________________________________________________________

OTHER:              MOVF		PORTD,W			;PORTD->W
				    MOVWF		DATO1           ;W->DATO1
				    MOVWF		PORTC           ;W->PORTC
					PUSH_ANTIR  PORTB,RB0
OTHER:              MOVF		PORTD,W			;PORTD->W
				    MOVWF		DATO2           ;W->DATO2
				    MOVWF		PORTC           ;W->PORTC
					PUSH_ANTIR  PORTB,RB0
					GOTO		LUCES

;_________________________LUCES______________________________________________
LUCES:				CLRF		PORTC			;00000000
					BCF			STATUS, C       ;C=0
					SUBT300MS
					INCF		PORTC, F		;00000001-C0
CICLO1				SUBT300MS
					RLF			PORTC
					BTFSS		STATUS, C
					GOTO 		CICLO1
					BCF			STATUS, C
CICLO2				SUBT300MS
					RLF			PORTC
					INCF		PORTC, F
					BTFSS		STATUS, C
					GOTO 		CICLO2
CICLO3				SUBT300MS
					BCF			STATUS, C
					RRF			PORTC
					BTFCS		STATUS, C  ;AQUI PUEDE HABER UN ERROR REVISAR
					GOTO 		CICLO3
					GOTO		SUMA
;_________________________LUCES______________________________________________

;_____________________________SUMA___________________________________________________
SUMA:				MOVF		DATO1,W			;DATO1->W
					ADDWF		DATO2,W			;DATO2+W->W
					MOVWF		PORTC			;W -> PORTC
					BTFSC		STATUS, C		;STATUS.C=0? �EXISTE ACARREO?
					CALL		PARPADEO
					BCF			PORTB,RB7
					PUSH_ANTIR  PORTB,RB0
					GOTO		RESTA
;_____________________________SUMA___________________________________________________

;_____________________________PARPADEO___________________________________________________
PARPADEO:			BSF			PORTB,RB7
					MOVLW		.5
					MOVWF		LUZ
					MOVLW		0XFF
					MOVWF		PORTC
CICLOP:				SUBT500MS
					COMF		PORTC,F
					DECFSZ		LUZ,F
					GOTO		CICLOP
					RETURN			
;_____________________________PARPADEO___________________________________________________

                    INCLUDE <C:\Users\joema\Escritorio\Micros\Practica 2\SUBTIME.ASM>
			        SUBT25MS
			        END
            

