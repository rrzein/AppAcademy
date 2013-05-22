require './knight.rb'
require './bishop.rb'
require './rook.rb'
require './king.rb'
require './queen.rb'
require './pawn.rb'
require 'debugger'


class Board
  attr_reader :position

  EMPTY_SQUARE = '_'

  def initialize
    @position = Array.new(8) { Array.new(8) { EMPTY_SQUARE } }
    #each empty square is the same object.. does it matter?
    @colors = [:white, :black]
    # @move = @colors[0]
    #not current using @move... at least until we work on Game class
    set_up_starting_position
  end

  def valid_move?(position, color, origin, destination)

    basic_move_tests = [
      valid_square?(destination),
      piece_at?(position, origin) ? piece = square_at(position, origin) : false,
      color == piece.color,
      square_open?(position, destination) || enemy_at?(position, color, destination)]

      # path is clear if !path.empty? and all squares between [path & destination] are one of the following:
        # moving piece itself
        # empty square
        # whatever is at destination square

    advanced_move_tests = [
      # piece.can_theoretically_move_to?(destination),
      valid_path?(position, piece, piece.path_to(destination)),
      hypothetical_position = (move_piece(deep_dup(position), origin, destination)),
      !(king_in_check?(color, hypothetical_position))]
    basic_move_tests.all? && advanced_move_tests.all?
  end

  # def valid_move_doesnt_put_king_in_check?(position, color, origin, destination)
  #   if valid_move?(position, color, origin, destination)
  #     p "valid move"
  #     hypothetical_position = move_piece(deep_dup(position), origin, destination)
  #     p hypothetical_position
  #     p color
  #     p "King in check = #{(king_in_check?(color, hypothetical_position))}"
  #     !(king_in_check?(color, hypothetical_position))
  #   end
  # end

  # valid_move? helper methods

  def valid_path?(position, piece, path)
    p "Checking if path #{path} clear for #{piece.color} #{piece}..."
    unless path.empty?
      path[1...-1].none? do |square|
        piece_at?(position, square)
      end
    end
  end

  def piece_at?(position, coordinates) # take piece arg out if possible
    r, c = coordinates
    puts
    puts "Checking if there is a piece at square [#{r}, #{c}]..."
    puts "=> [#{r}, #{c}] contains #{position[r][c]}"
    position[r][c] != EMPTY_SQUARE
  end

  def square_at(position, coordinates)
    r, c = coordinates
    position[r][c]
  end

  def valid_square?(coordinates)
    coordinates.all? { |coordinate| (0..7).include?(coordinate) }
  end

  def square_open?(position, coordinates)
    square_at(position, coordinates) == "_"
  end

  def enemy_at?(position, color, coordinates)
    square_at(position, coordinates).color != color
  end

  # end of valid_move? helper methods

  def move_piece(position, origin, destination)
    # verbose way
    ro, co = origin
    piece = position[ro][co]
    position[ro][co] = '_'
    rd, cd = destination
    position[rd][cd] = piece
    # original way
    # piece = square_at(origin)
    # square_at(origin) = '_'
    # square_at(destination) = piece
    piece.location = destination
    piece.first_move if piece.is_a?(Pawn)
    position
  end

  def enemy_pieces(color, position)
    position.select
  end

  def king_in_check?(color, position)
    color == :white ? enemy_color = :black : enemy_color = :white
    pieces = position.flatten.reject { |coordinate| coordinate == EMPTY_SQUARE }
    enemy_pieces = pieces.select { |piece| piece.color != color }
    king_loc = king_location(color, position)
    # p "Enemy pieces: #{enemy_pieces}"
    enemy_pieces.any? do |piece|
      # valid_move?(position, enemy_color, piece.location, king_loc)
      valid_path?(position, piece, piece.path_to(king_loc))
    end
  end

  def king_location(color, position)
    # p position
    pieces = position.flatten.reject { |coordinate| coordinate == EMPTY_SQUARE }
    # p "All pieces: #{pieces}"
    king = pieces.select { |piece| piece.color == color && piece.is_a?(King) }
    # p king
    # p "King location = #{king[0].location}"
    king[0].location
  end

  def checkmate?
  end

  private
  def set_up_starting_position
    @position[0][0] = Rook.new(:black, [0,0])
    @position[0][7] = Rook.new(:black, [0,7])
    @position[0][1] = Knight.new(:black, [0,1])
    @position[0][6] = Knight.new(:black, [0,6])
    @position[0][2] = Bishop.new(:black, [0,2])
    @position[0][5] = Bishop.new(:black, [0,5])
    @position[0][3] = Queen.new(:black, [0,3])
    @position[0][4] = King.new(:black, [0,4])
    8.times do |column|
       @position[1][column] = Pawn.new(:black, [1, column])
    end
    @position[7][0] = Rook.new(:white, [7,0])
    @position[7][7] = Rook.new(:white, [7,7])
    @position[7][1] = Knight.new(:white, [7,1])
    @position[7][6] = Knight.new(:white, [7,6])
    @position[7][2] = Bishop.new(:white, [7,2])
    @position[7][5] = Bishop.new(:white, [7,5])
    @position[7][3] = Queen.new(:white, [7,3])
    @position[7][4] = King.new(:white, [7,4])
    8.times do |column|
       @position[6][column] = Pawn.new(:white, [6, column])
    end
  end

  public
  def deep_dup(array)
    array_copy = []
    array.each do |sub|
      if sub.is_a? Array
        array_copy << deep_dup(sub)
      else
        array_copy << sub.dup
      end
    end
    array_copy
  end

  # add_piece(piece, position)

  # position # getter

  def to_s
    puts  "  #{(0..7).to_a.join(' ')}"
    puts "  " + "_" * 15
    @position.each_with_index do |row, index|
      puts ([index] + row).join(' ')
    end
  end

end
