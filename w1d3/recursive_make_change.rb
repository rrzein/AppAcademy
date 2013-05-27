# def make_change(amount, coins = [25, 10, 5, 1])
#   # sum of return value arr == amount
#   if amount.zero?
#     # amount
#     []
#   else
#     coins.each do |coin|
#       p "current coin: #{coin}"
#       if amount > coin
#         p "amount = #{amount}"
#         ret = make_change(amount - coin, coins)
#         ret << ret
#         # ret << ret[-1] + ret[-2]
#       end
#     end
#   end
# end
#
# p make_change(60)
# coins[0..n]
def make_change2(amount, coins = [25, 10, 5, 1])
  if coins[0]
    count = amount / coins[0]
    amount -= amount % coins[0]
    [coins[0]]
  else
    make_change2(amount, coins[0..-2]) << (amount / coins.last)
  end
end

p make_change2(60)