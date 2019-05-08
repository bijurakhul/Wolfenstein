;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - STRING COMPARE FUNCTION                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

console_string_compare:
    stc
	cld
	pusha
	mov di, console_input_buffer
	
	console_string_compare_start:
	    
	    mov al, [si]
	    mov bl, [di]
		
	    cmp al, bl
	    jne .console_clear_carry_on_not_equal
		
		cmp al, 0
		je .console_set_carry_on_equal
		
		inc di
		inc si
		
		jmp console_string_compare_start
		
		.console_set_carry_on_equal:
		    popa
			stc
			ret

        .console_clear_carry_on_not_equal:
            
			popa
            clc
            ret			
			