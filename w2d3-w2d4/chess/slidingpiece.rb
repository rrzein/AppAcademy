# encoding: utf-8

require './piece.rb'

class SlidingPiece < Piece

  # We actually use

  def initialize(color, location)
    super(color, location)
  end

  def build_move_increments
    @move_vectors.each do |vector|
      (1..7).each do |i|
        increment = vector.map { |vector| vector * i }
        @move_increments << increment
      end
    end
  end

  def build_path(destination)
      loc_row, loc_col = @location
      des_row, des_col = destination

      rows_traversed = up_or_down_to(loc_row, des_row)
      cols_traversed = up_or_down_to(loc_col, des_col)

      path = if rows_traversed.size == 1
        cols_traversed.map { |col| [rows_traversed[0], col] }
      elsif cols_traversed.size == 1
        rows_traversed.map { |row| [row, cols_traversed[0]] }
      else
        rows_traversed.zip(cols_traversed)
      end
  end

  def up_or_down_to(loc, des)
    case loc <=> des
    when 1
      loc.downto(des).to_a
    when -1
      loc.upto(des).to_a
    else
      [loc]
    end
  end

  # Unsure if use

  # def valid_moves
  #   super
  #   @position + move_increment.path_clear?
  # end

  # def path_clear?(destination)
 #    path(destination)[0..-1].none? { |square| @board.is_occupied?(square) }
 #  end

end