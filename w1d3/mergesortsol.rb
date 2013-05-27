class Array
  def merge_sort
    return self if count < 2

    middle = count / 2

    left, right = self[0...middle], self[middle..-1]
    sorted_left, sorted_right = left.merge_sort, right.merge_sort

    merge(sorted_left, sorted_right)
  end

  def merge(left, right)
    merged_array = []
    until left.empty? || right.empty?
      merged_array << ((left.first < right.first) ? (left.shift) : (right.shift))
    end

    merged_array + left + right
  end

end

p [1,2,3,2,5,2,6,7,4,1,6,7,10,1,53,4].merge_sort