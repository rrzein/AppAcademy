# a .. b
# 2, 10
def recursive_range(start_num, end_num)
  if start_num == end_num
    #[range_arr << start_num]
    [end_num]
  else
    # recursive_range
    # 3, 10
    # 4, 10
    # 5, 10
    # ...
    # ret = recursive_range(start_num + 1, end_num)
#     [start_num] + ret
    # p [start_num, end_num]
    # ret = recursive_range(start_num + 1, end_num)
 #    p ret
    ret = [start_num] + recursive_range(start_num + 1, end_num)
    p ret
    ret
    # << recursive_range(start_num, end_num - 1)
  end
end

range = recursive_range(2, 10)
# p range