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

    while(true){
        // Leer el estado del botón (activo bajo debido al pull-up)
        bool boton_pulsado = !gpio_get(BUTTON_PIN);

        // Si el botón está pulsado y el LED está apagado, encender el LED
        if(boton_pulsado && !led_encendido){
            gpio_put(LED_PIN, 1);   // Encender el LED
            led_encendido = true;   // Actualizar el estado del LED a encendido
        }

        // Si el botón está pulsado y el LED está encendido, apagar el LED
        if(boton_pulsado && led_encendido){
            gpio_put(LED_PIN, 0);   // Apagar el LED
            led_encendido = false;  // Actualizar el estado del LED a apagado
        }
    }
}