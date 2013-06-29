class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :friend_id
      t.integer :photo_id

      t.timestamps
    end
  end
end
