#

class Game
  #game is the dealer
  #should handle UI, progression of the game, blinds (small and big)

  #initializes with game deck
  #asks how many players there are

  #builds pot from players
    #takes ante from each player

  #until game_over--One player gets all the money, everyone else broke
    #deck is shuffled
    #each player is dealt their hand(five cards)
    #betting round loop
      #each player choose to bet, fold, see/call current bet, or raise
    #opportunity to get new cards
      #ask each player if they want to discard up to three cards
      #deal out to each player as many cards as they discarded
    #betting round loop again
    #all remaining players then reveal their hands
    #gives money to player with strongest hand

  #congratulate players. say how much winning player takes home.

end

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

class Hand
#takes 5 cards from the deck
#calculates the value of the hand based on the cards in it(instance variable)
  #value can be a number?
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def draw

  end

  def return
  end

end

class Deck
  attr_reader :cards

  SUITS = [:D, :H, :C, :S]
  VALUES = [:A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]

  def initialize
    @cards = []
    populate_cards

  #initializes to 52 card objects representing a deck
  #"deals" a card out of itself to a "hand"
  #
  #this could be a subclass of arrays?

  #shuffles itself
  end

  def populate_cards
    SUITS.each do |suit|
      VALUES.each do |value|
        card = [suit, value]
        @cards << card unless @cards.include?(card)
      end
    end
    @cards
  end

  def shuffle!
    @cards.shuffle!
  end

end

class Card
  attr_reader :face

  def initialize(suit, value)

    @suit = suit
    @value = value
    @face = [suit, value]
  end

  #should have a suit and value
  #
end