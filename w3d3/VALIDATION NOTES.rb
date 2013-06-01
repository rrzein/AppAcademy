VALIDATIONS

Make sure no garbage comes in

#new_record? instance method will determine whether an object is already in the database or not

#Always use save! unless you are going to explicity check if the validations failed.
#Otherwise you may silently fail to save records.

valid? and invalid?
#used by Rails
#triggers your validations and returns true if no errors were found in the object
#false if errors found

class Person < ActiveRecord::Base
  validates :name, :presence => true
end

Person.create(:name => "John Doe").valid? #=> true
Person.create(:name => nil).valid? #=> false

Errors
#if invalid, get a hash-like object (really ActiveMode::Errors)...
#keys are attribute names, values are an array of all the errors for the attribute
#empty array returned if no errors found

#access errors through errors instance method
#errors method only useful AFTER validations run, because it does not trigger validations itself.

#To get array of human readable messages, call record.errors.full_messages

Validation Helpers
presence
#most commone
#validates that the specified attributes are not empty
#uses blank? method to check if the value is either nil or a blank string

class Person < ActiveRecord::Base
  # must have name, login, and email
  validates :name, :login, :email, :presence => true # -> true
end

#make sure that an association is present
class LineItem < ActiveRecord::Base
  belongs_to :order

  validates :order, :presence => true
end

#DONT'T CHECK FOR THE PRESENCE OF THE FOREIGN KEY, check the presence of the ASSOCIATED OBJECT

uniqueness
#validates that the attribute's value is unique in the database
class Account < ActiveRecord::Base
  #no two accounts with the same email
  validates :email, :uniqueness => true
end

#:scope option to limit the uniqueness check
class Holiday < ActiveRecord::Base
  #no two holidays with the same name for a single year
  validates :name, :uniqueness => { :scope => :year,
    :message => "should happen once per year" }
end

format
#validates the attributes' values by testing whether they match a given regular expression, which is specific using the :with option

class Product < ActiveRecord::Base
  validates :legacy_code, :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed" }

length
#validates the length of the attributes' values. lots of options for specifying length constraints

class Person < ActiveRecord::Base
  validates :name, :length => { :minimum => 2 }
  validates :bio, :length => { :maximum => 500 }
  validates :password, :length => { :in => 6..20 }
  validates :registration_number, :length => { :is => 6 }
end

#Length cosntraint options
:minimum - #cannot have less than
:maximum - #cannot have more than
:in (or :within) = #must be included in a given interval... value must be a range
:is - #length must be equal to given value

#personalize messages using :wrong_length, :too_long, :too_short options, and %{count} for placeholder for number corresponding to length constraint being used

:tokenizer #=> splits the values in different way to count characters

numericality
#validates numeric input
class Student < ActiveRecord::Base
  validates :sat_math, :sat_verbal, :numericality => {
    :allow_nil => true,
    :greater_than_or_equal_to => 200,
    :less_than_or_equal_to => 800,
    :only_integer => true
  }

inclusion
#validates the attribuets' values are included in a given set
class Coffee < ActiveRecord::Base
  validates :size, :inclusion => { :in => %w(small medium large),
    :message => "%{value} is not a valid size" }
  end

Common Validation Options
:allow_nil / :allow_blank
:allow_nil - skips validation when the value being validated is nil
class Coffee < ActiveRecord::Base
  validates :size, :inclusion =< { :in => %w(small medium large),
    :message => "%{value} is not a valid size" }, :allow_nil => true
  end

:allow_blank - lets the validation pass if the attribute's value' is blank?, like nil or an empty string

class Topic < ActiveRecord::Base
  validates :title, :length => { :is => 5 }, :allow_blank => true
end

:allow_nil/ :allow_blank is ignored by the presence validator

Conditional Validation
Use :if and :unless--takes a symbol, a string, or a Proc
# Use :if when you want to specify when the validation SHOULD happen
# Use :unles when you want to specify when the validation SHOULD NOT happen
class Order < ActiveRecord::Base
  #the validation below only happens when paid_with_card? method is true
  validates :card_number, :presence => true, :if => :paid_with_card?

  #paid with card method assocated with symbol :paid_with_card above
  def paid_with_card?
    payment_type == "card"
  end
end

Writing Custom Validation Logic
#can write your own validator classes or validation methods
Custom Validators
#classes that extend ActiveMode::Validator
#implement a validate method-> takes a record as an argument and performs the validation on it
#use validates_with to call the custom validator

class MyValidator < ActiveModel::Validator
  #implement a validate method... takes a record as the argument to validate
  def validate(record)
    #validate is passed the 'Person' instance to validate through the "record" parameter

    unless record.name.starts_with? 'X'
      record.errors[:name] << "Need a name starting with X please!"
    end
  end
end

class Person < ActiveRecord::Base
  validates_with MyValidator
end

#for the built-in validator syntax, extend ActiveModel::EachValidator
class EmailValidator < ActiveModel::EachValidator
  CRAZY_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, attribute_name, value)
    unless value =~ CRAZY_EMAIL_REGEX
      #we can use 'EachValidator#options' to access custom options passed to the validator
      record.errors[attribute_name] << (options[:message] || "is not an email")
    end
  end
end

class Person < ActiveRecord::Base
  #Rails knows ':email' means 'EmailValidator'
  validates :email, :presence => true, :email => true
  #not required, but mnust also be an email
  validates :backup_email, :email => {:message => "isn't even valid" }
end

Custom Methods
#can create methods that verify state of your models and add messages to errors collection when they are invalid
#methods must be REGISTERED using the validate class method.. pass in symbols for validation methods' name
#can pass more than one symbol for each class method and the validations will be run in the same order they were registered

class Invoice < ActiveRecord::Base
  #registers the method name with the validate class method
  validate :expiration_date_cannot_be_in_the_past,
  :discount_cannot_be_greater_than_total_value

  #custom methods that verify the state of models
  def expiration_date_cannot_be_in_the_past
    if !expiration_date.blank? and expiration_date < Date.today
      #add messages to the errors collection
      errors[:expiration_date] << "can't be in the past"
    end
  end

  def discount_cannot_be_great_than_total_value
    if discount > total_value
      errors[:discount] << "can't be greater than total value"
    end
  end

end