class Piece
  attr_reader :color, :attack_increments
  attr_accessor :location


  def initialize(color, location)
    @color = color
    @location = location
    # @attack_increments =
  end

  def valid_move?(destination)
    possible_moves.select do |move|
      on_board?(move) && (open?(move) || enemy_piece?(move))
    end

    possible_moves.include?(destination)
  end

  def can_theoretically_move_to?(destination)
    theoretical_moves = @move_increments.map do |increment|
      row, col = @location
      row_d, col_d = increment
      new_location = row + row_d, col + col_d
    end
    theoretical_moves.include?(destination)
  end

  def path_to(destination)
    [destination]
  end

  # private
  def possible_moves
    possible_moves = @move_increments.map do |increment|
      [@location[0] + increment[0], @location[1] + increment[1]]
    end
    possible_moves.reject! { |move| move.any? { |c| c < 0 } }
  end

  def on_board?(square)

  end

  def open?(square)

  end

  def enemy_piece?(square)

  end

end