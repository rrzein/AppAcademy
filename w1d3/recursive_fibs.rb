def recursive_fibs(num)
  case num
  when 1
    [0]
  when 2
    [0, 1]
  else
    ret = recursive_fibs(num - 1)
    # [0, 1]
    ret << ret[-1] + ret[-2]
    # [0, 1, 1]
    # recursive_fibs(num - 1) << recursive_fibs(num - 1).last + recursive_fibs(num - 2).last
  end
end

p recursive_fibs(3)
p recursive_fibs(6)