def iterative_sum(array)
  sum = 0
  array.size.times do |i|
    sum += array[i]
  end
  sum
end

puts iterative_sum([1,2,3])