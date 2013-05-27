# [1, 2, 5, 6, 15], 5
# [1, 2]
def binary_search(array, target)
  # if array.size == 1
 #    array[0]
  # else

    # left, right = a.size / 2, a.size - (a.size / 2)
    # if target > array[0..left].last
    # 1
    # 2..-1
  # left = (array.size / 2) - 1
  #[ 6, 16, 25]
  # [1, 2, 5, 10, 15, 20, 100, 200, 500, 550, 575, 900]
  # 6
  return nil if array.size == 1 && array[0] != target

  median = array.size / 2
  if array[median] == target
    median
  elsif array[median] < target
    right = array[(median + 1)..-1]
    # puts "right = #{right.inspect}"
    ret = binary_search(right, target)
    ret.nil? ? nil : ret + median + 1
    # binary_search(right, target) + median + 1
    # puts "ret = #{ret.inspect}"
    # ret
  elsif array[median] > target
    left = array[0...median]
    # puts "left = #{left.inspect}"
    ret = binary_search(left, target)
    ret.nil? ? nil : ret
    # puts "ret = #{ret.inspect}"
    # ret
  # else
  #   nil
  end

#   if target > array[0..left].last
#     # ret = binary_search(array[(left + 1)..-1], target)
# #       p ret
# #       ret
#     ret = binary_search(array[(left + 1)..-1], target)
#     p ret
#     ret
#   else
#     ret = binary_search(array[0..left], target)
#     p ret
#     ret
#   end
  # end
  # sorted = array.sort
  # if sorted.size == 1
  #   sorted[0]
  # else
  #   left, right = a.size / 2, a.size - (a.size / 2)
  #   if sorted[0..left]
end

arr = [-1, -15, 1, 2, 5, 10, 15, 20, 100, 200, 500, 550, 575, 900, 1500]
p binary_search(arr, 15)
p binary_search(arr, 17)

