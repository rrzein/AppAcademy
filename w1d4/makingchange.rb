def make_change(amount, coins = [25, 10, 5, 1] )
  if amount == 0
    []
  else
    if amount < coins[0]
      make_change((amount), coins[1..-1])
    else #change > amount
      make_change((amount - coins[0]), coins) << coins[0]
    end
  end
end

puts make_change(50)