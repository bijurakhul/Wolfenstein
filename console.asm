;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - COMMAND LINE INTERFACE                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[bits 16]
[org 0x1000]

cld

wolf_video_mode:

	mov ah, 00h    ;changing video mode to 80x25
	mov al, 03h
	int 10h

wolf_scroll_up_screen:    ;scroll up screen
    
	mov ah, 06h
	mov al, 00h
	mov bh, 1fh
	mov cx, 0000h
	mov dh, 18h
	mov dl, 4fh
	int 10h

	mov si, console_wel_msg     ;display welcome message
	call wolf_print

console_input:      ;gets input from the user
 
	mov di, console_input_buffer
	xor cl, cl
	call console_get_input
	
	mov si, console_cmd_restart_var
	call console_string_compare
	jnc .console_cmd_help
	call console_cmd_restart_fn
	
	.console_cmd_help:
	
		mov si, console_cmd_help_var
		call console_string_compare
		jnc .console_cmd_clr
		call console_cmd_help_fn
		jmp console_input
		
	.console_cmd_clr:
	
		mov si, console_cmd_clr_var
		call console_string_compare
		jnc .console_cmd_prog
		call console_cmd_clr_fn
		jmp console_input
		
	.console_cmd_prog:

		mov si, console_cmd_prog_var
		call console_string_compare
		jnc .console_cmd_shutdown
		call console_cmd_prog_fn
		jmp console_input

	.console_cmd_shutdown:

		mov si, console_cmd_shutdown_var
		call console_string_compare
		jnc .console_cmd_echo
		call console_cmd_shutdown_fn
		jmp console_input

	.console_cmd_echo:

		mov si, console_cmd_echo_var
		call console_echo_compare
		jnc .console_cmd_yname
		call console_cmd_echo_fn
		jmp console_input

	.console_cmd_yname:

		mov si, console_cmd_yname_var
		call console_string_compare
		jnc .console_cmd_version
		call console_cmd_yname_fn
		jmp console_input

	.console_cmd_version:

		mov si, console_cmd_version_var
		call console_string_compare
		jnc .console_cmd_label_exit
		call console_cmd_version_fn
		jmp console_input

	.console_cmd_label_exit:

		mov si, console_new_line_sign
		call wolf_print

		mov ah, 0x0e
		mov al, '"'
		int 10h

		mov si, console_input_buffer
		call wolf_print

		mov ah, 0x0e
		mov al, '"'
		int 10h

		mov si, console_invalid_cmd
		call wolf_print

jmp console_input

;include files in Module directory
wolf_include_files:

	%include 'modules\print.asm'
	%include 'modules\input.asm'
	%include 'modules\data_pack.asm'
	%include 'modules\str_cmp.asm'
	%include 'modules\echo.asm'

console_cmd_restart_fn:

	jmp 0xffff:0x0000

console_cmd_help_fn:

	mov si, cmd_help_var
	call wolf_print
	ret

console_cmd_clr_fn:

	mov si, console_new_line_sign
	call wolf_print

	; get cursor status DH:ROW and DL:COLUMN
	mov ah, 03h
	mov bh, 00
	int 10h

	; scroll the screen by AL:DH(prev) rows and DL:4F(79) columns since column is constant ie: 79
	mov ah, 06h
	mov al, dh
	mov bh, 1fh
	mov cx, 0000
	mov dl, 4fh
	int 10h

	; Set the cursor to top of the screen and print the prompt
	mov ah, 02h
	mov bh, 00
	mov dx, 0000h
	int 10h

	ret


console_cmd_prog_fn:

	mov si, cmd_prog_var
	call wolf_print
	ret

console_cmd_shutdown_fn:

	mov ah, 53h
	mov al, 00h
	xor bx, bx
	int 15h
	jc APM_error

	clc
	mov ah, 53h
	mov al, 01h
	xor bx, bx
	int 15h
	jc APM_int_error

	mov ah, 53h
	mov al, 07h
	mov bx, 0001h
	mov cx, 0003h
	int 15h
	jc APM_shut_error
	ret

	APM_shut_error:

		mov si, apm_shut_error
		call wolf_print
		ret
	
	APM_error:
		mov si, apm_error
		call wolf_print
		ret

	APM_int_error:
		mov si, apm_int_error
		call wolf_print
		ret
		

console_cmd_yname_fn:

	mov si, cmd_yname_var
	call wolf_print
	ret

console_cmd_echo_fn:

	mov si, console_new_line_sign
	call wolf_print
	mov si, console_input_buffer+5
	call wolf_print
	mov si, console_new_line_sign
	call wolf_print
	mov si, console_new_line_sign
	call wolf_print
	ret

console_cmd_version_fn:

	mov si, cmd_version_var
	call wolf_print
	ret

