require 'set'

DICTIONARY = File.readlines("dictionary.txt").map { |word| word.strip }

def adjacent_words(word, dictionary)
  adjacent_array = []
  words_array = word.split(//)
  dictionary.each do |entry|
    next if entry.length != word.length
    counter = 0
    entry.split(//).each_with_index do |char, ind|
      counter += 1 if words_array[ind] != char
    end

    adjacent_array << entry if counter < 2 && entry != word
  end
  adjacent_array
end

# def two_steps? (first_word, second_word)
#   return true if first_word == nil || second_word == nil
#   counter = 0
#   first_word_array = first_word.split(//)
#   second_word_array = second_word.split(//)
#   first_word_array.each_with_index do |char, ind|
#     counter += 1 if second_word_array[ind] != char
#   end
#    counter < 3 ? true : false
# end

def find_chain(start_word, end_word, dictionary)
  faster_dictionary = dictionary.select { |entry| entry.length == end_word.length}

  current_words = Set.new
  current_words << start_word

  visited_words = Hash.new
  visited_words[start_word] = nil

  until current_words.include?(end_word)
    new_words = Set.new

    current_words.each do |word|
      # next if visited_words.has_key?(word) # && word != start_word
      adjacent_words(word, faster_dictionary).each do |adj_word|
        # next if visited_words.include?(adj_word)
        next unless two_steps?(adj_word, visited_words[word])
        new_words << adj_word unless visited_words.has_key?(adj_word)
        visited_words[adj_word] = word
      end
    end
    p new_words
    current_words = Set.new
    current_words = new_words
  end

  build_chain(visited_words, end_word)
end

def build_chain(visited_words, word)
  output_array = []
  word_link = word
  until word_link == nil
    output_array << word_link
    word_link = visited_words[word]
  end
  output_array.reverse
end

puts find_chain("duck", "ruby", DICTIONARY)