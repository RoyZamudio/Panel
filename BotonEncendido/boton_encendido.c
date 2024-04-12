#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"

#define BUTTON_PIN 1
#define LED_PIN 2

int main() {
    // Inicialización del sistema de entrada/salida estándar
    stdio_init_all();

    // Inicialización del pin del botón como entrada con pull-up
    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_up(BUTTON_PIN);

    // Inicialización del pin del LED como salida
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    bool led_encendido = false; // Variable para rastrear el estado del LED

    while (true) {
        // Leer el estado del botón
        bool boton_pulsado = !gpio_get(BUTTON_PIN);

        if (boton_pulsado) {
            // Cambiar el estado del LED
            led_encendido = !led_encendido;
            gpio_put(LED_PIN, led_encendido); // Encender o apagar el LED
            sleep_ms(500); // Pequeña pausa para evitar rebotes
        }
    }
}
