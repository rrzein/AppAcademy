require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe "::all_cards" do
    it "returns 52 cards" do
      cards = Deck.all_cards
      cards.uniq.count == 52
    end
  end

  it "should not expose its cards" do
    deck.should_not respond_to(:cards)
  end

  it "contains all 52 cards by default" do
    deck.count.should == 52
  end

  it "lets us check if a card is in the deck" do
    deck.include?(deck.peek).should be_true
  end

  it "shuffles the cards" do
    expect { deck.shuffle }.to change{ deck.peek }
  end

  it "lets us peek at the top card of the deck" do
    deck.peek.should be_a(Card)
    deck.count.should == 52
  end

  describe "take" do
    it "lets us take a number of cards from the top of the deck" do
      taken_cards = deck.take(3)

      taken_cards.count.should == 3
      taken_cards.each { |card| card.is_a?(Card) }
    end

    it "doesn't let us take more than the number of cards in the deck" do
      expect { deck.take(100) }.to raise_error("not enough cards")
    end
  end

  describe "return" do
    let (:taken_card) { deck.take(1) }

    it "lets us return cards to the deck" do
      cards = taken_card.dup

      deck.return(taken_card.pop)
      deck.include?(cards.last).should be_true
    end
  end

  describe ""

end