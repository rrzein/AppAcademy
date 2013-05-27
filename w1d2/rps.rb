#ask the user for an input
#compare the input with the computer's input
#print out whether you win or lose
#loop it again
def rps(user_weapon)
  weapons = ["rock", "paper", "scissors"]
  computer_weapon = weapons.shuffle.last

  if user_weapon == "rock"
    case computer_weapon
    when "rock"
      return "Rock, Draw!"
    when "paper"
      return "Paper, Lose!"
    when "scissors"
      return "Scissors, Win!"
    end
  elsif user_weapon == "paper"
    case computer_weapon
    when "rock"
      return "Rock, Win!"
    when "paper"
      return "Paper, Draw!"
    when "scissors"
      return "Scissors, Lose!"
    end
  elsif user_weapon == "scissors"
    case computer_weapon
    when "rock"
      return "Rock, Lose!"
    when "paper"
      return "Paper, Win!"
    when "scissors"
      return "Scissors, Draw!"
    end
  end

end

loop do
puts "Enter your choice of weapon: Rock, Paper, or Scissors."
your_weapon = gets.downcase.chomp

puts rps(your_weapon)
end