ASSOCIATIONS

Goals:
Declare associations between Active Record models
Understand the various types of Active Record associations
Use the methods added to your models by creating associations

Questions:
What is the difference between has_many and belongs_to? Which table holds a foreign key into the other table?
Practice translating has_many, belongs_to, and has_many :through into SQL

class CreateCoursesAndProfessorsTables < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.string :thesis_title

      t.timestamps
    end

    create_table :courses do |t|
      t.string :course_name
      t.integer :professor_id
      #contains values that are foreign keys to the professors table
    end
  end
end

#to find the professor
Professor.find(course.professor_id)
#to find courses a professor is teaching
Course.where(:professor_id => prof.id)

#ActiveRecord makes easier through associations
#Associations tell AR that there is a connection between the two models

class Course < ActiveRecord::Base
  belongs_to :professor
end

class Professor < ActiveRecord::Base
  has_many :courses
end

course.professor -> #the professor for a course
prof.courses -> #array of the courses a professor teaches

#six types of associations
#belongs_to
#has_one
#has_many
#has_many :through
#has_one :through
#has_and_belongs_to_many

belongs_to
#one-to-one connection with another model
#each instance of the declaring model "belongs to" one instance of the other model
#i.e. one order assigned to one
#MUST use the singular term
  class Order < ActiveRecord::Base
    belongs_to :customer
  end

order.customer
#SELECT *
#FROM customers
#WHERE customers.id = #{order.customer_id}

has_one
#one-to-one conncetion with another model-- each instance of a model contains or possess one instance of another model
#i.e. each supplier has only one account
  class Supplier < ActiveRecord::Base
    has_one :account
  end

  supplier.account
  #SELECT *
  #FROM accounts
  #WHERE accounts.supplied_id = #{supplier.id}

belongs_to vs has_one
#belongs_to defined on entity that has foreign key column referencing associated object.. WE define OURSELVES by the OTHER thing
#has_one used when one entity is referred to by another... OTHER entity holds a foreign key to our object-- the OTHER thing defines itself BY US
  #-one of something is yours

has_many
#like has_one, but tells ActiveRecord to anticipate there may be several associated records
#one-to-many conection with another model
#usually found on the 'other side' of a belongs_to association
#each instance of the model has zero or more instances of another model
#the name of the other model is pluralized when declaring has_many
#customers and many orders:
  class Customer < ActiveRecord::Base
    has_many :orders
  end

  customer.orders
  #SELECT *
  #FROM orders
  #WEHRE orders.customer_id = #{customer.id}

has_many :through Association
#indirect relations
#example: Physicians, Appointments, Patients

class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, :through => :appointments
end

class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end

class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, :through => :appointments
end

#has_many :through association sets up many-to-many connection with another model...
#indicates that the declaring model can be matched with zero or more instances of another model by proceeding through a third model

physician.patients #array of patients
# SELECT patients.*
# FROM patients
# JOIN appointments
# ON patients.id = appointments.patient_id
# WHERE appointments.physician_id = #{physician_id}

patient.physicians #array of physicians
# SELECT physicians
# FORM physicians
# JOIN appointments
# ON physicians.id = appointments.physician_id
# WHERE appointments.patient_id = #{patient.id}

has_one :through Association
#same as has_many :through, but tells ActiveRecord that only one record will be returned, so don't put it in an array
#there is no belongs_to :through

has_and_belongs_to_many Association
#many-to-many association without referring to the intervening join table
#shortcut to writing has_many :through associations
#sometimes used, but not advised

What is the difference between belongs_to and has_one?
#in belongs_to, you have a FOREIGN KEY that references another model class. that is, you are the DRIVER'S LICENSE and you have a CUSTOMER_ID which refers to a MODEL object that ist he DRIVER
#has_one is a one-to-one relationship in which another MODEL object has a foreign key that references YOU

Why would a belongs_to_many association not make sense, when a has_many does?
#It doesn't make sense for you to have foreign keys that reference a BUNCH of different objects, when those objects really should REFERENCE YOU.
#Therefore, has_many refers to a bunch of objects that have a FOREIGN KEY THAT REFERENCES ITSELF.