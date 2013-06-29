# encoding: utf-8

require 'colorize'

class Piece

  attr_reader :king, :grid, :color, :position, :slide_moves, :possible_slides, :possible_jumps
  alias_method :king?, :king

  def initialize(color, grid, position)
    @color, @grid, @position = color, grid, position
    @slide_moves = slide_moves
    @jump_moves = jump_moves

    @king = false
  end

  # def slide_moves
 #  end

  def slide_moves
    black = [[1, -1], [1, 1]]
    red = [[-1, -1], [-1, 1]]

    if @king
      black + red
    else
     @color == :black ? black : red
    end
  end

  def jump_moves
    slide_moves.map do |(rows, coordinates)|
      [rows * 2, coordinates * 2]
    end
  end

  def possible_slides
    row, column = @position
    possible_slides = @slide_moves.map do |(row_delta, column_delta)|
      [row + row_delta, column + column_delta]
    end
    possible_slides
  end

  def possible_jumps
    row, column = @position
    possible_jumps = @jump_moves.map do |(row_delta, column_delta)|
      [row + row_delta, column + column_delta]
    end
  end

  #let's assume the move sequence will be entered through the UI as (2,5), (6,4), (8,0), etc. until destination
  #then the UI will translate it to [[2,5], [6,4], [8,0]], with the first being the origin, and the final being the destination
  #we'll need to rescue InvalidMoveErrors here

  #we'll also need to come up with logic that tells perform moves whether you're jumping or sliding

  def perform_moves(move_sequence)
     if valid_move_seq?(move_sequence)
       perform_moves!(@grid, move_sequence)
       @position = move_sequence.last
       crown_piece
     end
  end

  def perform_moves!(grid, move_sequence)
    #maybe use a proc here to call either slide or jump
    #double check this proc
    slide = Proc.new { |origin, dest| grid.perform_slide(origin, dest) }
    jump = Proc.new { |origin, dest| grid.perform_jump(origin, dest) }

    move = slide?(move_sequence[0], move_sequence[1]) ? slide : jump

    #was going to put the same as below for valid_slide... it may be repetitive since that's in the board class...
    if move == jump && !(valid_jump?(move_sequence))
      raise InvalidMoveError.new "Bad move, bozo."
    end

    (move_sequence.count - 1).times do |move_step|
      puts move_step
      puts move_sequence.count
      from = move_sequence[move_step]
      to = move_sequence[move_step + 1]
      #logic that tells the method whether it's a slide or a jump
      move.call(from, to)
    end
  end

  # def slide(grid, origin, dest)
#     grid.perform_slide(origin, dest)
#   end
#
#   def jump(grid, origin, dest)
#     grid.perform_jump(origin, dest)
#   end

  #how should we be incorporating the exceptions raised?
  def valid_move_seq?(move_sequence)
    begin
      perform_moves!(@grid.dup, move_sequence)
    rescue InvalidMoveError => error
      return false
    end

    print move_sequence
    true
  end

  def slide?(origin, destination)
    from_r, from_c = origin
    to_r, to_c = destination
    row_shift = to_r - from_r
    column_shift = to_c - from_c

    slide_moves.include?([row_shift, column_shift])
  end

  #is this necessary?
  def valid_slide?(move_sequence)
    return false unless move_sequence.count == 2

    origin = move_sequence.first
    destination = move_sequence.last
    from_r, from_c = origin
    to_r, to_c = destination
    return false unless @slide_moves.include?([to_r - from_r, to_c - from_c])

    true
  end

  #probably don't need this if we're gonna store it in a proc  #
  # def slide(origin, destination)
  #   grid.perform_slide(origin, destination)
  # end

  def jump?(origin, destination)
    from_r, from_c = origin
    to_r, to_c = destination

    true if @jump_moves.include?([to_r - from_r, to_c - from_c])
  end

  # probably don't need this if we're gonna store it in a proc
  # def jump(origin, destination)
 #    grid.perform_jump(origin, desetination)
 #  end

  def valid_jump?(move_sequence)
    (move_sequence.count - 1).times.all? do |move_step|
      from_r, from_c = move_sequence[move_step]
      to_r, to_c = move_sequence[move_step + 1]

      jump_moves.include?([to_r - from_r, to_c - from_c])
    end
  end

  def crown_piece
    if king?
      @king = true
      @slide_moves = slide_moves
    end
  end

  def king?
    case @color
    when :black
      return true if @position.first == 7
    when :red
      return true if @position.first == 0
    end

    false
  end

  def dup(new_grid)
    self.class.new(color, new_grid, position)
  end

  def to_s
    "●".colorize(@color).colorize(:background => :light_white)
  end


end