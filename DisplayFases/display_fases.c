#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"

#define PRIMER_GPIO 2
#define BOTON_GPIO1 11 // Botón para la animación circular
#define BOTON_GPIO2 12 // Botón para la animación de infinito
#define BOTON_GPIO3 13 // Botón para la animación 'S'

// Arreglos para definir las diferentes secuencias para cada botón
int secLavar[4] = {0x01, 0x22, 0x14, 0x08};                             //Secuencia como en cascáda       
int secEnjuagar[8] = {0x01, 0x02, 0x40, 0x10, 0x08, 0x04, 0x40, 0x20 };  // Secuencia de animación de infinito
int secCentrifugar[6] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20};       // Secuencia de animación circular


int main() {
    stdio_init_all();
    
    printf("Control de secuencia en display de 7 segmentos\n");

    // Configurar GPIOs para segmentos y botones
    for (int gpio = PRIMER_GPIO; gpio < PRIMER_GPIO + 7; gpio++) {
        gpio_init(gpio);
        gpio_set_dir(gpio, GPIO_OUT);
        gpio_set_outover(gpio, GPIO_OVERRIDE_INVERT);
    }

    gpio_init(BOTON_GPIO1);
    gpio_set_dir(BOTON_GPIO1, GPIO_IN);
    gpio_pull_up(BOTON_GPIO1); // Activar pull-up en el botón

    gpio_init(BOTON_GPIO2);
    gpio_set_dir(BOTON_GPIO2, GPIO_IN);
    gpio_pull_up(BOTON_GPIO2); // Activar pull-up en el botón

    gpio_init(BOTON_GPIO3);
    gpio_set_dir(BOTON_GPIO3, GPIO_IN);
    gpio_pull_up(BOTON_GPIO3); // Activar pull-up en el botón

    int indice1 = 0;
    int indice2 = 0;
    int indice3 = 0;

    while (true) {
        if (!gpio_get(BOTON_GPIO1)) {
            // Botón de secuencia de lavar presionado
            int32_t mascara = secLavar[indice1 % 4] << PRIMER_GPIO;
            gpio_set_mask(mascara);      // Activar segmentos según la máscara
            sleep_ms(250);               // Esperar un tiempo
            gpio_clr_mask(mascara);      // Apagar segmentos
            indice1++;                   // Avanzar al siguiente paso de la secuencia
        } else if (!gpio_get(BOTON_GPIO2)) {
            // Botón de secuencia de enjuagar presionado
            int32_t mascara = secEnjuagar[indice2 % 8] << PRIMER_GPIO;
            gpio_set_mask(mascara);      // Activar segmentos según la máscara
            sleep_ms(250);               // Esperar un tiempo
            gpio_clr_mask(mascara);      // Apagar segmentos
            indice2++;                   // Avanzar al siguiente paso de la secuencia
        } else if (!gpio_get(BOTON_GPIO3)) {
            // Botón de secuencia de centrifugar presionado
            int32_t mascara = secCentrifugar[indice3 % 6] << PRIMER_GPIO;
            gpio_set_mask(mascara);      // Activar segmentos según la máscara
            sleep_ms(250);               // Esperar un tiempo
            gpio_clr_mask(mascara);      // Apagar segmentos
            indice3++;                   // Avanzar al siguiente paso de la secuencia
        }
    }
}
