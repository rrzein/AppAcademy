def concatenate(array)
  array.inject("") { |accum, element| accum + element }
end

p concatenate(["Yay ", "for ", "strings!"])