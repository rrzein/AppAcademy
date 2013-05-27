hidden_number = rand(1..101)
guesses = 0

loop do
  puts "Please guess a number between 1 and 100."
  input = gets.chomp.to_i
  guesses += 1

  if (input < 0) || (input > 100)
    puts "Invalid input. Please put in a number between 1 and 100."
  elsif input > hidden_number
    puts "Too high. This is guess #{guesses}."
  elsif input < hidden_number
    puts "Too low. This is guess #{guesses}."
  else
    puts "Correct! That was guess #{guesses}."
    break
  end

end