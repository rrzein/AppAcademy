def my_transpose(arr)
  # Array.new(5) { 0 }
  transposed_arr = Array.new(arr.length) { |x| Array.new(arr.length) {0}}

  arr.each_with_index do |num, i|
    arr.each_with_index do |num2, j|
      transposed_arr[i][j] = arr[j][i]
    end
  end

  transposed_arr
end

rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]

p my_transpose(rows)

# App Academy's Answer:
# def transpose(rows)
#   cols = Array.new(rows.first.count) { [] }
#   rows.each do |row|
#     row.count.times do |j|
#       cols[j] << row[j]
#     end
#   end
#
#   cols
# end