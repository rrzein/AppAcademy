require './slidingpiece.rb'

class Bishop < SlidingPiece

  def initialize(color, position)
    super(color, position)
    @move_vectors = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    @move_increments = []
    move_increments
  end

  def to_s
    'B'
  end

end

