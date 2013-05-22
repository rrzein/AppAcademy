require './piece.rb'

class Pawn < Piece

  attr_accessor :first_move

  def initialize(color, location)
    super(color, location)
    # @moved_yet = false
    assign_increments
  end

  # We actually use

  ## Initialization

  def move_increments
    @move_increments = case @color
    when :white
      [[-1, 0], [-2, 0]]
    when :black
      [[1, 0], [2, 0]]
    end
  end

  def attack_increments
    @attack_increments = case @color
    when :white
      [[-1, -1], [-1, 1]]
    when :black
      [[1, -1], [1, 1]]
    end
  end

  ## Actual stuff

  # build_path OK?

  def possible_moves
    # p possible_non_attack_moves
    # p possible_attack_moves
    possible_non_attack_moves + possible_attack_moves
  end

  def possible_non_attack_moves
    # p possible_non_attack_moves
    possible_non_attack_moves = @move_increments.map do |increment|
      [@location[0] + increment[0], @location[1] + increment[1]]
    end
    possible_non_attack_moves.reject! { |move| move.any? { |c| c < 0 } }
    possible_non_attack_moves
  end

  def possible_attack_moves
    possible_attacks = @attack_increments.map do |increment|
      [@location[0] + increment[0], @location[1] + increment[1]]
    end
    possible_attacks.reject! { |attack| attack.any? { |c| c < 0 } }
    possible_attacks
  end

  def first_move
    @move_increments = @move_increments.first
  end

  def build_path(destination)
    if (location[0] - destination[0]).abs == 2
      middle_row = (location[0] + destination[0])/2
      path = [location, [middle_row, location[1]], destination]
    else
      path = [location, destination]
    end
  end

  def to_s
    'P'
  end

  # Unsure if use

  # def path_to(destination)
  #   # if destination has enemy piece
  #   #   attack_increments
  #   # else
  #   #   path = []
  #   # end
  # end

  def valid_move?(destination)
    possible_moves.select do |move|
      on_board?(move) && open?(move)
    end

    possible_moves.include?(destination)
  end

  def valid_attacks?(destination)
    possible_moves.select do |move|
      on_board?(move) && enemy_piece?(move)
    end

    possible_moves.include?(destination)
  end

  private
  def assign_increments
    move_increments
    attack_increments
  end

end