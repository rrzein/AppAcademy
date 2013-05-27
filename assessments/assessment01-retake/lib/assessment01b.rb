def fibs_iter(n)
  return [0] if n == 1
  fibs_array = [0, 1]
  until fibs_array.count == n
    fibs_array << fibs_array[-1] + fibs_array[-2]
  end
  fibs_array
end

def sum_rec(nums)
  if nums.empty?
    0
  else
    sum_rec(nums[0...-1]) + nums[-1]
  end
end

class Array
  def binary_search(target)
    return nil unless self.include?(target)
    
    median = self.count / 2
    left = self[0...median]
    right = self[median + 1..-1]
    
    case target <=> self[median]
    when -1
      left.binary_search(target)
    when 0
      median
    when 1
      right.binary_search(target) + median + 1
    end
  end
end

class String
  def uniq_subs
    subs_array = []
    
    self.length.times do |i1|
      self.length.times do |i2|
        next if i2 < i1
        substring = self[i1..i2]
        subs_array << substring unless subs_array.include?(substring)
      end
    end
    
    subs_array
  end
end

class Array
  def merge_sort
    return self if count < 2
    
    median = self.count / 2
    left = self[0...median]
    right = self[median..-1]
    
    sorted_left = left.merge_sort
    sorted_right = right.merge_sort
    
    merge(sorted_left, sorted_right)
    
  end
  
  def merge(left, right)
    merged_arrays = []
    
    until left.empty? || right.empty?
    merged_arrays << ((left.first < right.first) ? (left.shift) : (right.shift))
    end
    
    merged_arrays + left + right
  end
end
