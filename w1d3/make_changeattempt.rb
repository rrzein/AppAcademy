def make_change(amount, coins = [25, 10, 5, 1])
  if coins.include?(amount)
    [amount]
  else
    change_list = []
    coins.each do |coin|
      if amount > coin
       change_list  << (make_change(amount - coin, coins) + [coin])
      end
    end
  end
end

p make_change(50)