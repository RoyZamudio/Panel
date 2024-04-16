@ Directivas minimas
.text 
.align 1  
.global main  
.syntax unified 
.thumb_func

.equ PRIMER_GPIO, 2 @ #define PRIMER_GPIO 2
.equ BOTON_GPIO1, 11 @ #define BOTON_GPIO1 11 // Botón para la animación circular
.equ BOTON_GPIO2, 12 @ #define BOTON_GPIO2 12 // Botón para la animación de infinito
.equ BOTON_GPIO3, 13 @ #define BOTON_GPIO3 13 // Botón para la animación 'S'

main:


.align 4
DELAY: .word 250  @ Definir la constante DELAY con valor 250 (ms)

.section      .rodata
.align 2

@ int secLavar[4] = {0x01, 0x22, 0x14, 0x08}
LAVAR:
    .word 0x01
    .word 0x22
    .word 0x14
    .word 0x88

@ int secEnjuagar[8] = {0x01, 0x02, 0x40, 0x10, 0x08, 0x04, 0x40, 0x20}
ENJUAGAR:
    .word 0x01
    .word 0x02
    .word 0x40
    .word 0x10
    .word 0x08
    .word 0x04
    .word 0x40
    .word 0x20

@ int secCentrifugar[6] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20}
CENTRIFUGAR:
    .word 0x01
    .word 0x02
    .word 0x04
    .word 0x08
    .word 0x10
    .word 0x20