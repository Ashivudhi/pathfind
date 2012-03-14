#!/bin/bash
rm stuff_init.so draw_funs.so

gcc -shared stuff_init.c -fPIC \
    -o stuff_init.so -std=c99 -lGL -lGLU -lm `sdl-config --cflags --libs`

gcc -shared draw_funs.c -fPIC \
    -o draw_funs.so -std=c99 -lGL -lGLU -lm `sdl-config --cflags --libs`
