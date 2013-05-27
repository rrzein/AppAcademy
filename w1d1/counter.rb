def counter(arr)
  hash_count = Hash.new(0)
  arr.each do |element|
    hash_count[element] += 1
  end
  hash_count
end

array = ["dog", "dog", "cat"]

p counter(array)