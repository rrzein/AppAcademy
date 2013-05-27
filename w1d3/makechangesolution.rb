def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0

  best_change = nil
    coins.sort.reverse.each_with_index do |coin, index|
      next if coin > amount

      remaining_coins = make_change(amount - coin, coins[index..-1])
      this_change_perm = [coin] + remaining_coins

      if (best_change.nil?) || (this_change_perm.count < best_change.count)
        best_change = this_change_perm
      end
    end

  best_change
end

p make_change(60)