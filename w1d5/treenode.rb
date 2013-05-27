class TreeNode
  attr_accessor :parent, :name, :left_child, :right_child, :value, :children

  def initialize(value = nil, name = nil)
    @parent = nil
    @name = name
    @children = []
    @value = value
    @left_child = nil
    @right_child = nil
  end

  def left_child=(child_node)
    @left_child.parent = nil if @left_child
    @left_child = child_node
    @left_child.parent = self
  end

  def right_child=(child_node)
    @right_child.parent = nil if @right_child
    @right_child = child_node
    @right_child.parent = self
  end

  def add_children(*children_nodes)
    children_nodes.each do |node|
      @children << node
      node.parent = self
    end
  end

  def dfs(number = nil, &blk)
    if ((number && self.value == number) || ( blk && blk.call(self.value)) )
      self.name
    elsif self.left_child.nil? && self.right_child.nil?
      nil
    else
      left_result = left_child.dfs(number, &blk)
      return right_child.dfs(number, &blk) if left_result.nil? && @right_child
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


root = TreeNode.new(1, "root")
john = TreeNode.new(22, "john")
fred = TreeNode.new(3, "fred")
root.left_child = john
root.right_child = fred
#fred.left_child = TreeNode.new(5, "sam")

puts root.dfs { |value| value == 3 }
# p root.bfs(222)
