class Hanoi
  def initialize(rod1)
    @rod1 = Array.new
    @rod1[0] = rod1
    @rod1[1] = []
    @rod1[2] = []
    @choice = nil
    @destination_rod = nil
    @disc = nil
  end

  def towers

    while !(win?)
      show
      puts "Tower from"
      from = gets.chomp.to_i
      puts "Tower to"
      to = gets.chomp.to_i
      assignment(from, to)
    end
    puts "You've won!"
  end

  def win?
    if @rod1[0].empty? && @rod1[1].empty? || @rod1[0].empty? && @rod1[2].empty?
      return true
    else
      return false
    end
  end

  def show
    p @rod1[0]
    p @rod1[1]
    p @rod1[2]
  end

  def allowed?(destination)
    return true if destination.empty?
    return true if destination.last > @disc
    false
  end

  def assignment(number1, number2)
    @rod1[number2] << @rod1[number1].pop
  end

end

game1 = Hanoi.new([3,2,1]).towers

# App Academy's Answer
# class TowersOfHanoiGame
#   def self.disks
#     # can always make the game harder by changing max value :-)
#     (1..3).to_a.reverse
#   end
#
#   def self.default_stacks
#     [TowersOfHanoiGame.disks, [], []]
#   end
#
#   def initialize(stacks = TowersOfHanoiGame.default_stacks)
#     @stacks = stacks
#   end
#
#   def stacks
#     @stacks.map(&:dup)
#   end
#
#   def render
#     max_height = @stacks.map(&:count).max
#
#     (0...max_height).to_a.reverse.map do |height|
#       @stacks.map do |stack|
#         # this || trick says that if stack[height] is `nil` (that is,
#         # the stack isn't that high), print `" "` instead of `nil`,
#         # because we need a blank space.
#         stack[height] || " "
#       end.join("\t")
#     end.join("\n")
#   end
#
#   def display
#     puts render
#   end
#
#   def move(from_stack_num, to_stack_num)
#     # `values_at` is pretty sweet; check out the RubyDoc
#     from_stack, to_stack = @stacks.values_at(from_stack_num, to_stack_num)
#
#     raise "cannot move from empty stack" if from_stack.empty?
#     unless (to_stack.empty? || to_stack.last > from_stack.last)
#       raise "cannot move onto smaller disk"
#     end
#
#     to_stack.push(from_stack.pop)
#
#     # what should `move` return? Perhaps `nil`, since we only call
#     # `move` for its side-effect. But returning `self` is also common
#     # with side-effect methods, this let's us *chain* calls to `move`:
#     # `towers.move(1, 2).move(0, 1).move(3, 0)`.
#     self
#   end
#
#   def won?
#     @stacks[0].empty? && @stacks[(1..2)].any?(&:empty?)
#   end
#
#   def run_game
#     # I wrote this last; I often write the user input last, so I can
#     # first test the game in IRB.
#
#     until game_won?
#       display
#
#       # this uses *array destructuring*
#       from_stack_num, to_stack_num = get_move
#
#       move(from_stack_num, to_stack_num)
#     end
#
#     puts "You did it!"
#   end
#
#   private
#   def get_move
#     from_stack_num = get_stack("Move from: ")
#     to_stack_num = get_stack("Move to: ")
#
#     # returning two things is normally done via array
#     [from_stack_num, to_stack_num]
#   end
#
#   def get_stack(prompt)
#     move_hash = {
#       "a" => 0,
#       "b" => 1,
#       "c" => 2
#     }
#
#     while true
#       print prompt
#       stack_num = move_hash[gets.chomp]
#       return stack_num unless stack_num.nil?
#
#       # otherwise, try again
#       puts "Invalid move!"
#     end
#   end
# end