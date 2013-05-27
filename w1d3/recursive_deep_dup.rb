# arr = [ ["hello", "bye"],
#         ["sean", "ricky", ["cat", "wife"] ],
#       ]
def recursive_deep_dup(arr)
  # # does arr contain anymore arrays?
  # if !(arr.is_a? Array)
  #   arr
  # else
    # arr[recursive_deep_dup(arr)].dup
  # arr_copy = arr.dup
  arr_copy = []
  arr.each do |sub|
    if sub.is_a? Array
      # sub_copy = sub.dup
      # p sub_copy
      # recursive_deep_dup(sub_copy)
      arr_copy << recursive_deep_dup(sub)
    else
      arr_copy << sub
    end
  end
  arr_copy
  # end
end

puts "recursive_deep_dup:"
robot_parts = [["nuts", "bolts", "washers"], ["capacitors", "resistors", "inductors"]]
robot_parts_copy = recursive_deep_dup(robot_parts)

puts "modifying:"
# shouldn't modify robot_parts
robot_parts_copy[1] << "LEDs"
p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
