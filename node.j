##  Copyright (C) 14-03-2012 Jasper den Ouden.
##
##  This is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published
##  by the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##

#Basically just an example object for pathfind.j
#Pathfind.j just needs a `cost`, `mark` member and a function
# `node_connects(node,world)` returning a list of connections.

type Node #The node.
  connect::Array{Node,1}
  mark::Int32
  cost::Float32 #Cost at that point.
  obj::Any
end

function Node(mark::Int64,cost,obj)
  return Node(Array(Node,0),int32(mark),float32(cost),obj)
end
function Node(connect,mark::Int64,cost,obj)
  return Node(connect,int32(mark),float32(cost),obj)
end

edge_cnt (node::Node) = length(node.connect)

#Return if the node connects.
function node_connect_p (node::Node, to, check_both::Bool) 
  return contains_is(node.connect, to) ||
         check_both && contains_is(to.connect, node)
end
node_connect_p (node,to) = node_connect_p (node,to, true)

#TODO iterator instead?
node_connects(node::Node, world) = node.connect 

#Connect nodes. Returns the number of _new_ connections.
function node_connect(to::Node, add::Node)
  if node_connect_p(to,add)
    return to.connect
  else
    assert(!contains_is(add.connect,to))
    push(to.connect, add)
    push(add.connect, to)
  end
end

#Connect it to _some_ other node.
function node_random_connect (node::Node,node_list::Vector{Node}, 
                              cond::Function)
  n = rand_from_list(node_list)
  return cond(n,node) ?
         node_connect(node,rand_from_list(node_list)) : 0
end
function node_random_connect (node::Node,node_list::Vector{Node},
                              cond::Function) 
  return node_random_connect (node,node_list,cond, true)
end
function node_random_connect (node::Node,node_list::Vector{Node})
  return node_random_connect (node,node_list,cond, function (a,b) true end)
end
#Connect to _some_ other node, but with a condition.

node_random_connect_max_attempts_factor = 100
#Get a specific number of random connections, returns number of them.
function node_random_connect (node_list::Vector{Node}, cnt::Int,
                              cond::Function)
  (k,n) = 0
  while n < cnt && k < node_random_connect_max_attempts_factor*cnt
    n = n + node_random_connect(rand_from_list(node_list),node_list, cond)
  end
  return n
end
function node_random_connect(node_list::Vector{Node}, cnt::Int,
                             cond::Function) 
  return node_random_connect(node_list,cnt, cond,true)
end
function node_random_connect(node_list::Vector{Node}, cnt::Int, 
                             cond::Function) 
  return node_random_connect(node_list,cnt, function(a,b) true end)
end