;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - INPUT COMMAND                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

console_get_input:
    
	mov si, console_prompt         ;display prompt to the user
    call wolf_print
	xor cl, cl
    .input_loop:
  
        mov ah, 00h   ; keyboard get input function
	    int 16h
	
     	cmp al, 0x08
	    je .input_backspace
	
	    cmp al, 0x0D
	    je .input_enter
	
    	cmp cl, 0x19
	    je .input_full 
	
    	mov ah, 0x0e
	    int 10h
	
	    stosb
	    inc cl
	    jmp .input_loop
		
		.input_backspace:
		    
			cmp cl, 0
			je .input_loop
			dec di
			mov byte [di], 0
			dec cl
			
			mov ah,0x0e
			mov al, 0x08
			int 10h
			
			mov al, ' '
			int 10h
			
			mov al, 0x08
			int 10h
			
			jmp .input_loop
			
		.input_enter:
		    
			cmp cl, 0
			je .input_enter_newline
			
			mov al, 0
			stosb
			
			ret
			
			.input_enter_newline:
			
		        mov ah, 0x0e
			    mov al, 0x0D
			    int 10h
			
			    mov al, 0x0A
			    int 10h
			
			    ;mov si, console_prompt         ;display prompt to the user
                ;call wolf_print
				
				jmp console_get_input
			
		.input_full:
		
		    mov si, buffer_full
			call wolf_print
			
		    jmp console_get_input
			
data:
  
    buffer_full db 0x0A,0x0D,0x0A,0x0D,'Warning : Input buffer full (0x19)',0x0A,0x0D
	            db 'clearing buffer...',0x0A,0x0D,0x0A,0x0D,0
				