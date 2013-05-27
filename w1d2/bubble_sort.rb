def bubble_sort(array)
  sorted = false
  until sorted
    sorted = true
    # (array.count - 2).times do |index|
    (0..array.count - 2).each do |index|
      if array[index] > array[index + 1]
        array[index], array[index + 1] = array[index + 1], array[index]
        sorted = false
      end
    end
  end

  array
end

p bubble_sort([6,3,1,5,6,7,5,13])