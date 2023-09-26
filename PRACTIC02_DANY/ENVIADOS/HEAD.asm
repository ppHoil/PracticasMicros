				;INCLUDE		<C:\Users\joema\Escritorio\Micros\Practica 2\MACROS.ASM>
				INCLUDE	    <C:\Users\ACER\Documents\1. UPIITA\5° Semestre\Microprocesadores\PRÁCTICAS\PRACTICA02\ENVIADOS\MACROS.ASM>
				PROCESSOR   16F887
				__CONFIG    0X2007,0X23E4
				__CONFIG    0X2008,0X3FFF
				INCLUDE     <P16F887.INC>
				ORG         0X0000
								
				CLRF        PORTA
				CLRF        PORTB
				CLRF        PORTC
				CLRF        PORTD
				CLRF        PORTE
				CLRF        DATO1
				CLRF        DATO2
				CLRF        DATO3			

				BSF         STATUS,RP0
				BSF         STATUS,RP1; B3
				CLRF        PORTA
				CLRF        ANSEL
				CLRF        ANSELH
				BCF         STATUS,RP1