class Student
  attr_accessor :courses, :course_load

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @courses = []
    @course_load = {}
  end

  def name
    @fullname = "#{@firstname} #{@lastname}"
    @fullname
  end

  def enroll(course)
    if conflict?(course)
      raise "You're already enrolled in another course at that time."
    else
      @courses << course.course_name
      course.number_of_students += 1
      @course_load[course.department] = course.credits
    end
  end

  def conflict?(course)
    @courses.each do |enrolled_course|
      return true if Course.conflicts?(course, enrolled_course)
    end

    false
  end


end

class Course
  attr_accessor :course_name, :number_of_students, :students, :department, :credits, :days, :block

  def initialize(course_name, department, credits, days, block)
    @course_name = course_name
    @department = department
    @credits = credits
    @days = days
    @block = block
    @students = []
    @number_of_students = 0
  end

  def add_student(student)
    if @students.include?(student)
      raise "That student is already enrolled."
    else
      @students << student unless @students.include?(student)
    end
  end

  def self.conflicts?(course1, course2)
    if course1.block == course2.block
      course1.days.each do |day|
        return true if course2.days.include?(day)
      end
    end

    false
  end

end

ricky = Student.new("Ricky", "Zein")
ricky.name

ruby = Course.new("Ruby", :compsci, 3, [:mon, :tues, :wed], 1)
ricky.enroll(ruby)
puts ricky.courses
