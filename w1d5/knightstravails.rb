class Knightmoves
  attr_accessor :parent, :position, :moves

  def initialize(position)
    @parent = nil
    @position = position
    @moves = []
  end

  def move_tree(finish_position)
    visited_positions = []
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.position == finish_position
      populate_possible_moves(current_node)
      current_node.moves.each do |move|
        queue << move unless visited_positions.include?(move.position)
        visited_positions << move.position
      end
    end
  end

  def knight_path(finish_position)
    move_chain = []
    chain_link = move_tree(finish_position)
    until chain_link.parent.nil?
      move_chain << chain_link.position
      chain_link = chain_link.parent
    end
    move_chain.reverse
  end

  def new_coordinates(position)
    new_coords = []
    row, column = position
    possible_changes = [ [2,1] , [2,(-1)] , [(-2),1] , [(-2),(-1)] , [1,2] , [1,(-2)] , [(-1),2] , [(-1),(-2)] ]
    possible_changes.each do |position_change|
      new_position = [row + position_change[0], column + position_change[1]]
      if possible_move?(new_position)
        new_coords << new_position
      end
    end
    new_coords
  end

  def populate_possible_moves(node)
    coordinates = new_coordinates(node.position)
    coordinates.each do |x_y_pair|
      new_node = Knightmoves.new(x_y_pair)
      new_node.parent = node
      node.moves << new_node
    end
  end


  def possible_move?(row, column)
    row < 8 && row > -1 && column < 8 && column > -1
  end

end

knight = Knightmoves.new([0,3])
p knight.knight_path([7,5])