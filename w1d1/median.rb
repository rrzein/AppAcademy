def median(arr)
  if arr.length % 2 == 0
    return (arr.sort[arr.length/2] + arr.sort[(arr.length/2) - 1]) / 2
  else
    return arr.sort[arr.length/2]
  end
end

p median([8, 6, 4, 2])
p median([8,6,4,2,0])