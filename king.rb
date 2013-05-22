require './piece.rb'

class King < Piece
  attr_reader :move_increments

  def initialize(color, position)
    super(color, position)
    @move_increments = [[1, 1],
                      [1, 0],
                      [1, -1],
                      [0, -1],
                      [-1, -1],
                      [-1, 0],
                      [-1, 1],
                      [0, 1]]
  end

  def path_to(destination)
    [destination]
  end

  def to_s
    'K'
  end

end