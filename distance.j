# Placed in public domain.
#(Actually too short to license)

pos(obj) = obj.pos

dist(a::Vector,b::Vector) = norm(a-b)

#Distance between things.
dist(a, b) = dist(pos(a),pos(b))
#Distance squared, basically because avoiding the `sqrt` is good.(no norm_sqr)
dist_sqr(a, b) = dist(a,b)^2 
