class PathFinder
  BOARD = Array.new(8) {Array.new(8)}

  attr_accessor :possible_moves, :row, :column, :parent, :position

  def initialize(position)
    @parent = nil
    @position = position
    @possible_moves = []
    @row = row
    @column = column
  end

  def add_possible_move(row, column)
    new_row = row
    new_column = column
    new_node = PathFinder.new(new_row, new_column)
    new_node.parent = self
    self.possible_moves << new_node
    # self.possible_moves[-1].parent_row = self.row
    # self.possible_moves[-1].parent_column = self.column
  end

  def position
    @position = [@row, @column]
  end

  # def knight_path(start, end)
#
#   end

  def create_tree(finish_position)
    moves_made = []
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.position == finish_position
      current_node.construct_children(current_node.position)
      current_node.possible_moves.each do |move|
        queue << move unless moves_made.include?(move.position)
        moves_made << move.position
      end
    end
  end

  # def construct_children(row, column)
  def construct_children(position)
    row, column = position
    moves = [[2,1], [2,-1], [1, 2], [1, -2], [-2, -1], [-2, 1], [-1, 2], [-1, -2]]
    moves.each do |move|
      if valid_move?(row + move[0], column + move[1])
        possible_moves << [row + move[0], column + move[1]]
      end
    end
  end

  def valid_move?(row, column)
    numrows = BOARD.length
    numcols = BOARD[0].length

    row < 8 && column < 8
  end

end

parent = PathFinder.new([3,3])
puts parent.create_tree([7,6])
#p parent.possible_moves[0].possible_moves
#moves = parent.possible_moves
#moves.each do |move|
#   print " row:#{move.row}, col:#{move.column} "
# end