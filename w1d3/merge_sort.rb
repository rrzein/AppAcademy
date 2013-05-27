def merge_sort(array)
  if array.count == 1
    array
  else

    median = array.count/2
    left = array[0...median]
    right = array[median..- 1]
    sorted_left = merge_sort(left)
    sorted_right = merge_sort(right)

    merged_array = []
    if left.first < right.first
      merged_array << left.shift
    else
      merged_array << right.shift
    end

    merged_array + left + right
  end
end

p merge_sort([1,6,3,7,8,9,9,2,5,0])