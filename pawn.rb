require './piece.rb'

class Pawn < Piece

  def initialize(color, position)
    super(color, position)
    @first_move = true
    assign_increments
  end

  # def path_to(destination)
  #   # if destination has enemy piece
  #   #   attack_increments
  #   # else
  #   #   path = []
  #   # end
  # end

  def to_s
    'P'
  end

  private
  def assign_increments
    move_increments
    attack_increments
  end

  def move_increments
    @move_increments = case @color
    when :white
      [[1, 0], [2, 0]]
    when :black
      [[-1, 0], [-2, 0]]
    end
  end

  def attack_increments
    @attack_increments = case @color
    when :white
      [[1, -1], [1, 1]]
    when :black
      [[-1, -1], [-1, 1]]
    end
  end

end