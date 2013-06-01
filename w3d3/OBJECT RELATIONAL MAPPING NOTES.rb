Object Relational Mapping
#
# -System that translates between SQL records and Ruby objects
# -Translates rows from SQL tables into Ruby objects on fetch (easier!)
# -Translates Ruby objects back to rows on save
#   -It's like the Ruby' SQL translator!
#

#Properties and relatipnships of the objects in an application can be easily stored and retrieved from a database without writing SQL statements directly and with less overall database access code

#ActiveRecord is an ORM--map rows from a relational database into objects

#Each table has MODEL class-- represents some entity or part of the problem you're working with

#model class of the table physicians
class Physician < ActiveRecord::Base
end

#returns an array of physician objects... one for each row in the physicians table
Physician.all
#lookup the physicians with primary key (id) 101
Physician.find(101)

#creates new object
p = Physician.new

#sets the fields
p.name = "Jonas Salk"
p.college = "city College"
p.home_city = "La Jolla"

#save record to database-- ActiveRecord will insert a new row into the physicians table
p.save

#use #CREATE to create a new record and immediately save it to the db
user = User.create(:name => "David", :occupation => "Code Artist")

#destroys a record and removes it from the table
user.destroy

#Mass Assignment
#create needs you to whitelist attribuets that can be set through create by using attr_accessible

class User
  #allow 'create' to set name and occupation
  attr_accessible :name, :occupation
end

#Any attribute that has not been declared attr_accessible cannot be set through new or create methods
#Has nothing to do with attr_accessor

#Rails Console
#rails console, or rails c, to launch irb
#loads your rails application so you wont have to require your model classes manually

#::where looks up records by criteria other than primary key
#returns array of Physicians based in La Jolla
Physician.where(:home_city => "La Jolla")
#Executes:
#SELECT *
#FROM physicians
#WHERE physicians.home_city = 'La Jolla'

#multiple criteria
#kind of like an options hash of some sort
Physician.where(
  :home_city => "La Jolla",
  :college => "City College")

#May also embed SQL
Physician.where("(home_city = ?) OR (college = ?)", "La Jolla", "City College")
#each ? is filled in with subsequent arguments successively

#Search for values in a set, or within a range
#physcians at any of these three schools
#kind of like "college IN ('City College', 'Columbia', 'NYU')"
Physician.where(:college => ["City College", "Columbia", "NYU"])
#physicians with 3-9 years experience
#uses range (3..9)
Physician.where(:years_experience => (3..9))

#Rails naming convention:
#Database Table - Plural with underscores separating words (eg book_clubs)
#Model Class - Singular with first letter of each word capitalized(eg BookClub)

#Schema Conventions:
#Foreign keys - follow the namign patten singularized_table_name_id (e.g. item_id, order_id)
#Primary keys - Will use an integer column named id as the table's primary key