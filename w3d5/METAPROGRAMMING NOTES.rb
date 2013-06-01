METAPROGRAMMING IN RUBY
SEND
send(symbol [,args...])
symbol is a method
disregards whether a method is public or private

Define_method and its weirdness:

Define_method is CALLED ON A CLASS,
but CREATES an INSTANCE METHOD.
It must be called WITHIN the class definition.
It MUST be called implicitly.
(cannot call self.define_method)

Always want to make sure you're calling' define_method on a class

CLASSES are ALSO objects.

Class Instance Variables
class Dog
  #instance variable used in class context... "self" is a class
  #@dog_count is an instance variable of class Dog
  @dog_count = 0

  #overriding what was before Dog.new
  def self.new
    #super means to call the method as it was before
    new_dog = super

    #increment the dog count up one
    @dog_count += 1

    #return the newly created dog
    new_dog
  end
end