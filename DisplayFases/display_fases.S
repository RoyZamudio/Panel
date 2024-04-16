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
    @ Prólogo
    push    {r7, lr}   @ Guardar los registros r7 y lr en la pila
    sub     sp, 96     @ Reservar espacio en la pila para las variables locales
    mov     r7, sp     @ Asignar la dirección de la pila al registro r7
    @ Inicialización de LAVAR

    @ Inicialización de ENJUAGAR

    @ Inicialización de CENTRIFUGAR

    @ stdio_init_all()

    @ for (int gpio = PRIMER_GPIO; gpio < PRIMER_GPIO + 7; gpio++) {
    @ int gpio = PRIMER_GPIO

    @ Cuerpo
L2:
    @ gpio_init(gpio)

    @ gpio_set_dir(gpio, GPIO_OUT)

    @ gpio_set_outover(gpio, GPIO_OVERRIDE_INVERT)

    @ gpio++

L1: 
    @ gpio < PRIMER_GPIO + 7

    @ gpio_init(BOTON_GPIO1)

    @ gpio_set_dir(BOTON_GPIO1, GPIO_IN)

    @ gpio_pull_up(BOTON_GPIO1) 

    @ gpio_init(BOTON_GPIO2)

    @ gpio_set_dir(BOTON_GPIO2, GPIO_IN)

    @ gpio_pull_up(BOTON_GPIO2)

    @ gpio_init(BOTON_GPIO3)

    @ gpio_set_dir(BOTON_GPIO3, GPIO_IN)

    @ gpio_pull_up(BOTON_GPIO3)

    @ int boton_previo = 0

    @ int boton_actual = 0

    @ bool ejecutando = false

    @ Bucle While
LW:
    @ if (!gpio_get(BOTON_GPIO1)) {
            
    @ boton_actual = 1;

    @ else if (!gpio_get(BOTON_GPIO2)) {
    
    @ boton_actual = 2;

    @ else if (!gpio_get(BOTON_GPIO3)) {
    
    @boton_actual = 3;
    
L5:
    @ if (boton_actual != boton_actual) {

    @ boton_previo = boton_actual

    @ ejecutando = false

    @ while (!gpio_get(boton_actual == 1 ? BOTON_GPIO1 : boton_actual == 2 ? BOTON_GPIO2 : BOTON_GPIO3)) {}

    @ if (ejecutando)
     @ Caso Botón Lavar

    
    @ Caso Botón Enjuagar


    @ Caso Botón Centrifugar

    @ else pio_clr_mask((1 << 7) - 1 << PRIMER_GPIO);

    @ ejecutando = true


    b LW

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