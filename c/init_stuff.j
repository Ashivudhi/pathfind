
stuff_lib = dlopen("c/stuff_init")
init_stuff() = ccall(dlsym(stuff_lib, :init_stuff), Int32, ())
