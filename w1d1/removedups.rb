class Array
  def my_uniq
    nums = []
    self.each do |i|
      nums << i unless nums.include?(i)
    end
    nums
  end
end

p [1,2,1,3,3].my_uniq
p [1,1,2,2,4,4,1,2,7,7,9].my_uniq
p [].my_uniq