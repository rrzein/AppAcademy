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
    # output = ['blue'.colorize(:blue), 'yellow'.colorize(:yellow)]
#
#     @board.position.each_with_index do |row, r|
#       row.each_with_index do |square, c|
#         if (r + c) % 2
#           # shovel white square
#         else
#           # shovel black square
#         end
#         if square.is_a?(Piece)
#           # get color
#           # return colorized string
#         elsif square == "_"
#           # shovel space
#         end
#       end
#
#     end
#
#     puts output
#     puts output[0]
#     puts output[1]
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