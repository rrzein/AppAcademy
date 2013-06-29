# encoding: utf-8

require './board.rb'
require './humanplayer.rb'
require 'colorize'

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
        origin, destination = @players[whose_turn].get_move
        if @board.valid_move?(@board.position, whose_turn, origin, destination)
          @board.move_piece(@board.position, origin, destination)
          next_players_turn
          move_made = true
        end
      end
      show_game_board
    end
    puts "Checkmate!"
    puts "#{@colors.last.to_s.capitalize} wins!"
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
        @players[:white] = HumanPlayer.new(:white)
        @players[:black] = HumanPlayer.new(:black)
      when 2
        random = rand(0..1)
        @players[@colors[random]] = HumanPlayer.new(@colors[random])
        @players[@colors[random - 1]] = ComputerPlayer.new(@colors[random - 1])
      when 3
        @players[:white] = ComputerPlayer.new(:white)
        @players[:black] = ComputerPlayer.new(:black)
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

g = Game.new
g.play

#Put in a standard error if there's a bad input
#the entire "play" loop can be simplified down to 2 lines
#ned put in a "while true" loop... what's being evaluated as "true"?
#in the "play" loop, there are actually two loops, one inside each other
  #one that is the entire game playing and going through each player's turn
  #the other is each specific player's turn
  #the difference is that the player is "changing the pieces" on the board, rather than the board changing itself
  #
