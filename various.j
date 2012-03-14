# Placed in public domain. 

contains_is (itr,x)  = anyp(function (y) is(x,y) end, itr)

contains_isa (itr,tp)  = anyp(function (y) isa(x,tp) end, itr)

#pushnew_is (deque,x) = contains_is(deque,x) ? deque : push(deque,x)
#pushnew (deque,x) = contains(deque,x) ? deque : push(deque,x)

function rand_2_different_i (upto)
  (from_i, to_i) = (randi((1,upto)),randi((1,upto-1)))
  if from_i == to_i
    to_i = to_i+1
  end
  return (from_i,to_i)
end

function rand_2_from_list (list)
  (from_i,to_i) = rand_2_different_i(length(list))
  return (list[from_i], list[to_i])
end

rand_from_list (list) = list[randi(length(list))]