require 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    #no need for name =, or bankroll =, superfluous.
    super(name = "dealer", bankroll = 0)
    @bets = Hash.new
  end

  def play_hand(deck)
    #again, no need for instance variables here
    #not even a need for "case"
    case @hand.points <=> 17
    when -1
      @hand.hit(deck) until @hand.points >= 17
    end
  end

  def place_bet(dealer, amt)
    #no need for standarderror
    raise StandardError.new "Dealer doesn't bet"
  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets
    #no need for bets.keys, can just pass in two variable, and amt
    @bets.keys.each do |player|
      bet = @bets[player]
      case player.hand.beats?(self.hand)
      when true
        player.pay_winnings(@bets[player] * 2)
      else
      end
    end
    
    #have to end with "nil" here?
  end
end
