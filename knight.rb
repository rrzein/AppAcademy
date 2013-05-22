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
    'N'
  end

end