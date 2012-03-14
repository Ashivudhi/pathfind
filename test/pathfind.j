##  Copyright (C) 14-03-2012 Jasper den Ouden.
##
##  This is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published
##  by the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##

load("distance.j")

load("node.j")
load("grid-node.j")
#load("node-utils.j")

load("pathfind.j")
load("various.j")

add_node(list, v) = push(list,Node(0,float32(0),v))
add_random_node(list) = add_node(list, [2*rand()-1,2*rand()-1])

dist(a::Node,b::Node) = dist(a.obj, b.obj)

edge_cost(a,b) = dist(a,b)

function add_random_connection (list::Array{Any,1})
  (from,to) = rand_2_from_list(list)
  if node_connect_p(from,to) #TODO crazy situation check.
    add_random_connection(list)
  else
    node_connect(from, to)
  end
end

#Pathfinds randomly.
function rand_journey (list)
  return rand_2_from_list(list)
end
function rand_journey(world::World)
  w,h = size(world.array)
  ia,ja = (randi(w),randi(h))
  ib,jb = (randi(w),randi(h))
  if ia ==ib && ja == jb
    return rand_journey(world)
  end
  return (world.array[ia,ja], world.array[ib,jb])
end

function rand_pathfind (world, cur_mark)
  from,to = rand_journey(world)
  return pathfind(from,to, cur_mark,world)
end

load("c/init_stuff.j")
load("c/draw_funs.j")

#TODO indicate time since last draw somewhat?
function draw_node_edges (node) 
  gl_begin_lines()
  for n = node.connect
    vertex(node) 
    vertex(n)
  end
  gl_end()
end
draw_node_edges (nodes::Vector) = map(draw_node_edges, nodes)

draw_node (node) = draw_planet(0, node.obj[1],node.obj[2], 0.03)
draw_node (nodes::Vector) = map(draw_node, nodes)

function draw_all (nodes::Vector)
  color(127,127,127)
  draw_node_edges(nodes)
  color(0,0,127)
  draw_node(nodes)
end

function draw_all (world::World)
  w,h = size(world.array)
  color(127,127,127)
  gl_begin_points()
  for i = 1:w
    for j = 1:h
      vertex(-1+2*i/w, -1+2*j/h)
    end
  end
  gl_end()
end

pos(node::Node) = node.obj

node_vertex(node::Node) = vertex(node.obj)
node_vertex(node::GridSqr) = vertex(-1 + 2*node.pos[1]/10,-1+2*node.pos[2]/10)

function draw_node_sequence (seq)
  color(127,0,0)
  gl_begin_line_strip()
    map(node_vertex, seq)
  gl_end()
end

#TODO these arent very challenging to pathfind with..
function gen_node_list (node_cnt,connection_cnt)
  list = Array(Node,0) #Randomly filled list.
  for i = 1:node_cnt
    add_random_node(list)
  end
  for i = 1:connection_cnt
    add_random_connection(list)
  end
  return list
end
gen_node_list() = gen_node_list(20,20)

function gen_node_grid (w,h)
  list = Array(Node,0)
  for j = 1:h
    for i = 1:w
      add_node(list, [2*i/w-1, 2*j/h-1])
    end
  end
  for i = 1:w-1
    for j = 1:h-1
      node_connect(list[i+w*(j-1)],list[i+1+w*(j-1)])
      node_connect(list[i+w*(j-1)],list[i+w*j])
      node_connect(list[i+w*(j-1)],list[i+1+w*j])
    end
  end
  return list
end

function run_test (newpath_interval, world)
  init_stuff()
  cur_mark = int32(0)
  next_draw = time() -1
  path = {}
  while (true)
    draw_all(world)
    if path != nothing
      draw_node_sequence(path)
    end
    finalize_draw()
    if time() > next_draw
      path = rand_pathfind(world, cur_mark)
      if path==nothing
        print("no path $cur_mark \n")
      else
        print("got path $cur_mark \n")
      end
      cur_mark = int32(cur_mark + 1)
      next_draw = time() + newpath_interval
    end
  end
end
