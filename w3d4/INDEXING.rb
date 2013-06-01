INDEXING
Indexing Foreign Keys
-Proper indexing is important for fast table lookup
-If you look up values through anything other than an index, you may have to read every row till you find "the one"

class User < ActiveRecord::Base
  has_many :conversations
end

class Conversation < ActiveRecord::Base
  belongs_to :user
end

-looking up the user from the conversation is quick because we can quickly look up the user's ' primary id, but not vice versa.
-it's a lot slower when a user has a fuckton of conversations'
-ActiveRecord won't automatically index conversations by the user_id' column

Solution: Ask ActiveRecord to make an index for us in the migration
class Add UserIdIndexToConversations < ActiveRecord::Migration
  def change
    add_index :conversations, :user_id
  end
end

-Not indexing foreign keys can cripple your application.
-FOREIGN KEYS SHOULD ALWAYS BE INDEXED IN THE MIGRATIONS

Uniqueness and Race Conditions
-Rails application web server only processes one web request at a time
-Scaling out/ horizontal scaling -> firing up additional app servers
-Even if you have multiple app servers, usually have a single DB server... handling multiple SQL queries simultaneously
  -Database is multi-threaded

-Executing multiple SQL updates (that is... a lot of connections trying to add new shit to our database) is no bueno.
-Theres overhead associated with the ActiveRecord uniqueness validation that first checks the table to see if anything like the update is in there, and THEN theres another SQL query to insert or update the shit you wanna put in there.

-Race condition => when two Rails app servers try to insert the same record simulataneously.
  -Don't want AppServer2' to begin check+insertion until AppServer1 has completed check+insertion.... but can't really 'make sure that happens at the application server level.
  -So enforce it at the DB level.
  -Createa a unique index in the database.

-To create index enforcing uniqueness, write migration like this:
def change
  #no two users may share an email address
  add_index :persons, :email_address, :unique => true
end

#Speeds up the enforcement of uniqueness checks, because they will be indexed.

-The database server and app servers run at different layers.
-ADD UNIQUENESS CONDITIONS AT THE DB LEVEL

-THE MIGRATION is what affects things at the DB level because it directly edits the schema... so thats why all this shit is happening in migrates.