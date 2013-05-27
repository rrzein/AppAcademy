class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    #even easier: @name, @bankroll = name, bankroll
    @name = name
    @bankroll = bankroll
  end

  def place_bet(dealer, bet_amt)
    #no need to raise an explicit argument error
    raise ArgumentError.new "player can't cover bet" if bet_amt > @bankroll
    dealer.take_bet(self, bet_amt)
    @bankroll -= bet_amt
  end

  def pay_winnings(bet_amt)
    @bankroll += bet_amt
  end

  def return_cards(deck)
    hand.return_cards(deck)
    #self.hand would probably be better?
    @hand = nil
  end
end
