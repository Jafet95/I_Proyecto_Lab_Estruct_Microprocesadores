;##############################################
;Movimiento de la plataforma
;EL4313 - Laboratorio de Estructura de Microprocesadores
;2S2016-LCRA
;##############################################
;Este codigo se va a encargar de realizar el movimiento de la plataforma
;##############################################

;--------------------Segmento de datos--------------------
;Aqui se declaran las etiquetas de uso frecuente en el programa

section .data
        cons_prep: db 27,"[2J"
        cons_sz_prep: equ 4

        cons_erasep: db 27,"[35;00H",27,"[2K"
        cons_sz_erasep: equ 12

        cons_salida: db 27,"[2J",27,"[00;00H"
        cons_sz_salida: equ 12

        cons_espacio: db '  ' ;espacio a la izquierda de la plataforma 
        cons_sz_espacio: equ $-cons_espacio
        
        cons_plataforma: db 27,"[1;37m",'<========>',0xa
        cons_sz_plataforma: equ $-cons_plataforma      ; Longitud del banner
        
        mov_plataforma: db 30
        tecla:  db''   
        
        termios: times 36 db 0                   ;Estructura de 36bytes que contiene el modo de operacion de la consola
        stdin: equ 0                             ;Standard Input (se usa stdin en lugar de escribir manualmente los valores)
        ICANON: equ 1<<1                         ;ICANON: Valor de control para encender/apagar el modo canonico
        ECHO: equ 1<<3                           ;ECHO: Valor de control para encender/apagar el modo de eco

;--------------------Declaracion de funciones y utilidades ---------------------------------------------

;####################################################
;canonical_off
;Esta es una funcion que sirve para apagar el modo canonico en Linux
;Cuando el modo canonico se apaga, Linux NO espera un ENTER para
;procesar lo que se captura desde el teclado, sino que se hace de forma
;directa e inmediata
;
;Para apagar el modo canonico, simplemente use: call canonical_off
;###################################################
canonical_off:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de ICANON en EAX, para apagar el modo canonico
        push rax
        mov eax, ICANON
        not eax
        and [termios+12], eax
        pop rax

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;echo_off
;Esta es una funcion que sirve para apagar el modo echo en Linux
;Cuando el modo echo se apaga, Linux NO muestra en la pantalla la tecla que
;se acaba de presionar.
;
;Para apagar el modo echo, simplemente use: call echo_off
;###################################################
echo_off:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de ECHO en EAX para apagar el echo
        push rax
        mov eax, ECHO
        not eax
        and [termios+12], eax
        pop rax

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;canonical_on
;Esta es una funcion que sirve para encender el modo canonico en Linux
;Cuando el modo canonico se enciende, Linux espera un ENTER para
;procesar lo que se captura desde el teclado
;
;Para encender el modo canonico, simplemente use: call canonical_on
;###################################################
canonical_on:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo Canonico
        or dword [termios+12], ICANON

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;echo_on
;Esta es una funcion que sirve para encender el echo en Linux
;Cuando el echo se enciende, Linux muestra en la pantalla (stdout) cada tecla
;que se recibe del teclado (stdin)
;
;Para encender el modo echo, simplemente use: call echo_on
;###################################################
echo_on:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo echo
        or dword [termios+12], ECHO

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;read_stdin_termios
;Esta es una funcion que sirve para leer la configuracion actual del stdin o 
;teclado directamente de Linux
;Esta configuracion se conoce como TERMIOS (Terminal Input/Output Settings)
;Los valores del stdin se cargan con EAX=36h y llamada a la interrupcion 80h
;
;Para utilizarlo, simplemente se usa: call read_stdin_termios
;###################################################
read_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5401h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion
;###################################################


;####################################################
;write_stdin_termios
;Esta es una funcion que sirve para escribir la configuracion actual del stdin o 
;teclado directamente de Linux
;Esta configuracion se conoce como TERMIOS (Terminal Input/Output Settings)
;Los valores del stdin se cargan con EAX=36h y llamada a la interrupcion 80h
;
;Para utilizarlo, simplemente se usa: call write_stdin_termios
;###################################################
write_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5402h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion
;###################################################

;---------------------------------------------------------------------------




;--------------------Segmento de codigo--------------------
;Secuencia de ejecucion del programa

section .text
        global _start           ;Definicion del punto de partida

_start:
        call canonical_off
        call echo_off
        mov r10,25
        ;Limpiamos la consola 
        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,cons_prep                             ;rsi = mensaje a imprimir
        mov rdx,cons_sz_prep                          ;rdx=tamano del string
        syscall                                        ;llamar al sistema
_refresh_plataforma:
        ;Primer paso: Imprimir la plataforma
        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,cons_erasep                             ;rsi = mensaje a imprimir
        mov rdx,cons_sz_erasep                          ;rdx=tamano del string
        syscall                                        ;llamar al sistema
        
        mov r9,1
_espacios:
        cmp r10,r9
        je _plataforma
        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,cons_espacio                            ;rsi = mensaje a imprimir
        mov rdx,cons_sz_espacio                            ;rdx=tamano del string
        syscall                                                         ;Llamar al sistema
        inc r9                                                         ;se incrementa rbx en 1
        jmp _espacios                                           ;regresa a .espacios


        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,mov_plataforma                         ;rsi = mensaje a imprimir
        mov rdx,1                                             ;rdx=tamano del string
        syscall                                                         ;Llamar al sistema



_plataforma:

        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,cons_plataforma                         ;rsi = mensaje a imprimir
        mov rdx,cons_sz_plataforma                      ;rdx=tamano del string
        syscall                                                         ;Llamar al sistema


_read_tecla:
        ;Segundo paso: Capturar una tecla presionada en el teclado
        mov rax,0                                                       ;rax = "sys_read"
        mov rdi,0                                                       ;rdi = 0 (standard input = teclado)
        mov rsi,tecla                                   ;rsi = direccion de memoria donde se almacena la tecla capturada
        mov rdx,1                                                       ;rdx=1 (cuantos eventos o teclazos capturar)
        syscall                                                         ;Llamar al sistema

        ;Tercer paso: comparar la tecla con el movimiento a la izquierda/derecha
        mov r8,[tecla]                                                 ;rax = tecla capturada
        mov r9,'z'                                ;rbx = constante de movimiento a la izquierda
        cmp r8,r9                                                             ;comparacion
        je _izquierda                                                   ;salto a .izquierda
        mov r9,'c'                                 ;rbx = constante de movimiento a la derecha
        cmp r8,r9                                                            ;comparacion
        je _derecha                                                     ;salto a .derecha
        mov r9,'x'
        cmp r8,r9
        je _salida
        mov [tecla],rax
        jne _read_tecla

_izquierda:
        cmp r10,3
        je _read_tecla
        dec r10
        mov [tecla],rax
        jmp _refresh_plataforma

_derecha:
        cmp r10,50
        je _read_tecla
        inc r10
        mov [tecla],rax
        jmp _refresh_plataforma


        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,cons_espacio                        ;rsi = mensaje a imprimir
        mov rdx,cons_sz_espacio                  ;rdx=tamano del string
        syscall                                                         ;Llamar al sistema

        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,tecla                        ;rsi = mensaje a imprimir
        mov rdx,1                      ;rdx=tamano del string
        syscall                                                         ;Llamar al sistema



_salida:
        call canonical_on
        call echo_on
        mov rax,1                                                       ;rax = "sys_write"
        mov rdi,1                                                       ;rdi = 1 (standard output = pantalla)
        mov rsi,cons_salida                               ;rsi = mensaje a imprimir
        mov rdx,cons_sz_salida                            ;rdx=tamano del string
        syscall                                        ;llamar al sistema
        ;Ultimo paso: Salida del programa
        mov rax,60                                              ;se carga la llamada 60d (sys_exit) en rax
        mov rdi,0                                                       ;en rdi se carga un 0
        syscall                                                         ;se llama al sistema.

;fin del programa
;############################################## 
