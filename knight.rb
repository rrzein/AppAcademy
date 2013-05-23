# encoding: utf-8

require './piece.rb'

class Knight < Piece

  def initialize(color, location)
    super(color, location)
    @move_increments = [ [-2, -1],
                        [-2,  1],
                        [-1, -2],
                        [-1,  2],
                        [ 1, -2],
                        [ 1,  2],
                        [ 2, -1],
                        [ 2,  1]]
  end

  def to_s
    '♞'.colorize(@color).colorize(:background => get_background_color)
  end

end