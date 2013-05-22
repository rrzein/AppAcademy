require './slidingpiece.rb'


class Queen < SlidingPiece

  def initialize(color, position)
    super(color, position)
    @move_vectors = [[1, 1],
                        [1, 0],
                        [1, -1],
                        [0, -1],
                        [-1, -1],
                        [-1, 0],
                        [-1, 1],
                        [0, 1]]

    @move_increments = []
    move_increments
  end

  def to_s
    'Q'
  end

end


