class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returning a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end
  
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    total_points = 0
    ace = 0
    #if we have a getter method you don't need to call the instance variable all the time
    @cards.each do |card|
      #use a case "card value" here, and have cases when the card is an ace, and when the card is not an ace
      ace += 1 if card.value == :ace
      total_points += card.blackjack_value
    end
    
    #better way of writing this:
    #aces.times do
    #points -= 10 if points > 21... it'll stop when the points are 21 or under anyways
    if ace > 0
      until total_points <= 21 || ace == 0
        total_points -= 10
        ace -= 1
      end
    end
    
    
    total_points
  end

  def busted?
    points > 21
  end

  def hit(deck)
    #don't even need to explicity raise a new "ArgumentError"
    raise ArgumentError.new "already busted" if busted?
    
    #don't have to shovel
    @cards << deck.take(1).last
  end

  def beats?(other_hand)
    return false if busted?
    
    #THIS IS SO VERBOSE.
    my_closeness = (21 - points).abs
    their_closeness = (21 - other_hand.points).abs
    case other_hand.points <=> 21
    when 1
      true
    else
      my_closeness < their_closeness ? true : false
    end
    
    #better way of writing:
    (other_hand.busted?) || (self.points > other_hand.points)
  end

  #good on this one
  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
