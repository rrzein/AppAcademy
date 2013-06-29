# encoding: utf-8

require 'colorize'
require './board.rb'
require './piece.rb'

class Game
  #UI of the game
  def initialize
    @board = Board.new
    @colors = [:black, :red]
  end

  def play
    puts "Welcoming to Checkers."
    set_players

    until @board.game_over?(@player_turn.last.color)
      puts @board
      input = @player_turn[0].move
      move = @player_turn[0].process_move(input)
      piece = @board.piece_to_move(move)
      piece.perform_moves(move)
      @player_turn.reverse!
    end

      congratulate

  end

  def set_players
    @player1 = HumanPlayer.new(:black)
    @player2 = HumanPlayer.new(:red)
    @player_turn = [@player1, @player2]
  end

  def congratulate
    puts "Congratulations. #{@player_turn.last.color.to_s.capitalize} wins."
  end

end

class Player

  def initialize(coler)
    @color = color
  end

  #method that asks for the player's turn

  #method that convert's players turn into a string that the board and piece can understand


end

class HumanPlayer < Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move
    puts "#{@color.to_s.capitalize}, it is your turn to move."
    puts "Please enter your move in the form of coordinates, i.e. (5,6), (4,3)."
    puts "To jump over mutiple pieces, please enter multiple coordinates."
    gets.chomp
  end

  def process_move(input)
    #take the string, split it up into items that are like "(5,4)"
    moves_array = []
    input_array = input.split(", ")
    #take each of those items, take out the parenthesis
    input_array.each do |coordinates_input|
      row_input, column_input = coordinates_input.gsub(/[()]/, '').split(",")
      moves_array << [row_input.to_i, column_input.to_i]
    end
    moves_array
  end

end
