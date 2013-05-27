def recursive_exponent1(num, pow)
  if pow.zero?
    1
  else
    ret = num * recursive_exponent1(num, pow - 1)
  end
end

p recursive_exponent1(2, 3)

def recursive_exponent2(num, pow)
  if pow.zero?
    1
  else
    if pow.even?
      recursive_exponent2(num, pow / 2) ** 2
    else
      num * recursive_exponent2(num, (pow - 1) / 2 ) ** 2
    end
  end
end

p recursive_exponent2(2, 3)