# def make_change(amount, coins = [25, 10, 5, 1])
#   if amount == 0
#     []
#   else
#     options = coins.map do |coin|
#       make_change(amount - coin) << coin unless coin > amount
#     end
#     p options.compact
# #    make_change(amount - coins[0], coins[coins.length..-1])
#   end
# end

def make_change_it(amount, coins = [25, 10, 5, 1])
  #iterative version to make sure can get it 
  change = []
  i = 0
  while amount > 0
    #as long as money is greater than zero there's a coin that we can give back
    while amount >= coins[i]
      #compare money that you have to the biggest coin
      amount -= coins[i]
      change << coins[i]
      p change
    end
    i += 1
  end
end

def make_change_2(amount, coins = [25, 10, 5, 1])
  return nil if amount == 0
  if amount >= coins[0]
    make_change_2(amount - coins[0])
  else make_change_2(amount, coins[1..-1])

  end
end

def make_change_3(amount, coins = [25, 10, 5, 1])
  if amount == 0
    #base case
    #top of stack is when the amount is equal to zero
    []
  else
    if amount - coins[0] < 0
      #the 0 will be 1..-1 in the next level of the stack
      make_change_3(amount, coins[1..-1])
    else
      #if the amount works, put it into the array
      make_change_3(amount - coins[0], coins) << coins[0]
    end
  end.reverse
end

other_coins = [10, 7, 1]
#make_change_it(14, other_coins)

p make_change_3(14, other_coins)
