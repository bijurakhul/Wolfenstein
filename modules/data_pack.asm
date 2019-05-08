;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - DATA PACK                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

console_data:

	console_wel_msg db 'Project Wolfenstein [version 0.2.5]',0x0D,0x0A
	                db 'By S.I.Biju Rakhul',0x0D,0x0A,0x0D,0x0A,0
					
	console_prompt db 'localhost> ',0
	console_input_buffer times 25 db 0 
	console_invalid_cmd db ' is not a valid command.',0x0A,0x0D
	                    db 'Try "help" instead',0x0A,0x0D,0x0A,0x0D,0
	console_cmd_restart_var db 'restart',0
	console_new_line_sign db 0x0A,0x0D,0
	console_cmd_help_var db 'help',0
	cmd_help_var db  0x0A,0x0D,0x0A,0x0D,'clr',0x0A,0x0D,'echo',0x0A,0x0D,'prog',0x0A,0x0D,'restart',0x0A,0x0D,'shutdown',0x0A,0x0D,'version',0x0A,0x0D,'yname',0x0A,0x0D,0x0A,0x0D,0
	console_cmd_clr_var db 'clr',0
	console_cmd_prog_var db 'prog',0
	console_cmd_yname_var db 'yname',0
	cmd_prog_var db 0x0A,0x0D,0x0A,0x0D,'Programmed by S.I.Biju Rakhul',0x0A,0x0D,0x0A,0x0D,0
	cmd_yname_var db 0x0A,0x0D,0x0A,0x0D,'Operating System : Wolfenstein',0x0A,0x0D,'Console          : Wolf Console',0x0A,0x0D,'Version          : 0.2.5',0x0A,0x0D,0x0A,0x0D,0
	cmd_echo_err db 0x0A,0x0D,'Syntax error : Try < echo "message" >',0x0A,0x0D,0x0A,0x0D,0
	console_cmd_echo_var db 'echo',0
	console_cmd_version_var db 'version',0
	console_cmd_shutdown_var db 'shutdown',0
	cmd_version_var db 0x0A,0x0D,0x0A,0x0D,'Wolfenstein Console Version : 0.2.5',0x0A,0x0D,'State                       : UNSTABLE',0x0A,0x0D,0x0A,0x0D,0
	apm_sucess db 0x0A,0x0D,'APM Sucess',0
	apm_error db 0x0A,0x0D,0x0A,0x0D,'APM BIOS not found to initiate termination!!!',0x0D,0x0A
	          db 'Your system does not follow APM standards',0x0A,0x0D,0x0A,0x0D,0
	apm_int_error db 0x0A,0x0D,0x0A,0x0D,'Error : cannot connect to APM BIOS interface',0x0A,0x0D
                  db 'Contact your system Administrator',0x0A,0x0D,0x0A,0x0D,0	
	apm_shut_error db 0x0A,0x0D,0x0A,0x0D,'Unable to shutdown : APM error',0x0A,0x0D,0