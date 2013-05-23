require './board.rb'
require './humanplayer.rb'

class Game

  def initialize
    @players = {}
    @colors = [:white, :black]

  end

  def play
    set_up_game
    show_game_board

    until @board.checkmate?(whose_turn, @board.position)
      move_made = false
      until move_made
        p @players
        origin, destination = @players[whose_turn].get_move
        p "Origin: #{origin}"
        p "Destination: #{destination}"
        if @board.valid_move?(@board.position, whose_turn, origin, destination)
          @board.move_piece(@board.position, origin, destination)
          next_players_turn
          move_made = true
        end
      end
      show_game_board
    end
  end

  def get_players
    puts "Please enter game mode (1, 2, or 3):"
    puts "1. Human vs. Human"
    puts "2. Human vs. Computer"
    puts "3. Computer vs. Computer"
    until @players.keys.count == 2
      input = gets.chomp.to_i
      case input
      when 1
        @players[:white] = HumanPlayer.new
        @players[:black] = HumanPlayer.new
      when 2
        random = rand(0..1)
        @players[@colors[random]] = HumanPlayer.new
        @players[@colors[random - 1]] = ComputerPlayer.new
      when 3
        @players[:white] = ComputerPlayer.new
        @players[:black] = ComputerPlayer.new
      else
        puts "Invalid mode."
      end
    end
  end

  def set_up_game
    @board = Board.new
    get_players
  end

  def show_game_board
    puts @board
  end

  def whose_turn
    @colors[0]
  end

  def next_players_turn
    @colors.reverse!
  end
end