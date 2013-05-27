require 'rspec'
require 'game'

describe "Game" do

  #methods:
  #

  #determine whose turn it is in order

  #it should change the turn from player to player

  #describe add_pot do
  #it should add or remove from the pot


  #it should deal out money to the players


end

describe "Player" do
  #methods:

  describe "::new" do
    it "initializes a starting player pot" do

    end
  end


  #deal
  #it should deal out 5 cards to the player

  #it should fold when the player wishes to fold

end

describe "Hand" do

  subject(:hand) { Hand }

  describe "#draw" do
    it "should draw 5 cards from the deck" do
      pending("yet to be implemented")
    end
  end

  describe "#return" do
    it "should return cards to the deck" do
      pending("yet to be implemented")
    end
  end

end

describe "Deck" do

  subject(:deck) { Deck.new }

  describe "::new" do
    it "initializes to a deck of 52 cards" do
      deck.cards.count.should == 52
    end

    it "does not have any duplicate cards" do
      deck.cards.uniq.count.should == 52
    end

    it "has 12 cards for every suit" do
      pending("this hasn't been figured out yet")
    end


  end

  describe "shuffle!" do
    it "should shuffle the deck destructively" do
      deck.shuffle!.should_not == deck
    end
  end
  #methods:

  #shuffle
  #it should shuffle the deck

  #it should return to its origina

end

describe "Card" do

  subject(:card) { Card.new(:D, 3)}

  describe "::new" do
    it "should initialize to a face value" do
      card.face.should == [:D, 3]
    end
  end
  #methods:

  #should contain a face value
  #
end