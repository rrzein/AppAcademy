class Array
  def my_each
    self.count.times { |index| yield(self[index]) }

    self
  end

end

a = [1, 2, 3].my_each { |k| puts k }
p a