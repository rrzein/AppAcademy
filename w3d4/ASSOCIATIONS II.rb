ASSOCIATIONS II
-Sometimes a model will have a relation to itself

Self-joining association example
class Employee < ActiveRecord::Base
  #class name tells ActiveRecord what records to find
  has_many :subordinates, :class_name => "Employee",
  #specify foreign key to be much more descriptive
  :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "Employee"
end

#might have to specify BOTH the foreign key and the primary key
#schema:
#emails: id|from_email|to_email|text
#users: id|email_address

class User < ActiveRecord::Base
  has_many :sent_emails, :class_name => "Email", :foreign_key => "from_email", :primary_key => "email_address"
  has_many :received_emails, :class_name => "Email", :foreign_key => "to_email", :primary_key => "email_address"
end

# SELECT *
# FROM emails
# WHERE emails.from_email = #{self.email_address}

class Email < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "from_email", :primary_key => "email_address"
  belongs_to :recipient, :class_name => "User", :foreign_key => "to_email", :primary_key => "email_address"
end
#
# SELECT *
# FROM users
# WHERE users.email_address= #{self.to_email}

SOURCE OPTION
:source
explicitly set the name of the SECOND association you are trying to access through has_many :through

Example

class Pet < ActiveRecord::Base
  belongs_to :owner
end

class Owner < ActiveRecord::Base
  has_many :pets
end

class Veterinarian < ActiveRecord::Base
  has_many :clients, :class_name => "Owner"
  #first association: clients
  #second association: patients (source is the pets table for the vet)
  has_many :patients, :through => :clients, :source => :pets
end
