#new attr_accessor

class Object
	def new_attr_accessor(*attributes)
		attributes.each do |attribute|
		#set the variable
			var_name = "@#{attribute}"

      #value below is the argument that attribute= needs
			define_method("#{attribute}=") do |value|
				instance_variable_set(var_name, value)
			end

      #don't need to set an argument here
			#get the variable
			define_method("#{attribute}") do
				instance_variable_get(var_name)
			end

		end
	end
end

#some notes about SEND and define_method you define send's method
#send(symbolofthemethodname) as a method in the class... and it's usually
#private

#define_method is called within the class
#the first ARGUMENT inside define_method, which is a symbol, is a method that is called on the instance objectæ

#take 2
class Object
	def new_attr_accessor(*attributes)
		attributes.each do |attribute|

			attribute_name = "@#{attribute}"

			#set the method
			define_method("#{attribute}=") do |value|
				instance_variable_set(attribute_name, value)
			end

			define_method("#{attribute}") do
				instance_variable_get(attribute_name)
			end
		end
	end
end