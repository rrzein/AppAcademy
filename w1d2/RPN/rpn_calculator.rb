class RPNCalculator
  attr_accessor :stack, :input

  def initialize
    @stack = [0]
    @input = []
  end

  def push(number)
    @stack << number.to_f
  end

  def input_string(item)
    @input << item
  end

  def pop
    value = @stack.pop
    raise "calculator is empty" if value.nil?
    value
  end

  def plus
    added = pop + pop
    @stack << added
  end

  def minus
    num1 = pop
    num2 = pop
    @stack << num1 - num2
  end

  def times
    num1 = pop
    num2 = pop
    @stack << num1 * num2
  end

  def divide
    numerator = pop
    denominator = pop
    @stack << (numerator.to_f / denominator.to_f)
  end

  def value
    @stack.last
  end

  def tokens(string)
    string.split.map do |item|
      case item
      when "+", "-", "/", "*"
        item.to_sym
      else
        item.to_f
      end
    end
  end

  def evaluate(string)
    tokens(string).each do |item|
      case item
      when :+
        plus
      when :-
        minus
      when :*
        times
      when :/
        divide
      else
        push item
      end
    end
    value
  end

  def clear_stack
    @input = []
  end

  def string_stack
    @input.join(" ")
  end

end