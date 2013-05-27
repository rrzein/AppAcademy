require 'set'

class WordChains

  #should return an array of adjacent words
  def adjacent_words(word, possible_words)
    adjacent_words = Set.new

    word.length.times do |index|
      ("a".."z").each do |letter|
        new_word = word.dup
        new_word[index] = letter

        adjacent_words << new_word if possible_words.include?(new_word)
      end
    end

    adjacent_words
  end

  def initialize(dictionary)
    @dictionary = dictionary
  end

  #our main method, will give you a hash mapping from the start word to the end word
  def build_chain(start_word, end_word)
    return nil if start_word.length != end_word.length

    candidates = File.readlines(@dictionary).map { |entry| entry.strip }.select { |entry| start_word.length == entry.length }
    candidates = Set.new(candidates) - [start_word]

    recent_words = Set.new([start_word])

    parent_words = { start_word => nil }

    until parent_words.has_key?(end_word) || recent_words.empty?
      new_words, new_parent_words = find_new_words(recent_words, candidates)

      recent_words = new_words
      #the BANG is important here, because we want to actually want to MODIFY THAT OBJECT
      parent_words.merge!(new_parent_words)

      #this is important.... narrows down the dictioanry so you don't try to find the same word twice
      candidates -= new_words
    end

    build_path(parent_words, end_word)
  end

  #the return values of this method can be used throughout the whole class
  def find_new_words(recent_words, candidates)
    new_words = Set.new
    new_parent_words = {}

    recent_words.each do |recent_word|
      adjacent_words = adjacent_words(recent_word, candidates)

      new_words += adjacent_words
      adjacent_words.each do |adjacent_word|
        new_parent_words[adjacent_word] = recent_word
      end
    end

    [new_words, new_parent_words]
  end

  #gives you the chaining of the words
  def build_path(parent_words, target)

    reversed_path = [target]
    until parent_words[reversed_path.last].nil?
      reversed_path << parent_words[reversed_path.last]
    end

    reversed_path.reverse
  end

end

wordchain = WordChains.new("dictionary.txt")
p wordchain.build_chain("ruby", "duck")