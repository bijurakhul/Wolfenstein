;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project Wolfenstein                                              ;;
;; Phase : 2.5                                                      ;;
;; WOLF CONSOLE - BOOTLOADER                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[bits 16]
[org 0x7c00]

xor ax, ax
mov ds, ax
mov es, ax
mov bx, 0x8000

mov ss, bx
mov sp, ax

cld

mov ah, 00      ;reset to first sector of disk
int 13h

read_wolf_cli_sector:    ;load cli from second sector

  xor ax, ax
	mov es, ax
	mov bx, 0x1000
	
	mov ah, 02
	mov al, 03
	mov ch, 00
	mov cl, 02
	mov dh, 00
	int 13h
	
	jc wolf_fatal_error
	
	popf
	
	jmp 0x0:0x1000
	cli
	hlt
	
	wolf_fatal_error:
		mov si, wolf_disk_error_msg
		mov ah, 0x0e
		
		wloop:

			lodsb
			or al, al
			jz exit
			int 10h
			jmp wloop
			
			exit:

				mov ah, 00
				int 16h
				
				jmp 0xffff:0x0000
				
wolf_data:

  wolf_disk_error_msg db 0x0A,0x0D,'Unable to load console.bin - Fatal disk error',0

times 510-($-$$) db 0
dw 0xAA55