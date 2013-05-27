require './employee'

class Manager < Employee
  attr_reader :employees

  def initialize
    @employees = []
  end

  # avoid dupes
  def add_subordinate(employee)
   unless @employees.include?(employee)
      @employees << employee
      employee.boss = self
    end
  end

  def calculate_bonus(multiplier)
    bonus = total_employee_salaries * multiplier
  end

  private

  def total_employee_salaries
    total_salary = 0

    queue = [].push(*@employees)

    while current_employee = queue.shift
      total_salary += current_employee.salary
      if current_employee.is_a? Manager
        queue.push(*current_employee.employees)
      end
    end

    total_salary
  end

end

