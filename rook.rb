require './slidingpiece.rb'

class Rook < SlidingPiece

  def initialize(color, position)
    super(color, position)
    @move_vectors = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    @move_increments = []
    move_increments
  end

  def to_s
    'R'
  end
end