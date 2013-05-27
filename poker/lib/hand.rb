class Hand

  HAND_STRENGTHS = {
    :royal_flush => 100,
    :straight_flush => 90,
    :four_of_a_kind => 80,
    :full_house => 70,
    :flush => 60,
    :straight => 50,
    :three_of_a_kind => 40,
    :two_pair => 30,
    :one_pair => 20,
    :high_card => 10,
  }

  CHECKS = {
    :royal_flush => royal_flush?,
    :straight_flush => straight_flush?,
    :four_of_a_kind => four_of_a_kind?,
    :full_house => full_house?,
    :flush => flush?,
    :straight => straight?,
    :three_of_a_kind => three_of_a_kind?,
    :two_pair => two_pair?,
    :one_pair => one_pair?,
    :high_card => high_card?,
  }

#takes 5 cards from the deck
#calculates the value of the hand based on the cards in it(instance variable)
  #value can be a number?
  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
    @hand_value = 0
    @hand_strength = 0
  end

  def return_card(card, deck)
    deck.return(card)
  end

  def deal(n, deck)
    raise "can't have more than 5 cards" if (cards.count + n) > 5
    #deals card from the deck
    @cards += deck.take(n)

  end

  def beats?(other_hand)
    points > other_hand.points
  end

  def suits
    suits = []
    cards.each { |card| suits << card.suit }
    suits
  end

  def values
    values = []
    cards.each { |card| values << card.value }
    values
  end

  def ordered_cards
    cards.sort_by { |card| card.point_value }
  end

  def points
    points = 0
    CHECKS.keys.each do |hand_type|
      if hand_type
        points += HAND_STRENGTHS[hand_type] if CHECKS[hand_type]
        break
      end
    end
    points
  end

  def royal_flush?
    return false unless flush?
    royal_suite = [:ace, :king, :queen, :jack, :ten]
    cards.all? { |card| royal_suite.include?(card.value) }
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    four_of_same_value = false
    values.each do |value|
      four_of_same_value = true if values.count(value) == 4
    end
    four_of_same_value
  end

  def full_house?
    frequencies = Hash.new(0)
    values.each { |value| frequencies[value] += 1 }
    frequencies.values.sort == [2, 3]
  end

  def flush?
    suits.uniq.count == 1
  end

  def straight?
    straight = true
    (ordered_cards.count - 1).times do |i|
      if (ordered_cards[i + 1].point_value - cards_arr[i].point_value) > 1
        straight = false
      end
    end
    straight
  end

  def three_of_a_kind?
    three_kind = false
    values.each { |value| three_kind = true if values.count(value) == 3 }
  end

  def two_pair?
    frequencies = Hash.new(0)
    values.each do |value|
      next if values.count(value) == 1
      frequencies[value] += 1
    end
    frequencies.values == [2, 2]
  end

  def one_pair?
    frequencies = Hash.new(0)
    values.each do |value|
      next if values.count(value) == 1
      frequencies[value] += 1
    end
    frequencies.values == [2]
  end

  def high_card?
    ordered_cards.last.point_value
  end



end
