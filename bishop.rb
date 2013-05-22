require './slidingpiece.rb'

class Bishop < SlidingPiece

  def initialize(color, location)
    super(color, location)
    @move_vectors = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    @move_increments = []
    build_move_increments
  end

  def to_s
    'B'
  end

end

