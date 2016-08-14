%macro imprimir 2 				;recibe 2 parametros
	mov rax,1					;sys_write
	mov rdi,1					;std_out
	mov rsi,%1					;primer parametro: caracteres especiales para limpiar la pantalla
	mov rdx,%2					;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------


section .bss ; $Revision: 1.6 $
family		resd	48

section .data
cons_salto: db 0xa


section .text
	global _start		;Definicion del punto de partida

_start:
	
	mov eax,80000002h
	cpuid
	mov [family], eax
	mov [family+4], ebx
	mov [family+8], ecx
	mov [family+12], edx

	mov eax,80000003h
	cpuid
	mov [family+16], eax
	mov [family+20], ebx
	mov [family+24], ecx
	mov [family+28], edx

	mov eax,80000004h
	cpuid
	mov [family+32], eax
	mov [family+36], ebx
	mov [family+40], ecx
	mov [family+44], edx
	

	
	imprimir family,48
	imprimir cons_salto,1




salida:
	;Ultimo paso: Salida del programa
	mov rax,60						;se carga la llamada 60d (sys_exit) en rax
	mov rdi,0							;en rdi se carga un 0
	syscall								;se llama al sistema.



;fin del programa
;##############################################	
