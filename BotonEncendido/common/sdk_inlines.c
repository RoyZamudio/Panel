#include <stdint.h>
#include <stdbool.h>
#include "hardware/gpio.h"

void gpio_set_dir_wrapper(unsigned gpio, bool out){
    gpio_set_dir(gpio, out);
}

void gpio_pull_up_wrapper(unsigned gpio){
    gpio_pull_up(gpio);
}

bool gpio_get_wrapper(unsigned gpio){
    return gpio_get(gpio);
}

void gpio_put_wrapper(unsigned gpio, bool out){
    gpio_put(gpio, out);
}