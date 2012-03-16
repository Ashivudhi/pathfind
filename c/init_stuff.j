
stuff_lib = dlopen("c/stuff_init")

@get_c_fun stuff_lib auto init_stuff()::Int32
