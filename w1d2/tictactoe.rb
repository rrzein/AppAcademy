class TicTacToe
  attr_accessor :board

  def initialize
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @diag1 = [@board[0][0], @board[1][1], @board[2][2]]
    @diag2 = [@board[2][2], @board[1][1], @board[0][0]]
  end

  class HumanPlayer
    def move
      move = gets.chomp.split(" ")
      x_coord = move[0].to_i - 1
      y_coord = move[1].to_i - 1

      [x_coord, y_coord]
    end
  end

  class ComputerPlayer
    def move
      x_coord = rand(3)
      y_coord = rand(3)

      [x_coord, y_coord]
    end
  end

  def win?
    @cases = [@board[0], @board[1], @board[2], @board.transpose[0], @board.transpose[1], @board.transpose[2], @diag1, @diag2]
    @cases.each do |consideration|
      return true if consideration == ["x", "x", "x"] || consideration == ["o", "o", "o"]
    end
    false
  end

  def start
    puts "How many players?"
    players = gets.chomp.to_i

    case players
    when 2
      @player1 = HumanPlayer.new
      @player2 = HumanPlayer.new
    when 1
      @player1 = HumanPlayer.new
      @player2 = ComputerPlayer.new
    when 0
      @player1 = ComputerPlayer.new
      @player2 = ComputerPlayer.new
    end

    self.play
  end

  def play
    loop do
      puts "Welcome to Tic Tac Toe. Player 1 is 'x', and Player 2 is 'o'."
      self.display_board
      puts "Player 1, please enter your move in the form (x y), between rows 1 - 3. Example: 1 2"
      player1move = @player1.move
      assignment(player1move, "x")
      self.display_board
      if win?
        puts "Player 1 wins!"
        break
      end

      puts "Player 2, please enter your move in the form (x y), between rows 1 - 3. Example: 1 2"
      player2move = @player2.move
      assignment(player2move, "o")
      self.display_board
      if win?
        puts "Player 2 wins!"
        break
      end

    end
  end

  def display_board
    p @board[0]
    p @board[1]
    p @board[2]
  end

  def assignment(playermove, marker)
    x_coord = playermove[0]
    y_coord = playermove[1]
    @board[x_coord][y_coord] = marker
  end

end

game1 = TicTacToe.new
game1.start