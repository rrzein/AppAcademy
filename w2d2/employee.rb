class Employee
  attr_accessor :name, :title, :salary, :boss

  def calculate_bonus(multiplier)
    bonus = @salary * multiplier
  end
end