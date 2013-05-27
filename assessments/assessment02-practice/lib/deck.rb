require 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    cards = []
    
    #this line is unnecessary... doing "each.. do" will result in 52
    until cards.count == 52
      Card.suits.each do |suit|
        Card.values.each do |value|
          cards << Card.new(suit, value) 
        end
      end
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards.reverse
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  def peek
    #RETURN TO THIS ONCE YOU'VE GOT THE LOGIC FIGURED OUT
    @cards[-1]
  end

  def include?(card)
    @cards.include?(card)
  end

  def shuffle
    @cards.shuffle!
    #don't need to return cards
    @cards
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    #if count < n is better, since the deck size changes
    raise ArgumentError.new "not enough cards" if n > 52
    #no need to initialize an unnecessary array
    taken_cards = []
    #remember, not popping
    #we're shifting here, so just do @cards.shift(n) and it'll do it.
    n.times { taken_cards << @cards.pop }
    #don't need to return it
    taken_cards
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    #splat operator is even better than "each do", because it will take the array and then iterate through each item
    cards.reverse.each do |card|
      #we're pushing to the end of the stack, as opposed to unshifting to the front of the stack
      @cards.unshift(card)
      
      #better way of doing this.... @cards.push(*cards)
    end
    @cards
  end
end
