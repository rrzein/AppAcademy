def caesar_cipher(str, shift)
  letters = ("a".."z").to_a

  #set the string to an empty array, and just shoveled shit into it
  encoded_str = ""
  str.each_char do |char|
    if char == " "
      encoded_str << " "
      next
    end

    old_idx = letters.find_index(char)
    new_idx = (old_idx + shift) % letters.count

    encoded_str << letters[new_idx]
  end

  encoded_str
end
