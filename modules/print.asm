;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - PRINT STRING                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

wolf_print:
    
	mov ah, 0x0e
	
	wolf_print_loop:
	
	    lodsb
	    or al, al
	    jz exit
	    int 10h
	    jmp wolf_print
	
	    exit:
	    
		    ret