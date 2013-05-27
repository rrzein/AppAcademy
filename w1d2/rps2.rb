#ask the user for an input
#compare the input with the computer's input
#print out whether you win or lose
#loop it again
def rps(user_weapon)
  weapons = ["rock", "paper", "scissors"]
  computer_weapon = weapons.shuffle.last

  if win?(user_weapon, computer_weapon)
    return "#{computer_weapon}, Win!"
  elsif lose?(user_weapon, computer_weapon)
    return "#{computer_weapon}, Lose!"
  else
    return "#{computer_weapon}, Draw!"
  end

end

def win? (your_weapon, computer_weapon)
  return true if [your_weapon, computer_weapon] == ["paper", "rock"]
  return true if [your_weapon, computer_weapon] == ["rock", "scissors"]
  return true if [your_weapon, computer_weapon] == ["scissors", "paper"]

  false
end

def lose? (your_weapon, computer_weapon)
  return true if [your_weapon, computer_weapon] == ["rock", "paper"]
  return true if [your_weapon, computer_weapon] == ["scissors", "rock"]
  return true if [your_weapon, computer_weapon] == ["paper", "scissors"]

  false
end

def draw? (your_weapon, computer_weapon)
  return true if your_weapon == computer_weapon

  false
end

loop do
puts "Enter your choice of weapon: Rock, Paper, or Scissors."
your_weapon = gets.downcase.chomp

puts rps(your_weapon)
end