def range(first, last)
  if first == last
    return [first]
  else
    range(first + 1, last) << first
  end
  numbers
end
 p range(1,5)

def iterative_sum_array(array)
  array.inject { |accum, element| accum + element }
end

def recursive_sum_array(array)
  if array.length == 1
    array[0]
  else
    array[0] + recursive_sum_array(array[1..-1])
  end
end

#array = [2, 3, 5, 7, 11]
#iterative_sum_array(array)
#p recursive_sum_array(array)