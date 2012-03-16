# Placed in public domain.

draw_funs_lib = dlopen("c/draw_funs")

@get_c_fun draw_funs_lib auto finalize_draw()::Int32

@get_c_fun draw_funs_lib draw_planet draw_system(index::Int32,x::Float32,y::Float32,r::Float32)::Int32
@get_c_fun draw_funs_lib color color(r::Int8,g::Int8,b::Int8)::Int32
@get_c_fun draw_funs_lib color colora(r::Int8,g::Int8,b::Int8,a::Int8)::Int32

@get_c_fun draw_funs_lib vertex vertex(Float64,Float64)::Int32
vertex (v::Vector) = vertex(v[1],v[2])
vertex(obj) = vertex(pos(obj))

#@get_c_fun draw_funs_lib auto gl_begin_lines()::Int32
#@get_c_fun draw_funs_lib auto gl_begin_points()::Int32
#@get_c_fun draw_funs_lib auto gl_begin_line_strip()::Int32
#@get_c_fun draw_funs_lib auto gl_end()::Int32
#@get_c_fun draw_funs_lib auto gl_scale(Float64,Float64,Float64)::Int32

@get_c_fun_list draw_funs_lib begin
  gl_begin_lines()::Int32
  gl_begin_points()::Int32
  gl_begin_line_strip()::Int32
  gl_end()::Int32
  gl_scale(Float64,Float64,Float64)::Int32
end
