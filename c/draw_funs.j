# Placed in public domain.

draw_funs_lib = dlopen("c/draw_funs")

finalize_draw() = ccall(dlsym(draw_funs_lib, :finalize_draw), Int32, ())

function draw_planet(index,x,y,r) 
  ccall(dlsym(draw_funs_lib, :draw_system), 
        Int32, (Int32,Float32,Float32,Float32), 
        int32(index),float32(x),float32(y),float32(r))
end

color (r,g,b) = ccall(dlsym(draw_funs_lib, :color), Int32, (Int8,Int8,Int8), 
                      int8(r),int8(g),int8(b))
color (r,g,b,a) = ccall(dlsym(draw_funs_lib, :colora), Int32, 
                        (Int8,Int8,Int8,Int8), 
                        int8(r),int8(g),int8(b), int8(a))

vertex(x,y) = ccall(dlsym(draw_funs_lib, :vertex), Int32, (Float64,Float64), 
                    float64(x),float64(y))
vertex (v::Vector) = vertex(v[1],v[2])
vertex(obj) = vertex(pos(obj))

gl_begin_lines () = ccall(dlsym(draw_funs_lib, :gl_begin_lines), Int32, ())
gl_begin_points () = ccall(dlsym(draw_funs_lib, :gl_begin_points), Int32, ())
gl_begin_line_strip () = ccall(dlsym(draw_funs_lib, :gl_begin_line_strip), 
                               Int32, ())
gl_end ()   = ccall(dlsym(draw_funs_lib, :gl_end), Int32, ())

gl_scale(x,y,z) = ccall(dlsym(draw_funs_lib, :gl_scale, Int32, 
                              (Float64,Float64,Float64), x,y,z))