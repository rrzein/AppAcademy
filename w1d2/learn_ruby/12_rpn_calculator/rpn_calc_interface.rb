

# load './rpn_calculator.rb'
# require_relative './rpn_calculator.rb'

puts "Welcome to the Reverse Polish Notation Calculator."
calc = RPNCalculator.new

loop do

  case calc.input.count
  when 0
    puts "Please enter a number."
    calc.input_string(gets.chomp)
  when 1
    puts "Please enter another number or an operator (+, -, /, *)."
    calc.input_string(gets.chomp)
  else
    puts "Please enter a number, an operator, or type 'solve' to evaluate."
    option = gets.chomp

    case option
    when "solve"
      puts "This solves to #{calc.evaluate}."
      calc.clear_stack
      break
    else
      calc.input_string(option)
    end
  end

end