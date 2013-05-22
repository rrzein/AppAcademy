require './piece.rb'

class Knight < Piece

  def initialize(color, position)
    super(color, position)
    @move_increments = [ [-2, -1],
                        [-2,  1],
                        [-1, -2],
                        [-1,  2],
                        [ 1, -2],
                        [ 1,  2],
                        [ 2, -1],
                        [ 2,  1]]
  end

  def valid_moves
    super
  end

  def to_s
    'N'
  end

end