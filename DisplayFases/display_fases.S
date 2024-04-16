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