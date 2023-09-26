;_________________SUB-RUTINA DE TIEMPO 1 VARIABLE______________________________________________
SUBT1V			MACRO		VAR1
			MOVLW 		VAR1
			MOVWF		0X60
			CALL		ST1V
			ENDM
;_________________SUB-RUTINA DE TIEMPO 1 VARIABLE______________________________________________

;_________________SUB-RUTINA DE TIEMPO 2 VARIABLES_____________________________________________
SUBT2V			MACRO		VAR1,VAR2
			MOVLW		VAR1		
			MOVWF		0X61
			MOVLW		VAR2			
			MOVWF		0X62
			CALL		ST2V
			ENDM
;_________________SUB-RUTINA DE TIEMPO 2 VARIABLES_____________________________________________

;_________________SUB-RUTINA DE TIEMPO 3 VARIABLES_____________________________________________
SUBT3V			MACRO		VAR1,VAR2,VAR3
			MOVLW		VAR1
			MOVWF		0X64
			MOVLW		VAR2
			MOVWF		0X65
			MOVLW		VAR3
			MOVWF		0X66
			CALL		ST3V
			ENDM
;_________________SUB-RUTINA DE TIEMPO 3 VARIABLES_____________________________________________

;_________________SISMETA ANTI REBOTES_________________________________________________________
PUSH_ANTIR		MACRO		PUERTO,PIN
			BTFSS		PUERTO,PIN
			GOTO		$-1
			;SUBT25MS
			BTFSC		PUERTO,PIN
			GOTO		$-1
			;SUBT25MS
			ENDM
;_________________SISMETA ANTI REBOTES_________________________________________________________

			
;_________________TEMPORIZADOR DE 25MS_________________________________________________________
SUBT25MS		MACRO		
			SUBT3V		.3,.47,.25
			RETURN
			ENDM
;_________________TEMPORIZADOR DE 25MS_________________________________________________________


