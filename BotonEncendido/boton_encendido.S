@ Directivas minimas
.text 
.align 1  
.global main  
.syntax unified 
.thumb_func

.equ BUTTON_PIN, 1 @ #define BUTTON_PIN 1
.equ LED_PIN, 2 @ #define LED_PIN 2

main:
    @prologo 
    push    {r7, lr}   @ Guardar los registros r7 y lr en la pila
    sub     sp, 8     @ Reservar espacio en la pila para las variables locales
    mov     r7, sp     @ Asignar la dirección de la pila al registro r7