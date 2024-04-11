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
    sub  sp, 8     @ Reservar espacio en la pila para las variables locales
    mov  r7, sp     @ Asignar la dirección de la pila al registro r7

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
L2:
    @bool boton_oprimido !gpio_get(BUTTON_PIN)) 
    movs    r1, BUTTON_PIN @ Cargar el valor de BUTTON_PIN en r1
    bl      gpio_get_wrapper  @ Llamar a la función gpio_get_wrapper
    mvns     r0, r1           @ Invertir el estado del botón (activo bajo)
    @ if (boton_oprimido)
    cmp     r0, 1           @ Comparar el resultado con 1
    bne     L1
    @ if (led_encendido) 
    ldr     r3, [r7, 0]
    cmp     r3, 1
    bne     L3
    @ gpio_put(LED_PIN, 0);
    movs    r2, 0
    movs    r1, LED_PIN
    bl      gpio_put_wrapper
    @ led_encendido = false;
    movs    r0, 0
    str     r0, [r7, 0]
    b       L1
L3:
    @else gpio_put(LED_PIN, 1);
    movs    r2, 1
    movs    r1, LED_PIN
    bl      gpio_put_wrapper
    @ led_encendido = true;
    movs    r0, 1
    str     r0, [r7, 0]
L1:
    @ sleep_ms(500);
    ldr     r0, DELAY       @ Cargar el valor de la constante DELAY en r0
    bl      sleep_ms        @ Llamar a la función sleep_ms
    @ Volver al inicio del bucle while (L2)
    b L2

.align 4
DELAY: .word 500  @ Definir la constante DELAY con valor 500 (ms)