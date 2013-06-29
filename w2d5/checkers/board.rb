# encoding: utf-8

require_relative 'piece'
require 'colorize'

class InvalidMoveError < StandardError
end

class Board

  attr_accessor :rows, :pieces

  #EMPTY_SQUARE = "  " - check

  #create the board - check
    #create an array of arrays

  #populate board with pieces - check
    #create a bunch of Piece objects, assign them color

  #display_board - check
  #try this in irb after done

  #perform_slide
  #fills the destination array with the piece
  #fills the origin array with an empty square
  #changes the "position" variable of the piece

  #perform_jump
  #fills the destination array with the piece
  #fills the origin array with an empty square
  #changes the "position" variable of the piece
  #deletes the piece that was in the path

  #delete_piece
  #fills the deleted piece's spot on the board with an empty square
  #consider having an instance variable that says whether the piece is still in the game or not

  EMPTY = " "

  #we'll want to color up the board later on
  def initialize(create_pieces = true)
    @pieces = []
    create_starting_grid(create_pieces)
  end

  def rows
    @rows
  end

  #this doesn't work.... why?

  # def perform_slide(origin, destination)
 #    checker = square_at(origin)
 #    square_at(destination) = checker
 #    square_at(origin) = EMPTY
 #  end

 #ask ryan about this

  def perform_slide(origin, destination)
    if square_at(destination).is_a?(Piece)
      puts square_at(destination)
      raise InvalidMoveError.new "The slide destination is occupied"
    end

    piece = square_at(origin)
    puts square_at(origin)

    unless piece.possible_slides.include?(destination)
      raise InvalidMoveError.new "The piece cannot slide to that square."
    end

    from_r , from_c = origin
    to_r, to_c = destination

    @rows[to_r][to_c] = piece
    @rows[from_r][from_c] = EMPTY
  end

  def perform_jump(origin, destination)
    if square_at(destination).is_a?(Piece)
      raise InvalidMoveError.new "The jump destination is occupied"
    end

    piece = square_at(origin)

    from_r, from_c = origin
    to_r, to_c = destination
    mid_r, mid_c = middle_piece(origin, destination)

    unless piece.possible_slides.include?(destination)
      raise InvalidMoveError.new "The piece cannot jump to that square."
    end

    unless jumping_a_piece?(origin, destination)
      raise InvalidMoveError.new "Nothing to jump over."
    end

    #this is enemy to jump... need to also see if you're jumping over something
    unless jumping_an_enemy?(piece.color, origin, destination)
      raise InvalidMoveError.new "You can't jump over your own piece."
    end

    @rows[to_r, to_c] = piece
    @rows[from_r, from_c] = EMPTY
    @rows[mid_r, mid_c] = EMPTY
  end

  def jumping_a_piece?(origin, destination)
    piece = square_at(origin)
    mid_row, mid_column = middle_piece(origin, destination)
    @rows[mid_row][mid_column] != EMPTY
  end

  def jumping_an_enemy?(own_color, origin, destination)
    piece = square_at(origin)
    enemy_row, enemy_column = middle_piece(origin, destination)
    @rows[enemy_row][enemy_column].color != own_color
  end

  # def dup_grid(grid)
 #    grid_copy = []
 #    grid.each do |sub|
 #      if sub.is_a?(Array)
 #        dup_grid(sub)
 #      else
 #        grid_copy << sub.dup
 #      end
 #    end
 #    grid_copy
 #  end

  def dup
    dup_grid = Board.new(false)

    @pieces.each do |piece|
      dup_piece = piece.dup(dup_grid)
      row, column = dup_piece.position
      dup_grid.rows[row][column] = dup_piece
      dup_grid.pieces << dup_piece
    end

    (0..7).each do |row|
      (0..7).each do |column|
        dup_grid.rows[row][column] = EMPTY unless dup_grid.rows[row][column]
      end
    end

    dup_grid
  end

  def piece_to_move(move_sequence)
    square_at(move_sequence.first)
  end

  def game_over?(enemy_color)
    #player wins if opponent cannot make a move or all their pieces are gone
    enemy_stuck?(enemy_color) || enemy_out_of_pieces?(enemy_color)
  end

  def enemy_stuck?(enemy_color)
    remaining_pieces(enemy_color).none? do |enemy_piece|
      current_position = enemy_piece.position

      @rows.count.times do |row|
        (0..7).each.none? do |column|
          hypothetical_position = [row, column]
          enemy_piece.valid_move_seq?([current_position, hypothetical_position])
        end
      end
    end
  end

  def enemy_out_of_pieces?(enemy_color)
    remaining_pieces(enemy_color).empty?
  end

  def remaining_pieces(color)
    @rows.flatten.select do |piece|
      piece.is_a?(Piece) && piece.color == color
    end
  end

  def square_at(coordinates)
    r, c = coordinates
    @rows[r][c]
  end

  #maybe we'll need this.... maybe we wont  #
  # def delete_piece(coordinates)
  # end

  protected
  def create_starting_grid(create_pieces)
    @rows = Array.new(8) { Array.new(8) }

    if create_pieces
      fill_players(:black)
      fill_players(:red)
      fill_blanks
    end

  end

  # def fill_blanks
  #   @rows[2..5].each do |row|
  #     row.each do |square|
  #       square =

  #you may want to turn these back into "NIL" later
  def fill_blanks
    #between players
    (0..7).each do |row|
      (0..7).each do |column|
        @rows[row][column] = EMPTY unless @rows[row][column]
      end
    end
  end

  def fill_players(color)
    rows = color == :black ? [0,1,2] : [5,6,7]

    rows.each do |row_num|
      (0..7).each do |col_num|
        if (row_num + col_num) % 2 == 0
          add_piece(color, [row_num, col_num])
        end
      end
    end
  end

  def add_piece(color, position)
    r, c = position
    piece = Piece.new(color, self, position)
    @pieces << piece
    @rows[r][c] = piece
  end

  def middle_piece(origin, destination)
    r1, c1 = origin
    r2, c2 = destination
    r_mid, c_mid = ((r1 + r2) / 2), ((c1 + c2) / 2)

    [r_mid, c_mid]
  end

  def to_s
    puts "   #{(0..7).to_a.join(" ")}"
    @rows.each_with_index do |row, index|
      puts " #{index} #{row.join(" ")}"
    end
  end

end

# b = Board.new
# puts b
# # puts b.square_at([1,1])
# b.perform_slide([6,2], [3,3])
# puts b