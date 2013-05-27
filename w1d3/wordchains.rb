#take two words from the user
#connect one word to the next each on a line

def adjacent_words(word, dictionary)
  dictionary_words = File.readlines(dictionary).map {|i| i.chomp}.select {|w| w.length == word.length}
  adj_words = []
  word_split_array = word.split(//)

  dictionary_words.each do |dict_word|
    dict_split_array = dict_word.split(//)
    i = 0
    matched_letters = 0
    while i < dict_split_array.count
      if dict_split_array[i] == word_split_array[i]
        matched_letters += 1
      end
      i += 1
      if matched_letters == (dict_split_array.count - 1) && (dict_word != word)
        adj_words << dict_word
      end
    end
  end
  adj_words
end

def build_chain(start_word, end_word, dictionary)
  current_words = [[start_word]]
  Set.add(start_word)

  new_words = Set.new

  visited_words = Set.new

  current_words.each do |word|
    new_words.merge(adjacent_words(word, dictionary))
  end
end

p adjacent_words("duck","2of12.txt")
