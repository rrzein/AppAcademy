def stock_picker(arr)
  best_buy = arr.sort[0]
  best_sell = arr.sort.last

  puts "The best day to buy is day #{arr.index(best_buy) + 1}."
  puts "The best day to sell is day #{arr.index(best_sell) + 1}."
end

prices = [0,2,54,13,68,9]
stock_picker(prices)

# App Academy's Answer:
# def pick_stocks(prices)
#   best_pair = nil
#   best_profit = 0
#
#   prices.count.times do |buy_date|
#     prices.count.times do |sell_date|
#       # can't sell before buy
#       next if sell_date < buy_date
#
#       profit = prices[sell_date] - prices[buy_date]
#       if profit > best_profit
#         best_pair, best_profit = [buy_date, sell_date], profit
#       end
#     end
#   end
#
#   best_pair
# end
#
# Notice how App Academy takes the profit as the sell date - buy date, and looks for the highest one,
# and then gives you the profit