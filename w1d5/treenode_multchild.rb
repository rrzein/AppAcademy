class TreeNode
  attr_accessor :parent, :value, :children

  def initialize(value = nil, name = nil)
    @parent = nil
    @children = []
    @value = value
  end

  def add_children(*children_nodes)
    children_nodes.each do |node|
      @children << node
      node.parent = self
    end
  end

  def dfs(number)
    if self.value == number
      self
    elsif self.left_child.nil? && self.right_child.nil?
      nil
    else
      left_result = left_child.dfs(number) #node
      return right_child.dfs(number) if left_result.nil? && @right_child
      left_result
    end
  end

  def bfs(number)
    children = []
    children << self
    until children.empty?
      first_node = children.shift
      return first_node if first_node.value == number
      children << first_node.left_child if first_node.left_child
      children << first_node.right_child if first_node.right_child
    end
    nil
  end

end

root = TreeNode.new(1)
child_a = TreeNode.new(2)
child_b = TreeNode.new(3)

root.add_children(child_a, child_b)
puts root.children