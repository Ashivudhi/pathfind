##  Copyright (C) 14-03-2012 Jasper den Ouden.
##
##  This is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published
##  by the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##

edge_cost(a,b) = 1 #A bad default.

isless(a,b) = (a.cost < b.cost)

function node_add_result (to, result)
  push(to, result) #TODO better.
  sortr!(to)
end
#We better reset, or have covered all the nodes 'accidentally' before we 
# reach 2^32 ~ 4.3*10^9
#Takes one step in pathfinding.
function pathfind_step (results,cur, goal, edge_cost_var, cur_mark, world)
  for n = node_connects(cur,world)
    if n==goal
      return cur
    end
    if n.mark != cur_mark
      n.mark = cur_mark
      n.cost = cur.cost + edge_cost_var(cur,n)
      node_add_result(results, n)
    end
  end
  return nothing
end
#Tracks forward the path.
function pathfind (from,goal, edge_cost_var, cur_mark,world)
  cur_mark = int32(cur_mark+1)
  results = {from}
  latest = nothing
  while latest==nothing
    if isempty(results)
      return nothing
    end
    latest = pathfind_step(results, pop(results),goal, edge_cost_var,
                           cur_mark,world)
  end
#  @assert latest == goal #We aught to have arrived.
  return pathfind_list_back(goal,from,cur_mark, world)
end
#Uses default edge cost.
function pathfind(from,goal, cur_mark, world) 
  return pathfind(from,goal, edge_cost,cur_mark,world)
end

#Tracks back the taken path.
function pathfind_list_back(at,from, list, cur_mark,world)
  min_n= nothing
  min_cost = float32(0)
  for n = node_connects(at,world)
    if n == from
      return push(list, from)
    end
    if n.mark == cur_mark && (min_n == nothing || n.cost < min_cost)
      n.mark = cur_mark-1
      min_cost = n.cost
      min_n = n
    end
  end
  if min_n == nothing
    return  list
  end
  return pathfind_list_back(min_n, from, push(list,min_n), cur_mark,world)
end
#Same, just without `list`
function pathfind_list_back(at,from, cur_mark,world)
  return pathfind_list_back(at, from, {}, cur_mark,world)
end
