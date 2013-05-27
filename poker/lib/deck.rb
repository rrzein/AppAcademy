require 'card'

class Deck

  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards

  end

  def include?(card)
    @cards.include?(card)
  end

  def count
    @cards.count
  end

  def shuffle
    @cards.shuffle!
  end

  def peek
    @cards.first
  end

  def take(n)
    raise "not enough cards" if n > count
    @cards.shift(n)
    #takes cards from the deck

  end

  def return(card)
    #returns cards to the deck
    @cards << card

  end



end
