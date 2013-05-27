def iterative_fibs(num)
  # fibs = [0, 1]
  # 5
  fibs = []
  num.times do |i|
    case i
    when 0
      fibs << 0
    when 1
      fibs << 1
    else
      fibs << fibs[i - 1] + fibs[i - 2]
    end
  end
  fibs
  # until fibs.size == num
  #   fibs <<
end

p iterative_fibs(6)
