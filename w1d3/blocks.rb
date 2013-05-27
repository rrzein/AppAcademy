class Array

  def my_thing
    size.times do |i|
      yield(i)
    end
  end

  def my_each
    # 0.upto(size - 1) do |i|
    size.times do |i|
      yield(self[i])
    end
  end

  def my_map_inject
    #TODO: add a version of my_map with inject
  end

  def my_map
    # working 1
    # new_arr = []
    # 0.upto(size - 1) do |i|
    #   new_arr[i] = yield self[i]
    # end
    # new_arr

    new_arr = []
    self.my_each { |v| new_arr << yield(v) }
    new_arr

    # new_arr = []
    # my_each do |i|
    #   new_arr[i] = yield i
    #   #yield self[i]
    #   # self[i] = yield
    # end
    # new_arr
  end

  def my_select
    #my_each { |v| yield(v) if v }
    new_arr = []
    self.my_each { |v| new_arr << v if yield(v) }
    new_arr
  end

  def my_inject
    # [5, 1, 2, 3].inject(self[0]) { |accum, val| accum[0] == 5 }
    # new_arr = []
    # self.my_each { |v| accum = yield(accum, v) }
    # new_arr

    # 5, 2, 3
    accum = self[0]
    self[1..-1].my_each { |v| accum = yield(accum, v) }
    accum
  end

  def practice_inject
    sum = self[0]
    self[1..-1].my_each { |v| sum += yield(v) }
    sum
    # { }
  end

  def my_sort!
    # sorted = []
#     self.my_each { |v| sorted << yield(self, self.pop) }
#     sorted

    # def bubble_sort(num_arr)
    unsorted = true
    while unsorted
      unsorted = false
      1.upto(self.size - 1) do |i|
        if yield(self[i - 1], self[i]) == 1
          self[i - 1], self[i] = self[i], self[i - 1]
          unsorted = true
        end

        # when -1
        # when 0
        # when 1
        # else
        #   # wtf
        # end
        #
        # if num_arr[i - 1] > num_arr[i]
        #   num_arr[i - 1], num_arr[i] = num_arr[i], num_arr[i - 1]
        #   unsorted = true
        # end
      end
    end
    # end
    self
  end


end

arr = [5, 12, 63, 14 , 85]
#arr.each { |v| puts v }

puts "my_each:"
p arr
arr.my_each { |v| v * 2 }
p arr

puts "\nmy_map:"
new_arr = arr.my_map { |v| v * 2 }
p new_arr

puts "\nmy_select:"
selected_arr = arr.my_select { |v| v < 60 }
p selected_arr

puts "\nmy_inject:"
p [1, 2, 5].my_inject { |sum, num| sum * num }
p [10, 2, 3, -2].my_inject { |sum, num| sum - num }

puts "prac_inject"
summed = [1, 2, 3].practice_inject {|v| v }
p summed

puts "my_sort"
p "ascending"
p [1, 3, 5].my_sort! { |num1, num2| num1 <=> num2 }
p "descending"
p [1, 3, 5].my_sort! { |num1, num2| num2 <=> num1 }
# puts
# arr.my_thing { |v| puts v + v }

def splat_block(*args, &blc)
  # puts "NO BLOCK GIVEN!" if blc.nil?
  unless block_given?
    puts "NO BLOCK GIVEN!"
    return
  end
  yield(args)
  #puts args.inspect
end

puts "\nsplat_block:"
splat_block("cat", "dog", "man", "wife")
splat_block("cat", "dog", "man", "wife") { |v| puts v.inspect }


