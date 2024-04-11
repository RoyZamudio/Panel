cmake_minimum_required(VERSION 3.13)

add_executable(BotonEncendido
    boton_encendido.c
)

target_link_libraries(BotonEncendido pico_stdlib)

pico_add_extra_outputs(BotonEncendido)