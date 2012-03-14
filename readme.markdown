
# Pathfinding using Julia
Pathfinding functions using the Dijkstra algorithm.(which with a 'lossless'
heuristic is A*)

*Currently* pathfind.j assumes on the nodes that:

1. It has a `node_connects(node)` function pointing to other nodes.
2. `mark::Int32`, each pathfind is given a number, and the number is set on
   nodes (that'll make multithreading harder)
3. It has a `cost::Float32` keeping the cost of a the current path, if it 
   were to pass at the node.
4. Either there is an `edge_cost` between nodes, or the cost is provided as
   argument.

That is basically all that is needed, with respect to that, pathfind.j is can 
 'stand alone'. 

### Usage

*Currently* it seems to me that the easiest way to include a project for 
loading is to add it to `LOAD_PATH` **in Julia**.

The test can be run by first compiling the stuff in c/ using `sh compile.sh`,
then symlink the julia executable into the directory; 
`ln -s PATH_TO_JULIA/julia julia` then
`sh test/pathfind.sh` loads everything to test actual testing. 
To test with the nodes: `run_test(1,gen_node_grid(10,10))`, with grid:
`run_test(1,World(10,10))`.

Basically the second argument must 
contain the world, and `rand_journey(world,mark)` must return a (random)tuple 
`(from,to)` for which it will try to pathfind from one to the other.
If there is also a `draw_all` for the world and `vertex` for the nodes, the 
program should run with that world.

The test isnt very thurrough.

### Files

<dl> <!--Where is mah description list in Markdown, wraaaaahhh!-->
<dt><b>pathfind.j</b></dt>
<dd>Dijkstra algorithm pathfinding on a graph.</dd>
<dt><b>c/</b></dt>
<dd>Stuff that draws it and ffi for it. Done this way due to there not being
a standard way to ffi this stuff yet, a bit shoddy.</dd>
<dt><b>grid-node.j</b></dt>  
<dd>Nodes 'based on a grid', basically with `node_connects`, 
	it returns nearby nodes.</dd>
<dt><b>node.j</b></dt>
<dd>Nodes based by explicit lists of stuff a node connects to.</dd>
<dt><b>distance.j</b></dt> 
<dd>Some stuff that is i dont really want to define myself but maybe
 should be 'standard' somehow. (Basically functions for 'distance'
  between things and 'position' of a thing, functions, not just members; 
  sometimes a position still has to be calculated)</dd>
</dl>

### State
Basically a 'work in progress'. (Not that i'd necessarily be working on it!)

### TODO(maybe)

* Neater way to abstract what `Node` does? I do not want getter/setter 
  functions, hope Julia will implement something that will have the 
  properties i need.(Might even already exist and i missed it so far)
  
* Figure out and describe how users can derive from `Node` and/or `GridNode`.
  
* There is a 'natural-looking' image stretching method that basically involves
  vertical/horizontal -only pathfinding. Think for many cases that might be
  good to have.

* 'Plan of motion'; each node a grid or a convex shape of which a side is the
  connection to another node.

## Copyright
Some of it, like under c/ is public domain, the rest is under GPLv3

## Author

Jasper den Ouden
