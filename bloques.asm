; prueba de los limites y diseño de la interfaz
;------------------------------------------------------------
        
section .data ; (80 guiones)

	techo: db 0x1b,"[1J", 0x1b, "[3;1f",0x1b,"[1m", '----------------------------------------------------------------------------------',0xa		
	techo_size: equ $-techo	

	;cada rectangulo es de un ancho de 10 guiones; espacios de 4
	b11: db 0x1b, "[5;10f", 0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b_size: equ $-b11
	b12: db 0x1b, "[5;25f", 0x1b, "[45;35m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b13: db 0x1b, "[5;40f", 0x1b, "[46;36m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
      	b14: db 0x1b, "[5;55f", 0x1b, "[44;34m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b15: db 0x1b, "[5;70f", 0x1b, "[41;31m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b16: db 0x1b, "[5;85f", 0x1b, "[43;33m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m",0xa
;---------------------------------------------------------------------------------------------------------
	b21: db 0x1b, "[7;10f", 0x1b, "[41;31m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b22: db 0x1b, "[7;25f", 0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b23: db 0x1b, "[7;40f", 0x1b, "[43;33m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b24: db 0x1b, "[7;55f", 0x1b, "[46;36m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b25: db 0x1b, "[7;70f", 0x1b, "[45;35m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b26: db 0x1b, "[7;85f", 0x1b, "[44;34m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m",0xa
;---------------------------------------------------------------------------------------------------------
	b31: db 0x1b, "[9;10f", 0x1b, "[45;35m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b32: db 0x1b, "[9;25f", 0x1b, "[46;36m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b33: db 0x1b, "[9;40f", 0x1b, "[44;34m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b34: db 0x1b, "[9;55f", 0x1b, "[43;33m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b35: db 0x1b, "[9;70f", 0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b36: db 0x1b, "[9;85f", 0x1b, "[41;31m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m",0xa

;----------------------------------------------------------------------------------------------------------

	salir: db 0x1b, "[1m", ' ', 0x1b, "[0m",0xa
	salir_size: equ $-salir
	


section .text
	global _start
_start:
	; imprimir techo
	mov rax,1; syswrite
	mov rdi,1; standar output
	mov rsi,techo
	mov rdx,techo_size
	syscall

	mov rax,1; imprime b11
	mov rdi,1
	mov rsi,b11
	mov rdx,b_size
	syscall
	mov rax,1; imprime b12
        mov rdi,1
        mov rsi,b12
        mov rdx,b_size
        syscall
	mov rax,1; imprime b13
        mov rdi,1
        mov rsi,b13
        mov rdx,b_size
        syscall
	mov rax,1; imprime b14
        mov rdi,1
        mov rsi,b14
        mov rdx,b_size
        syscall
        mov rax,1; imprime b15
        mov rdi,1
        mov rsi,b15
        mov rdx,b_size
        syscall
        mov rax,1; imprime b16
        mov rdi,1
        mov rsi,b16
        mov rdx,b_size
        syscall;-------------------------------------

	mov rax,1; imprime b21
        mov rdi,1
        mov rsi,b21
        mov rdx,b_size
        syscall
        mov rax,1; imprime b22
        mov rdi,1
        mov rsi,b22
        mov rdx,b_size
        syscall
        mov rax,1; imprime b23
        mov rdi,1
        mov rsi,b23
        mov rdx,b_size
        syscall
        mov rax,1; imprime b24
        mov rdi,1
        mov rsi,b24
        mov rdx,b_size
        syscall
        mov rax,1; imprime b25
        mov rdi,1
        mov rsi,b25
        mov rdx,b_size
        syscall
        mov rax,1; imprime b26
        mov rdi,1
        mov rsi,b26
        mov rdx,b_size
        syscall;-----------------------------

	mov rax,1; imprime b31
        mov rdi,1
        mov rsi,b31
        mov rdx,b_size
        syscall
        mov rax,1; imprime b32
        mov rdi,1
        mov rsi,b32
        mov rdx,b_size
        syscall
        mov rax,1; imprime b33
        mov rdi,1
        mov rsi,b33
        mov rdx,b_size
        syscall
        mov rax,1; imprime b34
        mov rdi,1
        mov rsi,b34
        mov rdx,b_size
        syscall
        mov rax,1; imprime b35
        mov rdi,1
        mov rsi,b35
        mov rdx,b_size
        syscall
        mov rax,1; imprime b36
        mov rdi,1
        mov rsi,b36
        mov rdx,b_size
        syscall;-------------------------------------

	mov rax,1; 
        mov rdi,1
        mov rsi,salir
        mov rdx,salir_size
        syscall

	mov rax,60
	mov rdi,0
	syscall
