def rps(user_weapon)
  win = {
    "paper" => "rock",
    "rock" => "scissors",
    "scissors" => "paper"
  }

  computer_weapon = win.keys.sample

  result = case computer_weapon
          when win[user_weapon]
            "Win"
          when user_weapon
            "Draw!"
          else
            "Lose!"
          end

  "#{computer_weapon}. #{result}!"
end

puts "Enter your weapon: Rock, Paper, or Scissors!"
my_weapon = gets.downcase.chomp
puts rps(my_weapon)