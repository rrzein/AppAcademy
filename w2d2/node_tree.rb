class TreeNode

  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = [] #does this need to be an array of hashes?
  end

  def children=(*kids)
    # @children.each { |child| child.parent = nil }
    (@children += kids).flatten!
    @children.each { |child| child.parent = self }
  end

  def to_s
    @value.join
  end

  # def dfs(target_value)
  #   stack = [self]
  #   until stack.empty?
  #     p node = stack.pop
  #     if node.value == target_value
  #       return node
  #     else
  #       node.children.each do |child|
  #         stack << child
  #       end
  #     end
  #   end
  # end

  def dfs_r(target_value)
    # p "then #{self.value}"
    if self.value == target_value
      self
    elsif @children.empty?
      nil
    else
      @children.each do |child|
        result = child.dfs_r(target_value)
        return result if result
      end
      nil
    end
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      if node.value == target_value
        return node
      else
        node.children.each do |child|
          queue << child
        end
      end
    end
  end
end

root = TreeNode.new(:root)
node1 = TreeNode.new(:node1)
node2 = TreeNode.new(:node2)
node3 = TreeNode.new(:node3)
node4 = TreeNode.new(:node4)
node5 = TreeNode.new(:node5)
node6 = TreeNode.new(:node6)
node7 = TreeNode.new(:node7)
node8 = TreeNode.new(:node8)
node9 = TreeNode.new(:node9)

root.children = node1, node2, node3
node2.children = node4, node5
node5.children = node6, node7, node8, node9

# p root.children
# p node2.children
# p node5.children
# p root.bfs(:node9)
# p root.dfs_r(:node9)
 # p node2.dfs_r(:node9)