def substrings(string)
  substrings = []
  i = 0
  while i < string.length
    j = i
    while j < string.length
      substrings << string[i..j]
      j += 1
    end
    i += 1
  end

  substrings
end

def subwords(string)
  subs = substrings(string)
  real_subs = []
  File.foreach("2of12.txt") { |word| real_subs << word.chomp if subs.include?(word.chomp) }
  real_subs
end

p subwords("the man in demoliton")