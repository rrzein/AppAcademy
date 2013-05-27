class Mastermind
  COLORS = {
    :r => :red,
    :g => :green,
    :b => :blue,
    :y => :yellow,
    :o => :orange,
    :p => :purple
  }

  def initialize
    @grid = Array.new(10) { Array.new(4) {:blank} }
    @secret_code = Array.new(4) { COLORS.keys.sample }
    @guess_count = 0
  end

  def play_game
    puts "Welcome to Mastermind!"
    puts "The secret code is #{@secret_code}."

    unless game_over? || win?
      move = ask_for_move
      put_guess_on_board(move)
      display_board
      display_feedback
      if win?
        print "You won!"
      elsif game_over?
        print "You lost"
      end
      @guess_count += 1
    end

  end

  def ask_for_move
    puts "Please enter your guess in the form of 4 letters. "
    gets.chomp
  end

  def put_guess_on_board(guess)
    @grid[@guess_count] = guess.split(//).map { |color| color.to_sym }
  end

  def display_board
    @grid.each do |row|
      p row unless row.include?(:blank)
    end
  end

  def display_feedback
    black, white = check_guess
    print "Black #{black}, White #{white}\n"
  end

  def check_guess
    black = check_color_and_position
    white = check_color_only - black

    [black, white]
  end

  def check_color_and_position
    duped_guess = @grid[@guess_count].dup
    correct_colors_correct_position = 0

    duped_guess.each_with_index do |g_color, g_position|
      @secret_code.each_with_index do |s_color, s_position|
        correct_colors_correct_position += 1 if (g_color == s_color) && (g_position == s_position)
      end
    end
    correct_colors_correct_position
  end

  def check_color_only
    correct_colors = 0
    duped_guess = @grid[@guess_count].dup
    duped_secret = @secret_code.dup

    duped_guess.each_with_index do |g_color, g_ind|
      duped_secret.each_with_index do |s_color, s_ind|
        if g_color == s_color && (g_color != :checked)
          correct_colors += 1
           duped_guess[g_ind] = :checked
           duped_secret[s_ind] = :checked
          # p duped_guess
        end
      end
    end
    correct_colors
  end

  def game_over?
    @guess_count == 10 # ? true : false
  end

  def win?
    @grid[@guess_count] == @secret_code # ? true : false
  end

end

game1 = Mastermind.new
game1.play_game






















