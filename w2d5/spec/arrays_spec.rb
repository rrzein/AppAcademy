require 'rspec'
require 'arrays'

describe "#my_uniq" do
  it "returns unique items" do
    [1,1,2,2,4,4,5].my_uniq.should == [1,2,4,5]
  end

end

describe "#two_sum" do
  it "returns indexes where those elements sum to zero" do
    [-5,5].two_sum.should == [[0,1]]
  end

  it "doesn't return indexes of pairs that don't sum to zero" do
    [-5,0,2,5].two_sum.should == [[0,3]]
  end

  it "returns multiple sets that sum to zero" do
    [-5,5,0,2,-2].two_sum.should == [[0,1], [3,4]]
  end

  it "returns pairs with the smaller index before bigger index" do
    [-5,5].two_sum.should_not == [[1,0]]
  end

end

describe TowersOfHanoi do

  subject(:game) { TowersOfHanoi.new }

  describe "#render" do
    it "initializes 3 arrays, with first array in reverse sort order" do
      game.render.should == [[3, 2, 1], [], []]
    end
  end

  describe "#move" do
    it "pops from one array and pushes to another" do
      game.move(0, 2)
      game.render.should == [[3, 2], [], [1]]
    end

    it "doesn't push larger item onto smaller item" do
      game.move(0, 1)
      game.move(0, 2)
      game.move(2, 1)
      game.render.should == [[3], [1], [2]]
    end
  end

  describe "won?" do
    it "returns true for a winning case" do
      game.move(0,2)
      game.move(0,1)
      game.move(2,1)
      game.move(0,2)
      game.move(1,0)
      game.move(1,2)
      game.move(0,2)
      game.render.should == [[],[],[3,2,1]]
      game.won?.should == true
    end
  end

end

describe "TreeNode" do
  subject(:node0) { TreeNode.new(0) }
  let(:node1) { TreeNode.new(1) }
  let(:node2) { TreeNode.new(2) }
  let(:node3) { TreeNode.new(3) }
  let(:node4) { TreeNode.new(4) }
  let(:node5) { TreeNode.new(5) }
  let(:node6) { TreeNode.new(6) }
  let(:node7) { TreeNode.new(7) }

  describe "#add_child" do
    it "adds children to itself" do
      node0.add_child(node1)
      node0.children.should include(node1)
    end

    it "sets child's parent to self" do
      node0.add_child(node1)
      node1.parent.should be node0
    end
  end

  describe "#bfs" do

    before(:each) do
      node0.add_child(node1)
      node0.add_child(node2)
      node0.add_child(node3)
      node0.add_child(node4)
      node1.add_child(node5)
      node1.add_child(node6)
      node1.add_child(node7)
    end

    #ask
    it "finds the target in order" do
      node0.should_receive(:value).ordered
      node1.should_receive(:value).ordered
      node2.should_receive(:value).ordered
      node3.should_receive(:value).ordered
      node4.should_receive(:value).ordered
      node0.bfs(4)
    end

    it "returns a target node" do
      node0.bfs(4).should be node4
    end

    it "returns nil if a target is not found" do
      node0.bfs(10).should == nil
    end
  end

  describe "#dfs" do

    before(:each) do
      node0.add_child(node1)
      node0.add_child(node2)
      node0.add_child(node3)
      node0.add_child(node4)
      node1.add_child(node5)
      node1.add_child(node6)
      node1.add_child(node7)
    end

    it "finds the target in the depth-first order" do
      # node0.should_receive(:value).ordered
      # node0.dfs(4)
      node1.should_receive(:dfs).ordered
      node5.should_receive(:dfs).ordered
      node6.should_receive(:dfs).ordered
      node7.should_receive(:dfs).ordered
      node2.should_receive(:dfs).ordered
      node3.should_receive(:dfs).ordered
      node4.should_receive(:dfs).ordered
      node0.dfs(4)
    end

  end


end

# obj.should_receive(:one).ordered
# obj.should_receive(:two).ordered