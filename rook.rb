require './slidingpiece.rb'

class Rook < SlidingPiece

  def initialize(color, location)
    super(color, location)
    @move_vectors = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    @move_increments = []
    build_move_increments
  end

  def to_s
    'R'
  end
end