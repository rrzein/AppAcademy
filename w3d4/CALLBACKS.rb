CALLBACKS
-Methods that get called at certain moments of an object's life cycle'.
-Makes it possible to write code that will run whenever an ActiveRecord object is created, saved, updated, deleted, validated, or loaded from the database.

Relational Callbacks
-Methods that can act on one model in case anything happens to another model.

-Example: Deleting a user should delete all the posts dependent on the user (or else they get widowed... a bunch of posts with no user to associate with)
class User < ActiveRecord::Base
  #here's the bread and butter: the posts are dependent on the user... this says to DESTROY them if any is to break that dependency (i.e. the user is deleted, or perhaps the foreign key on the post goes elsewhere?)
  has_many :posts, :dependent => :destroy
end

class Post < ActiveRecord::Base
  after_destroy :log_destroy_action

  def log_destroy_action
    puts 'Post destroyed'
  end
end

Other options
:dependent => :nullify -> sets the foreign key of the dependent objects to null
:dependent => :restrict -> raises an exception if associated objects exist so that you have to destroy the associated objects yourself.
-I.e. Won't let you delete the user until you delete all the posts yourself.'

-Doesnt make sense to do :dependent => :destroy on a belongs_to relationship, because why would you want to destroy a User if you destroy a post?

ACTIVE RECORD AND REFERENTIAL INTEGRITY
Validations help models enforce data integrity.
However, like anything at the application level, cannot guarantee referential integry (what is that), so you might want to use foreign key restraints in the database.
-By adding foreign key constraint, database can enforce consistency and ensure that updates do not leave widowed objects.
  -Also easier to write the application so that it handles errors at the DB level, which is where the errors would occur if we use the foreign key constraints.

  -Use a Rails plugin like foreigner--> adds foreign key support to Active Record.

-REMEMBER: THE DATABASE AND APP SERVER ARE SEPARATE PROCESSES.

CALLBACK REGISTRATION
-Hook into model lifecycle events
-things like before_validation
-implemented as ordinary methods, and then register them as callbacks through "before validation" "before save" and shit like that

Example:
class User < ActiveRecord::base
  validates :random_code, :presence => true
  #here's the "hook"... this is the bread and butter.
  #basically, before validating the instance, run "ensure random code" method
  before_validation :ensure_random_code

  protected
  #here's where you implement it like a normal method
  def ensure_random_code
    #assign a random code
    self.random_code = SecureRandom.hex(8)
  end
end

-before_validation as seen above is a CALLBACK.

-GOOD PRACTICE: declare callback methods as protected or private.
-If you leave them public, they can be called from outside the model--> violates principle of object encapsulation.

AVAILABLE CALLBACKS
-before_validation -> (good for setting forgotten fields before validating)
-after_create -> (good for doing some stuff AFTER the creation of something, like sending a confirmation email)
-after_destroy -> (good for post-destroy clean-up logic... like putting a message up when something is destroyed)

-You can also specify for the callback to only be called when doing certain things.

Example:
class CreditCard < ActiveRecord::Base
  #Strip everything but digits, so user can specify "555 234 34" or
  #"5552-3434" or both will mean "55523434"
  #here's the bread and butter below.... this says DO THE SHIT WHEN YOU CALL TO CREATE THE OBJECT, but BEFORE validation.
  #this will happen WHEN you create the object
  #BUT REMEMBER, the object is validated each time it is saved
  #so this block only happens when you FIRST create it, NOT BEFORE every time is validated and saved.
  before_validation (:on => :create ) do
    self.number = number.gsub(%r[^0-9]/, "") if attribute_present?("number")
end