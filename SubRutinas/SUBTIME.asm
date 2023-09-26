;SUBRUTINA DE TIEMPO DE UNA VARIABLE                
ST1V:			NOP
				NOP             
                NOP
				NOP             
                NOP				
                DECFSZ      0X60,F
                GOTO        ST1V
                RETURN
;***********************************************************************
;SUBRUTINA DE TIEMPO DE DOS VARIABLE                
ST2V:			MOVF		0X62,W
				MOVWF		0X63
DECRE2V			NOP
				NOP
				NOP
				NOP
				NOP
                DECFSZ      0X63,F
                GOTO        DECRE2V
				DECFSZ		0X61,F
				GOTO		ST2V
                RETURN	
;***********************************************************************				
;SUBRUTINA DE TIEMPO DE TRES VARIABLES                
ST3V:			MOVF		0X66,W
				MOVWF		0X67
RECARGA3V:		MOVF		0X65,W
				MOVWF		0X68
DECRE3V:		NOP
                NOP
				NOP
				NOP
				NOP
                DECFSZ      0X68,F
                GOTO        DECRE3V
				DECFSZ		0X67,F
				GOTO		RECARGA3V
				DECFSZ		0X64,F
				GOTO		ST3V
                RETURN