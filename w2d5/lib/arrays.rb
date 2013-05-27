class Array
  def my_uniq
    return_array = []
    self.each do |item|
      return_array << item unless return_array.include?(item)
    end
    return_array
  end

  def two_sum
    pairs_array = []
    self.each_index do |i|
      self.each_index do |j|
        next if j <= i
        pairs_array << [i,j] if self[i] + self[j] == 0
      end
    end
    pairs_array
  end

end


class TowersOfHanoi


  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def render
    @towers
  end

  def move(from, to)
    if @towers[to].empty?
      @towers[to] << @towers[from].pop
    else
      @towers[to] << @towers[from].pop unless @towers[to].last < @towers[from].last
    # @towers[to] << piece unless !@towers[to].empty? && @towers[to].last < piece
    end
  end

  def won?
    return true if @towers == [[],[],[3,2,1]]
    false
  end

end

class TreeNode

  attr_accessor :children, :parent, :value

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def add_child(child)
    @children << child
    child.parent = self
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      current_node.children.each do |child|
        queue << child
      end
    end
    nil
  end

  def dfs(target)
    puts self.value
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end

end
node0 = TreeNode.new(0)
node1 = TreeNode.new(1)
node2 = TreeNode.new(2)
node3 = TreeNode.new(3)
node4 = TreeNode.new(4)
node5 = TreeNode.new(5)
node6 = TreeNode.new(6)
node7 = TreeNode.new(7)






node0.add_child(node1)
node0.add_child(node2)
node0.add_child(node3)
node0.add_child(node4)
node1.add_child(node5)
node1.add_child(node6)
node1.add_child(node7)

p node0.dfs(4).value