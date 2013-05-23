# encoding: utf-8

require './piece.rb'

class King < Piece
  attr_reader :move_increments

  def initialize(color, location)
    super(color, location)
    @move_increments = [[1, 1],
                      [1, 0],
                      [1, -1],
                      [0, -1],
                      [-1, -1],
                      [-1, 0],
                      [-1, 1],
                      [0, 1]]
  end

  def to_s
    '♚'.colorize(@color).colorize(:background => get_background_color)
  end

end