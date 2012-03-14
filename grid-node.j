##  Copyright (C) 14-03-2012 Jasper den Ouden.
##
##  This is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published
##  by the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##

type GridSqr
  pos::Vector{Int16}
  mark::Int32
  cost::Float32 
end

type World
  array::Array{GridSqr,2}
  wrap::Bool
end

function World(w,h, wrap)
  ret = World(Array(GridSqr,w,h), wrap)
  for i = 1:w
    for j = 1:h
      ret.array[i,j] = GridSqr([int16(i),int16(j)], int32(-1), float32(0.0))
    end
  end
  return ret
end
World(w,h) = World(w,h, false)

distance(a::GridSqr, b::GridSqr) = dist(a.pos,b.pos)

function node_connects (node::GridSqr, world)
  w,h = size(world.array)
  i,j = (node.pos[1],node.pos[2])
  list = Array(GridSqr,0)
  function may_push(i,j)
    if 1 <= i<= w &&  1 <= j<= h
      return push( list, world.array[i,j] )
    end
    if world.wrap
      assert(false, "Disabled during testing, not using wrap atm.")
      return push( list, world.array[i%w,j%h] )
    end
  end
  may_push(i-1,j-1)
  may_push(i,j-1)
  may_push(i+1,j-1)
  may_push(i-1,j)
  may_push(i+1,j)
  may_push(i-1,j+1)
  may_push(i,j+1)
  may_push(i+1,j+1)
  return list
end

edge_cost(a::GridSqr,b::GridSqr) = norm(a.pos - b.pos)
