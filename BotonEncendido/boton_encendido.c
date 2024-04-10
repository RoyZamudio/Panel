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

    while(true){

    }

}