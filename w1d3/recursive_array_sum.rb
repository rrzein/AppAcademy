def array_sum(arr)
  if arr.size == 1
    arr[0]
    # "the"
  else
    # num = arr.pop
    p arr.inspect
    arr[0] += arr.pop
    ret = array_sum(arr)
    ret
  end
end

def array_sum2(arr)
  if arr.size == 1
    arr[0]
  else
    array_sum2(arr[0..-2]) + arr.last
  end
end

nums = [1, 2, 3, 4, 5]
p array_sum(nums)
p array_sum2(nums)

# def array_sum2(arr)
#   n = arr.size
#   if n == 0
#     arr[0]
#   else
#     # num = arr.pop
#     # last_num = arr.last
#     # arr[]
#     # new_arr = [arr[0..-2]]
#     # 1, 2, 5, 3
#     # first = 4
#     # rest = 2
#     first, *rest = arr[0] + arr.last, arr
#     array_sum2([first, rest])
#     # array_sum2(arr[0..n-1]) + arr.last
#   end
# end

# p array_sum2([1,1,5,6])
