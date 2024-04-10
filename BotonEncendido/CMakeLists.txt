cmake_minimum_required(VERSION 3.13)

add_executable(BotonEncendido
    boton_encendido.c
)

target_link_libraries(BotonEncendido pico_stdlib)

pico_enable_stdio_usb(BotonEncendido 1)
pico_enable_stdio_uart(BotonEncendido 0)

pico_add_extra_outputs(BotonEncendido)