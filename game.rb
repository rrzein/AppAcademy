class Game
  
  def initialize
    @players = {}
  end
  
  def play
    set_up_game
    show_game_board
    until game_over
      move = ask player whose move it is for move
      if piece.valid_move?(move) # move piece P to square S
        board.make_move(move)
      end
      display_board
      check_for_game_over
    end

  end

  def set_up_game
    # create_players (Select mode: Human vs. human, computer vs human....)
    # initialize game board
    # putting pieces on the board
    # assigning_pieces_to_players

  end

end