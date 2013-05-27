class Hangman
  attr_accessor :blanks, :guesser, :confirmer

  def initialize
    @computer = ComputerPlayer.new
    @human = HumanPlayer.new
  end

  def start_game
    set_players
    # @confirmer.get_secret_word
    @blanks = Array.new(@confirmer.secret_word) { "_" }

    until game_over?
      display_blanks
      guess = @guesser.input_guess(@blanks)
      @confirmer.guessing(guess, @blanks)
    end

    congratulate_winner
  end

  def set_players
    print "Please input guesser or confirmer: "
    choice = gets.chomp
    case choice
    when "guesser"
      @guesser = @human
      @confirmer = @computer
    else
      @guesser = @computer
      @confirmer = @human
    end
  end

  def display_blanks
    puts "Secret word: #{@blanks.join(" ")}"
  end

  def game_over?
    !@blanks.include?("_")
  end

  def congratulate_winner
    puts "The word was guessed! The word was '#{@blanks.join}'."
  end

end

class HumanPlayer
  attr_accessor :secret_word_length

  def input_guess(blanks)
    print "Please guess a letter: "
    gets.chomp
  end

  def secret_word
    print "Please enter the length of the secret word: "
    @secret_word_length = gets.chomp.to_i
  end

  def guessing(guessed_letter, blanks)
    puts "The computer guesses #{guessed_letter}."
    display_board(blanks)
    match_position = ""

    until match_position == "z"
      print "Where does that letter go in the secret word? Put z if nowhere. "
      match_position = gets.chomp
      blanks[match_position.to_i] = guessed_letter unless match_position == "z"
    end
  end

  def display_board(blanks)
    p blanks.join(" ")
    p (0...blanks.length).to_a.join(" ")
  end
end

class ComputerPlayer
  attr_accessor :dictionary_word, :guessed_letters, :comp_dictionary, :words_to_guess, :guessed_letter

  def initialize
    @guessed_letters = []
    @comp_dictionary = File.readlines("dictionary.txt").map(&:strip)
    @words_to_guess = @comp_dictionary.dup
  end

  def secret_word
    @dictionary_word = @comp_dictionary.sample
    @dictionary_word.length
  end

  def guessing(guessed_letter, blanks)
    @dictionary_word.split(//).each_with_index do |char, ind|
      blanks[ind] = guessed_letter if guessed_letter == char
    end
  end

  def input_guess(blanks)
    @guessed_letters << guess_a_letter(blanks)
    @guessed_letters[-1]
  end

  def guess_a_letter(blanks)
    filter(blanks) unless @guessed_letters.empty?
    letter_frequencies = Hash.new(0)
    if @words_to_guess == @comp_dictionary
      @words_to_guess.select! { |word| word.length == blanks.count }
    end

    @words_to_guess.each do |word|
      word.each_char do |char|
        next if @guessed_letters.include?(char)
        letter_frequencies[char] += 1
      end
    end
    letter_frequencies.max_by{ |key, val| val }[0]
  end

  def filter(blanks)
    blanks.include?(@guessed_letters[-1]) ? filter_from_pos_feedback(blanks) : filter_from_neg_feedback(blanks)
  end

  def filter_from_pos_feedback(blanks)
    @words_to_guess.select! { |word| adjacent?(word, blanks) }
  end

  def adjacent?(word, blanks)
    word.split(//).each_index do |ind|
      if blanks[ind] != word[ind]
        return false unless blanks[ind] == '_'
      end
    end
    true
  end

  def filter_from_neg_feedback(blanks)
    @words_to_guess.select! { |word| !(word.include?(@guessed_letters[-1])) }
  end

end

# reg = ''
# ['_', 'a', '_'].each do |chr|
#   if chr == '_'
#     reg << '*'
#   else
#     reg << chr
#   end
# end
# /*a*/
# reg = Regexp.new(reg)
#
# @words_left.select { |word| word =~ reg }





# blanks = ['a', '_', 'p', 'l', '_']
# dictionary = ['apple', 'apply', 'masle']
# p filter_from_pos_feedback2(blanks, dictionary)

new_game = Hangman.new
new_game.start_game





























