def fibs(num)
  return [] if num == 0
  return [0] if num == 1
  return [0, 1] if num == 2

  fibs = [0, 1]
  while fibs.count < num
    fibs << fibs[-1] + fibs[-2]
  end

  fibs
end
