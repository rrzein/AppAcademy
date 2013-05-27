def digital_root(num)
  while num > 10
    num = digital_root_step(num)
  end

  num
end

def digital_root_step(num)
  root = 0
  while num > 0
    #this will keep adding another digit to the root--you don't need to declare ones, tens, hundreds, thousandths like you did before
    root += (num % 10)

    num /= 10
  end

  root
end
