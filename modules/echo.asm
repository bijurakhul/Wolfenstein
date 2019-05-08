;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - ECHO FUNCTION                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

console_echo_compare:
    
	cld
	pusha
	mov cx, 0000h
    mov di, console_input_buffer
	
	.echo_compare_start:
	    
		inc cx
		cmp cx, 0005h
		je .echo_space
		mov al, [si]
		mov bl, [di]
		cmp al, bl
		je .echo_again
		jmp .echo_clc
		
		.echo_again:
		    
			inc si
			inc di
			jmp .echo_compare_start
			
			.echo_space:
			
                mov al, [di]
			    cmp al, 0x20
			    je .echo_stc
			    jmp .echo_clc
			
	.echo_stc:
	 
	    popa
		stc
		ret
		
	.echo_clc:
	    
		popa
	    clc
		ret