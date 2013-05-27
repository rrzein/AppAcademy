require 'rspec'
require 'card'
require 'deck'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of five cards" do
      deck = Deck.new
      hand = Hand.deal_from(deck)

      hand.cards.count.should == 5
      hand.cards.each { |card| card.is_a?(Card) }
    end
  end

  context "regular hand draw" do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new(deck.take(5)) }

      describe "return" do
        it "returns a card to the deck" do
          cards = hand.cards.dup

          hand.return_card(hand.cards.pop, deck)
          deck.include?(cards.last).should be_true

        end
      end

      describe "deal" do
        it "deals a number of cards from the deck" do
          3.times { hand.return_card(hand.cards.pop, deck)}
          hand.deal(3, deck)
          hand.cards.count.should == 5
        end

        it "should not let you have more than 5 cards" do
          expect do hand.deal(5, deck)
            end.to raise_error("can't have more than 5 cards")
        end
      end

  end

  # context "different hand types" do
  #   # let(:straight_flush) { Hand.new([Card.new(:clubs, :jack),
  #   #   Card.new(:clubs, :ten),
  #   #   Card.new(:clubs, :nine),
  #   #   Card.new(:clubs, :eight),
  #   #   Card.new(:clubs, :seven)])}
  #   # let(:royal_flush) { Hand.new([Card.new(:clubs, :ace),
  #   #   Card.new(:clubs, :king),
  #   #   Card.new(:clubs, :queen),
  #   #   Card.new(:clubs, :jack),
  #   #   Card.new(:clubs, :ten)
  #   #   ])}
  #   # let(:royal_flush) { Hand.new([Card.new(:clubs, :ace),
  #   #   Card.new(:clubs, :king),
  #   #   Card.new(:clubs, :queen),
  #   #   Card.new(:clubs, :jack),
  #   #   Card.new(:clubs, :ten)
  #   #   ])}
  #   # let(:royal_flush) { Hand.new([Card.new(:clubs, :ace),
  #   #   Card.new(:clubs, :king),
  #   #   Card.new(:clubs, :queen),
  #   #   Card.new(:clubs, :jack),
  #   #   Card.new(:clubs, :ten)
  #   #   ])}
  #   # let(:royal_flush) { Hand.new([Card.new(:clubs, :ace),
  #   #   Card.new(:clubs, :king),
  #   #   Card.new(:clubs, :queen),
  #   #   Card.new(:clubs, :jack),
  #   #   Card.new(:clubs, :ten)
  #   #   ])}
  #   # let(:royal_flush) { Hand.new([Card.new(:clubs, :ace),
  #   #   Card.new(:clubs, :king),
  #   #   Card.new(:clubs, :queen),
  #   #   Card.new(:clubs, :jack),
  #   #   Card.new(:clubs, :ten)
  #   #   ])}
  #   #
  # end

end