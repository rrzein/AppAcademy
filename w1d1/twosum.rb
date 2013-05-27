=begin
def two_sum(arr)
  arr.each_with_index do |i, x|
    arr.each_with_index do |j, z|
      return true if i + j == 0 && x != z
    end
  end
  return false
end
=end

def two_sum(arr)

  arr.each do |number|
    if number == 0
      return true if arr.count(number) > 1
    else
      return true if arr.include?(-1 * number) && (arr.index(number) != arr.index(-1 * number))
    end
  end
  return false
end


p two_sum([1,2,3,1,-1,0,9,-9])
p two_sum([9,-9])
p two_sum([1,2,3,4,-5,0])
p two_sum([0,0])
p two_sum([0])