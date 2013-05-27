class Board

  def initialize(side_length = 9)
    @side = side_length
    @grid = Array.new(@side) { Array.new(@side) { Tile.new } }
    plant_bombs
  end

  def display_board
    puts "- #{@grid.map { |item| - }.join(" ")} -"
    @grid.each do |row|
      puts "| #{row.map { |item| item.face }.join(" ")} |"
    puts "- #{@grid.map { |item| - }.join(" ")} -"
  end

  def plant_bombs
    bomb_option = [true, false]
    bomb_count = 0
    until bomb_count = 10
    @grid.each do |row|
      row.each do |tile|
        tile.bomb = bomb_option.sample
        bomb_count += 1
      end
    end
  end

end

class Tile
  attr_accessor :bomb, :flag, :visible, :surrounding_bombs, :neighbors, :face

  DELTAS = [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], ]

  def initialize
    @visible = false
    @neighbors = []
  end

  def populate_neighbors

  end

  def face
  end

  def populate_neighbors
  end

end

class MineSweeper

  def initialize_board
    @board = Board.new
  end

  def play
    ask_size
    initialize_board

    until game_over?
      @board.display_board
      user_input
      if bomb?
        game_over
      else
        sweep_for_mines
      end
    end

    win? ? congratulate : lost
  end

  def ask_size
  end

  def user_input
  end

  def game_over?

  end

  def congratulate
  end

  def lost
  end

end
