class Player
  #methods
  #initializes pot

  #deals cards to player
    #each player holds an instance of the Hand class at any given time

  #ask player which cards to discard
    #sends cards back to the bottom of deck
    #deals as many cards back to the player's hand

  #ask player if they want to fold, see, or raise

  attr_reader :hand

  def initialize(pot)
    @pot = pot
    @hand = []
  end

  def betting_move
  end

  def make_bet
  end

  def fold
  end

  def see
  end

  def raise
  end

  def discard
  end

end
