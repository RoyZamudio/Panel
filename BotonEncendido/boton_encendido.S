@ Directivas minimas
.text 
.align 1  
.global main  
.syntax unified 
.thumb_func

.equ BUTTON_GPIO, 2 @ #define BUTTON_PIN 2
.equ LED_GPIO, 3 @ #define LED_PIN 3

@ Este código controla mediante un botón PUSH un LED. Si se oprime una vez, el LED se encienda, y si se presiona nuevamente, se apaga.

main:
    @prologo 
    push {r7, lr}   @ Guardar los registros r7 y lr en la pila
    sub  sp, 16      @ Reservar espacio en la pila para las variables locales
    mov  r7, sp     @ Asignar la dirección de la pila al registro r7

    @ stdio_init_all();
    bl  stdio_init_all  @ Inicializar todas las funciones de E/S estándar

    @ gpio_init(BUTTON_GPIO);
    movs r0, BUTTON_GPIO
    bl   gpio_init       @ Inicializar el pin del botón

    @ gpio_set_dir(BUTTON_GPIO, GPIO_IN);
    movs    r1, 0           @ Cargar el valor 0 en r1 (GPIO_IN)
    movs    r0, BUTTON_GPIO @ Cargar el valor de BUTTON_PIN en r0
    bl      gpio_set_dir_wrapper  @ Configurar la dirección del pin del botón

    @ gpio_pull_up(BUTTON_PIN);
    movs    r0, BUTTON_GPIO @ Cargar el valor de BUTTON_GPIO en r0
    bl      gpio_pull_up_wrapper  @ Activar la resistencia pull-up en el pin del botón

    @ gpio_init(LED_GPIO);
    movs r0, LED_GPIO
    bl   gpio_init  @ Inicializar el pin del LED

    @ gpio_set_dir(LED_GPIO, GPIO_OUT);
    movs    r1, 1           @ Cargar el valor 0 en r1 (GPIO_IN)
    movs    r0, LED_GPIO @ Cargar el valor de BUTTON_PIN en r0
    bl      gpio_set_dir_wrapper  @ Configurar la dirección del pin del led

    @ bool led_encendido = false;
    movs r3, 0 @ Cargar el valor 0 (false) a r3
    str r3, [r7, 0] @ Almacenar el valor de r3 en la pila

@ Bucle while
L1:
    @ Leer el estado del botón y asignar a boton_oprimido
    movs    r0, BUTTON_GPIO   @ Cargar el valor de BUTTON_GPIO en r0
    bl      gpio_get_wrapper  @ Llamar a la función gpio_get_wrapper
    str     r0, [r7, 8]       @ Almacenar el estado del botón en la pila

    @ Comprobar si el botón está pulsado
    ldr     r0, [r7, 8]
    cmp     r0, 0
    bne     L2                @ Saltar a L2 si el botón está pulsado

    @ Botón no pulsado: Establecer boton_oprimido a true (1)
    movs    r3, 1
    str     r3, [r7, 4]
    b       L3                @ Saltar a L3

L2:
    @ Botón pulsado: Establecer boton_oprimido a false (0)
    movs    r3, 0
    str     r3, [r7, 4]

L3:
    @ Comprobar si el botón está pulsado (estado invertido)
    ldr     r3, [r7, 4]       @ Cargar el estado del botón desde la pila
    cmp     r3, 1
    bne     L1                 @ Repetir si el botón no está pulsado

    @ Cambiar el estado del LED
    @ Leer el estado actual del LED (led_encendido)
    ldr     r3, [r7, 0]
    cmp     r3, 0
    bne     L4                @ Saltar a L4 si el LED está encendido

    @ LED apagado: Establecer led_encendido a true (1)
    @ printf("Lavadora encendida");
    ldr     r0, =MSG1       @ Cargar la dirección de la cadena de caracteres en r0
    bl      printf          @ Llamar a la función printf
    movs    r4, 1
    str     r4, [r7, 0]
    b       L5                @ Saltar a L5

L4:
    @ LED encendido: Establecer led_encendido a false (0)
    @ printf("Lavadora apagada");
    ldr     r0, =MSG2       @ Cargar la dirección de la cadena de caracteres en r0
    bl      printf          @ Llamar a la función printf
    ldr     r3, [r7, 0]
    movs    r3, 0
    str     r3, [r7, 0]

L5:
    @ Encender o apagar el LED
    @ Cargar el estado del LED desde la pila
    ldr     r1, [r7, 0]
    movs    r0, LED_GPIO
    bl      gpio_put_wrapper  @ Encender o apagar el LED según el estado

    @ Esperar 500 ms
    ldr     r0, DELAY         @ Cargar el valor de DELAY en r0
    bl      sleep_ms          @ Llamar a la función sleep_ms

    @ Volver al inicio del bucle while (L1)
    b L1

.align 4
DELAY: .word 500  @ Definir la constante DELAY con valor 500 (ms)
MSG1: .ascii "Lavadora encendida\012\000"
MSG2: .ascii "Lavadora apagada\012\000"