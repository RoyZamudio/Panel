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
    push {r7, lr}   @ Guardar los registros r7 y lr en la pila
    sub  sp, 16     @ Reservar espacio en la pila para las variables locales
    add  r7, sp, 0     @ Asignar la dirección de la pila al registro r7

    @ stdio_init_all();
    bl  stdio_init_all  @ Inicializar todas las funciones de E/S estándar

    @ gpio_init(BUTTON_PIN);
    movs r0, BUTTON_PIN
    bl   gpio_init       @ Inicializar el pin del botón

    @ gpio_set_dir(BUTTON_PIN, GPIO_IN);
    movs    r1, 0           @ Cargar el valor 0 en r1 (GPIO_IN)
    movs    r0, BUTTON_PIN @ Cargar el valor de BUTTON_PIN en r0
    bl      gpio_set_dir_wrapper  @ Configurar la dirección del pin del botón

    @ gpio_pull_up(BUTTON_PIN);
    movs    r0, BUTTON_PIN @ Cargar el valor de BUTTON_GPIO en r0
    bl      gpio_pull_up_wrapper  @ Activar la resistencia pull-up en el pin del botón

    @ gpio_init(LED_PIN);
    movs r0, LED_PIN
    bl   gpio_init  @ Inicializar el pin del LED

    @ gpio_set_dir(LED_PIN, GPIO_OUT);
    movs    r1, 1           @ Cargar el valor 0 en r1 (GPIO_IN)
    movs    r0, LED_PIN @ Cargar el valor de BUTTON_PIN en r0
    bl      gpio_set_dir_wrapper  @ Configurar la dirección del pin del led

    @ bool led_encendido = false;
    movs r3, 0 @ Cargar el valor 0 (false) a r3
    str r3, [r7, 0] @ Almacenar el valor de r3 en la pila

@ Bucle while
LW:
    @bool boton_oprimido !gpio_get(BUTTON_PIN)) 
    movs    r0, BUTTON_PIN @ Cargar el valor de BUTTON_PIN en r1
    bl      gpio_get_wrapper  @ Llamar a la función gpio_get_wrapper
    mvns    r3, r0           @ Invertir el estado del botón (activo bajo)
    str     r3, [r7, 4]
    @ Comprobar si el botón está pulsado (estado invertido)
    ldr     r3, [r7, 4]       @ Cargar el estado del botón desde la pila
    cmp     r3, 1
    bne     LW                 @ Repetir si el botón no está pulsado
    @ Cambiar el estado del LED
    @ led_encendido = !led_encendido
    ldr     r3, [r7, 0]       @ Cargar el estado del LED desde la pila
    movs    r4, 1
    mvns    r0, r4
    ands    r3, r3, r0
    str     r3, [r7, 0]       @ Almacenar el nuevo estado del LED en la pila
    @ Encender o apagar el LED
    @ gpio_put(LED_PIN, led_encendido)
    ldr     r1, [r7, 0]       @ Cargar el estado del LED desde la pila
    movs    r0, LED_PIN
    bl      gpio_put_wrapper  @ Encender o apagar el LED según el estado
    @ sleep_ms(500)
    ldr     r0, DELAY         @ Cargar el valor de DELAY en r0
    bl      sleep_ms          @ Llamar a la función sleep_ms
    b       LW   
    @ Volver al inicio del bucle while (L2)
    b LW

.align 4
DELAY: .word 500  @ Definir la constante DELAY con valor 500 (ms)