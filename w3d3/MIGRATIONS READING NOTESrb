class CreateProducts < ActiveRecord::Migration
  def up
    #adds table called products
    create_table :products do |t|
      #string column calle name
      t.string :name
      #text column called description
      t.text :description
      #also adds primary key column by default


      #timestamp automatically has created_at and updated_at columns
      t.timestamps
    end
  end

  def down
    #defines how to undo the migration... drops the table products
    drop_table :products
  end
end

class AddReceiveNewsletterToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      #adds receive newsletter columns to users table, sets default to false (for new users)
      t.boolean :receive_newsletter, :default => false
    end
    User.each do |user|
      #existing users have the receive_newsletter value set to true (already opted in)
      user.receive_newsletter = true
      user.save!
    end
  end

  def down
    remove_column :users, :receive_newsletter
  end
end

#change method
class CreateProducts < ActiveRecord::Migration
  #smarter way than writing drop method
  def change
    #method knows how to migrate your database and reverse it when the migration is rolled back
    #can run up/down as before
    create_table :products do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

#the change method won't work as well for migrations which REMOVE a column
class CreateProducts < ActiveRecord::Migration
  def change
    #can still run up, but when running DOWN, the migration won't know to add back the "description" column we ran below because it hasn't recorded the type of the column
    #products refers to the table, "description" refers to a column
    remove_column :products, :description
  end
end

#creating tables
#creates pdocuts table
#object rielded to the block allows you to create columns on the table
create_table :products do |t|
  #creates column called name
  #also creates implicit id column

  #you pass a symbol which supplies the name of the column (like :name belwow)
  t.sring :name
end

#changing tables
#similar to create_table
change_table :products do |t|
  #removes the description and name columns
  t.remove :description, :name
  #creates a part_number string column
  t.string :part_number
  #adds to index to part_number string column
  t.index :part_number
  #renames upcode column to upc_code
  t.rename :upcode, :upc_code
end
#NOTE change_table is NOT reversible, even if you only do reversible things inside it

#better to use different ActiveRecord::Migration methods that are reversible, like:
add_column
add_index
add_timestamps
create_table
remove_timestamps
rename_column
rename_index
rename_table
#THE ABOVE can be used in def change

timestamps method will automatically add :created_at and :updated_at columns

#If you make a mistake, you'll have to ROLLBACK migrations. You can't just edit an old or existing migration and run the migration again. (Call DOWN)

#Don't edit old migrations. Rails keeps track of the migration timestamp and not the contents of the migration.

#You should write a new migration that performs the changes you requrie.
#Editing a newly generated migration that has not yer been committed to source control is relatively harmless.

#The Schema File
#db/schema.rb is the authoritative source for your database schema
#ActiveRecord generates this by examining the database each time migrations are run
#not designed to be edited. represents the current state of the database

#schema file should be checked into source control and tracked

#Check the changes that result from running rake db:migrate whenever you write a new migration